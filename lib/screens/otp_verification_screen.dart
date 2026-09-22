import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';
import 'product_screen.dart';

/// OTP Verification screen. On success, clears the nav stack and
/// goes to the Product screen (user is now fully logged in).
class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  bool _isVerifying = false;
  bool _isResending = false;
  int _resendCooldown = 0;
  Timer? _timer;

  // Fixed mock code so you can test the flow without a real
  // email/SMS provider. Replace with real verification later.
  static const _mockOtp = '1234';

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() {
      _resendCooldown = 30;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown <= 1) {
        timer.cancel();
        setState(() {
          _resendCooldown = 0;
        });
      } else {
        setState(() {
          _resendCooldown--;
        });
      }
    });
  }

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter the code';
    }
    if (value.length != 4) {
      return 'Code must be 4 digits';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Code must contain only numbers';
    }
    return null;
  }

  Future<void> _handleVerify() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() {
      _isVerifying = true;
    });

    // Mock verification — simulates a network request.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isVerifying = false;
    });

    final enteredCode = _otpController.text.trim();
    if (enteredCode == _mockOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email verified successfully!')),
      );

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ProductScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid code. Correct code is: $_mockOtp'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  Future<void> _handleResend() async {
    setState(() {
      _isResending = true;
    });

    // Mock resend call — simulates a network request.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isResending = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('✓ Code resent to ${widget.email}'),
            const SizedBox(height: 8),
            const Text(
              '📌 Demo Code: 1234',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    _startCooldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify your email',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.getTextColor(context),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the 4-digit code sent to ${widget.email}',
                  style: TextStyle(
                    color: ThemeColors.getTertiaryTextColor(context),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),

                Text(
                  'Verification code',
                  style: TextStyle(
                    color: ThemeColors.getSecondaryTextColor(context),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  validator: _validateOtp,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isVerifying ? null : _handleVerify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.getTextColor(context),
                      disabledBackgroundColor: ThemeColors.getSecondaryTextColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isVerifying
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: _resendCooldown > 0
                      ? Text(
                          'Resend code in $_resendCooldown s',
                          style: const TextStyle(color: Colors.white38),
                        )
                      : TextButton(
                          onPressed: _isResending ? null : _handleResend,
                          child: _isResending
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ThemeColors.getSecondaryTextColor(context),
                                  ),
                                )
                              : const Text(
                                  'Resend code',
                                  style: TextStyle(
                                    color: ThemeColors.getTextColor(context),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

