import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/error/failure.dart';
import 'package:ict_hub_project/features/auth/domain/entity/user_entity.dart';
import 'package:ict_hub_project/features/auth/domain/repository/auth_repository.dart';

/// Mock implementation: the backend has no auth endpoints yet, so this
/// simulates latency and accepts the demo OTP [mockOtp].
class AuthRepositoryImpl implements AuthRepository {
  static const mockOtp = '1234';

  final Map<String, String> _pendingNames = {};

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return right(UserEntity(name: email.split('@').first, email: email));
  }

  @override
  Future<Either<Failure, Unit>> signup(
      String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _pendingNames[email] = name;
    return right(unit);
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp(
      String email, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    if (otp != mockOtp) {
      return left(const Failure('Invalid code. Correct code is: $mockOtp'));
    }
    return right(UserEntity(
      name: _pendingNames[email] ?? email.split('@').first,
      email: email,
    ));
  }
}
