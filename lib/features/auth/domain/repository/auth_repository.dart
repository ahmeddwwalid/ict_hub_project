import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/error/failure.dart';
import 'package:ict_hub_project/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, Unit>> signup(
      String name, String email, String password);
  Future<Either<Failure, UserEntity>> verifyOtp(String email, String otp);
}
