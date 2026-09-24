sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

/// Logged in; the token is already saved to local storage.
class LoginSuccessState extends AuthState {}

/// Account created; a verification code was emailed to [email].
class RegisterSuccessState extends AuthState {
  final String email;

  RegisterSuccessState({required this.email});
}

class VerifyEmailSuccessState extends AuthState {}

class ResendOtpSuccessState extends AuthState {}

class LogoutState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState({required this.message});
}
