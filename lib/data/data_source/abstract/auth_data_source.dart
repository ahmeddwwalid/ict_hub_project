import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';

abstract class AuthDataSource {
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Map<String, dynamic>>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Map<String, dynamic>>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Either<Failure, Map<String, dynamic>>> resendOtp({
    required String email,
  });
}
