import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/utils/validators.dart';
import 'package:ict_hub_project/core/widget/custom_text_field_widget.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_state.dart';

/// Sign up screen. On success the API emails a code and we move on to
/// the verification screen.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _handleSignUp() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthCubit>().register(
      fullName: _nameController.text,
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    switch (state) {
      case RegisterSuccessState(:final email):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification code sent to $email')),
        );
        context.pushNamed(Routes.otpScreen, queryParameters: {'email': email});
      case AuthFailureState(:final message):
        ScaffoldMessenger.of(context).showSnackBar(
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
                    'Create account',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  CustomTextFieldWidget(
                    controller: _nameController,
                    label: 'Full name',
                    validator: Validators.fullName,
                  ),
                  const SizedBox(height: 18),
                  CustomTextFieldWidget(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 18),
                  CustomTextFieldWidget(
                    controller: _passwordController,
                    label: 'Password',
                    isPassword: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 18),
                  CustomTextFieldWidget(
                    controller: _confirmPasswordController,
                    label: 'Confirm password',
                    isPassword: true,
                    validator: _validateConfirmPassword,
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoadingState;
                      return FilledButton(
                        onPressed: isLoading ? null : _handleSignUp,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Sign up'),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
