import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/domain/repos/auth_repo.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this._repo}) : super(AuthInitialState());

  final AuthRepo _repo;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    final result = await _repo.login(email: email, password: password);
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.msg)),
      (_) => emit(LoginSuccessState()),
    );
  }

  /// [fullName] is split into the first and last name the API expects.
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final parts = fullName.trim().split(RegExp(r'\s+'));
    final result = await _repo.register(
      firstName: parts.first,
      lastName: parts.length > 1 ? parts.sublist(1).join(' ') : parts.first,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.msg)),
      (_) => emit(RegisterSuccessState(email: email)),
    );
  }

  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(AuthLoadingState());
    final result = await _repo.verifyEmail(email: email, otp: otp);
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.msg)),
      (_) => emit(VerifyEmailSuccessState()),
    );
  }

  Future<void> resendOtp({required String email}) async {
    final result = await _repo.resendOtp(email: email);
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.msg)),
      (_) => emit(ResendOtpSuccessState()),
    );
  }

  Future<void> logout() async {
    await _repo.logout();
    emit(LogoutState());
  }
}
