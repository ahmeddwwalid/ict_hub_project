import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/utils/validators.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_state.dart';

/// Verifies the emailed code, then sends the user to log in.
class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  int _resendCooldown = 0;
  Timer? _timer;

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _resendCooldown = 30);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown <= 1) timer.cancel();
      setState(() => _resendCooldown--);
    });
  }

  void _handleVerify() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthCubit>().verifyEmail(
      email: widget.email,
      otp: _otpController.text.trim(),
    );
  }

  void _handleResend() {
    _startCooldown();
    context.read<AuthCubit>().resendOtp(email: widget.email);
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    final messenger = ScaffoldMessenger.of(context);
    switch (state) {
      case VerifyEmailSuccessState():
        messenger.showSnackBar(
          const SnackBar(content: Text('Email verified. Please log in.')),
        );
        context.goNamed(Routes.loginScreen);
      case ResendOtpSuccessState():
        messenger.showSnackBar(
          SnackBar(content: Text('Code resent to ${widget.email}')),
        );
      case AuthFailureState(:final message):
        messenger.showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: _onAuthState,
      child: Scaffold(
        appBar: AppBar(),
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
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the code we sent to ${widget.email}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 8,
                    validator: Validators.otp,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      letterSpacing: 12,
                    ),
                    decoration: const InputDecoration(counterText: ''),
                  ),
                  const SizedBox(height: 28),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoadingState;
                      return FilledButton(
                        onPressed: isLoading ? null : _handleVerify,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Verify'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: _resendCooldown > 0
                        ? Text(
                            'Resend code in $_resendCooldown s',
                            style: theme.textTheme.bodySmall,
                          )
                        : TextButton(
                            onPressed: _handleResend,
                            child: const Text('Resend code'),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
