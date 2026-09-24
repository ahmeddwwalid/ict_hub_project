import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/domain/models/login_response_model.dart';

abstract class AuthRepo {
  /// Logs in and saves the returned tokens to local storage.
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  });

  /// Creates the account; the API then emails a verification code.
  Future<Either<Failure, Unit>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Either<Failure, Unit>> resendOtp({required String email});

  /// Removes the saved tokens.
  Future<void> logout();
}
