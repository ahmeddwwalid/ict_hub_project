import 'package:flutter/foundation.dart';

class Endpoints {
  static const String _apiUrl = "https://accessories-eshop.runasp.net/api/";

  /// The API has no CORS headers, so browsers block direct calls. In a
  /// debug web run (`flutter run -d chrome`) the dev server proxies /api/
  /// to it (see web_dev_config.yaml; profile/release runs don't proxy).
  /// Everywhere else the app calls the API directly.
  static final String baseUrl = kIsWeb && kDebugMode
      ? "${Uri.base.origin}/api/"
      : _apiUrl;

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String verifyEmail = "auth/verify-email";
  static const String resendOtp = "auth/resend-otp";

  static const String products = "products";

  static const String cart = "cart";
  static const String cartItems = "cart/items";
}
