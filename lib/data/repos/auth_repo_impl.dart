import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/constant/local_keys.dart';
import 'package:ict_hub_project/core/local_storage/base_local_storage.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/data/data_source/abstract/auth_data_source.dart';
import 'package:ict_hub_project/domain/models/login_response_model.dart';
import 'package:ict_hub_project/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this._dataSource, required this._localStorage});
  final AuthDataSource _dataSource;
  final BaseLocalStorage _localStorage;

  @override
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dataSource.login(
        email: email,
        password: password,
      );
      final result = response.map(LoginResponse.fromJson);
      if (result case Right(value: final login)) {
        await _saveTokens(login);
      }
      return result;
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }

  Future<void> _saveTokens(LoginResponse login) async {
    await _localStorage.setString(LocalKeys.accessToken, login.accessToken);
    final refreshToken = login.refreshToken;
    if (refreshToken != null) {
      await _localStorage.setString(LocalKeys.refreshToken, refreshToken);
    }
  }

  @override
  Future<Either<Failure, Unit>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final response = await _dataSource.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    return response.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    final response = await _dataSource.verifyEmail(email: email, otp: otp);
    return response.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> resendOtp({required String email}) async {
    final response = await _dataSource.resendOtp(email: email);
    return response.map((_) => unit);
  }

  @override
  Future<void> logout() {
    return _localStorage.clear(
      allowList: {LocalKeys.accessToken, LocalKeys.refreshToken},
    );
  }
}
