import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/api/api_consumer.dart';
import 'package:ict_hub_project/core/network/api/status_code.dart';
import 'package:ict_hub_project/core/network/error/exceptions.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';

class DioConsumer implements ApiConsumer {
  final Dio _client;

  DioConsumer({
    required this._client,
    required String baseUrl,
    required List<Interceptor> interceptors,
  }) {
    _client.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      followRedirects: false,
      // 4xx responses come back as normal responses so their error body
      // can be read; see [_send].
      validateStatus: (status) {
        return status != null && status < StatusCodes.internalServerError;
      },
    );

    _client.interceptors.addAll(interceptors);
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _send(
      () => _client.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> post({
    required String path,
    required Object body,
    bool formDataEnabled = false,
    String? contentType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return _send(
      () => _client.post(
        path,
        options: Options(contentType: contentType, headers: headers),
        data: formDataEnabled
            ? FormData.fromMap(body as Map<String, dynamic>)
            : body,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> put({
    required String path,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _send(
      () => _client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _send(
      () => _client.delete(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  Future<Either<ServerFailure, Map<String, dynamic>>> _send(
    Future<Response<dynamic>> Function() request,
  ) async {
    try {
      final response = await request();
      final status = response.statusCode ?? 0;
      final data = response.data;

      if (status >= 200 && status < 300) {
        // Some endpoints answer with an empty body or a bare list.
        return Right(data is Map<String, dynamic> ? data : {'data': data});
      }
      return Left(
        ServerFailure(msg: _messageFrom(data) ?? _exceptionFor(status).msg),
      );
    } on DioException catch (error) {
      return Left(_handleDioError(error));
    }
  }

  /// The API reports errors as
  /// `{"message": "...", "errors": {"field": ["reason", ...]}}`.
  String? _messageFrom(dynamic data) {
    if (data is! Map) return null;
    final errors = data['errors'];
    if (errors is Map && errors.isNotEmpty) {
      return errors.values
          .expand((reasons) => reasons is List ? reasons : [reasons])
          .join('\n');
    }
    final message = data['message'];
    return message is String && message.isNotEmpty ? message : null;
  }

  ServerException _exceptionFor(int status) {
    switch (status) {
      case StatusCodes.badRequest:
        return const BadRequestException();
      case StatusCodes.unauthorized:
      case StatusCodes.forbidden:
        return const UnauthorizedException();
      case StatusCodes.notFound:
        return const NotFoundException();
      case StatusCodes.conflict:
        return const ConflictException();
      default:
        return const FetchDataException();
    }
  }

  ServerFailure _handleDioError(DioException error) {
    final ServerException exception;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        exception = const FetchDataException();
      case DioExceptionType.badResponse:
        exception = const InternalServerErrorException();
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        exception = kIsWeb
            ? const ServerUnreachableException()
            : const NoInternetConnectionException();
    }

    return ServerFailure(msg: exception.msg);
  }
}
