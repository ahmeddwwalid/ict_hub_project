import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ict_hub_project/features/auth/domain/entity/user_entity.dart';
import 'package:ict_hub_project/features/auth/domain/repository/auth_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(const AuthState.initial());

  bool get isAuthenticated =>
      state.maybeMap(success: (_) => true, orElse: () => false);

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    final result = await authRepository.login(email, password);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.success(user)),
    );
  }

  Future<void> signup(String name, String email, String password) async {
    emit(const AuthState.loading());
    final result = await authRepository.signup(name, email, password);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(AuthState.otpSent(email)),
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(const AuthState.loading());
    final result = await authRepository.verifyOtp(email, otp);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.success(user)),
    );
  }

  Future<void> logout() async {
    emit(const AuthState.loggedOut());
  }
}
