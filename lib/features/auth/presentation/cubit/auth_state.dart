part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(UserEntity user) = _Success;
  const factory AuthState.error(String message) = _Error;
  const factory AuthState.otpSent(String email) = _OtpSent;
  const factory AuthState.loggedOut() = _LoggedOut;
}
