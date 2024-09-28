import 'package:f_journey/core/common/widgets/dialog/loading_dialog.dart';
import 'package:f_journey/core/common/widgets/dialog/success_dialog.dart';
import 'package:f_journey/core/common/widgets/text_field.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/keyboard_util.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget(
      {super.key, required this.textTheme, required this.onToggle});

  final TextTheme textTheme;
  final VoidCallback onToggle;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isRemembered = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  bool isFormValid = false; // Cờ để kiểm tra trạng thái form

  @override
  void initState() {
    super.initState();

    // Lắng nghe thay đổi của text field để kiểm tra form validation
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      // Kiểm tra và cập nhật trạng thái hợp lệ của form
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  void _submit() {
    if (!isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid email and password.'),
        ),
      );
      return;
    }
    KeyboardUtil.hideKeyboard();
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEmailPasswordStarted(
          email: emailController.text, password: passwordController.text));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthInProgress) {
            LoadingDialog.show(context);
          } else if (state is LoginSuccess) {
            LoadingDialog.hide(context);
            SuccessDialog.show(context);
            await Future.delayed(const Duration(milliseconds: 2800));
            SuccessDialog.hide(context);
          } else if (state is LoginError) {
            LoadingDialog.hide(context);
            SnackbarUtil.openFailureSnackbar(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Column(
                key: const ValueKey<bool>(true),
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nút back để quay lại màn hình Get Started
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Quay lại màn hình trước đó
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 34,
                    ),
                  ),
                  Text('Login',
                      style: widget.textTheme.headlineLarge
                          ?.copyWith(fontSize: 32, color: Colors.black)),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your email and password to log in',
                    style: widget.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                      isPassword: false),
                  const SizedBox(height: 24),
                  CustomTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      isObscure: !showPassword,
                      isPassword: true,
                      suffixIcon: IconButton(
                          icon: Icon(showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          })),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: isRemembered,
                              onChanged: (value) {
                                setState(() {
                                  isRemembered = value!;
                                });
                              }),
                          Text(
                            'Remember me',
                            style: widget.textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(RouteName.forgotPw);
                        },
                        child: Text(
                          'Forgot password?',
                          style: widget.textTheme.bodyMedium?.copyWith(
                            color: Colors.purple.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.purple.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Log In',
                      style: widget.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: widget.textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onToggle,
                        child: Text(
                          'Sign Up',
                          style: widget.textTheme.bodyMedium?.copyWith(
                            color: Colors.purple.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
