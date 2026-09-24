abstract class LocalKeys {
  /// Set once the user finishes (or skips) onboarding.
  static const String isOpen = "isAppOpen";

  /// Saved on login, sent as `Authorization: Bearer` by the interceptor.
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
}
