import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/app_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/constant/local_keys.dart';
import 'package:ict_hub_project/core/local_storage/base_local_storage.dart';
import 'package:ict_hub_project/core/network/api/endpoints.dart';
import 'package:ict_hub_project/core/network/api/status_code.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors({required this._localStorage});

  final BaseLocalStorage _localStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _localStorage.getString(LocalKeys.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (kDebugMode) {
      log('REQUEST[${options.method}] => PATH: ${options.path}');
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      log(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
    }

    // An expired or rejected token: drop it and send the user to login.
    // A wrong password on the login call itself is not a session problem.
    final isLoginCall = response.requestOptions.path == Endpoints.login;
    if (response.statusCode == StatusCodes.unauthorized && !isLoginCall) {
      await _localStorage.clear(
        allowList: {LocalKeys.accessToken, LocalKeys.refreshToken},
      );
      navigatorKey.currentContext?.goNamed(Routes.loginScreen);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      );
      if (err.response?.data != null) {
        log('Error data: ${err.response?.data}');
      }
    }
    handler.next(err);
  }
}
