import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/api/api_consumer.dart';
import 'package:ict_hub_project/core/network/api/endpoints.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/data/data_source/abstract/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({required this._apiConsumer});
  final ApiConsumer _apiConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) {
    return _apiConsumer.post(
      path: Endpoints.login,
      body: {'email': email, 'password': password},
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    return _apiConsumer.post(
      path: Endpoints.register,
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyEmail({
    required String email,
    required String otp,
  }) {
    return _apiConsumer.post(
      path: Endpoints.verifyEmail,
      body: {'email': email, 'otp': otp},
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resendOtp({
    required String email,
  }) {
    return _apiConsumer.post(path: Endpoints.resendOtp, body: {'email': email});
  }
}
