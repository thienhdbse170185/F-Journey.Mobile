import 'package:f_journey/core/common/widgets/dialog/loading_dialog.dart';
import 'package:f_journey/core/common/widgets/dialog/success_dialog.dart';
import 'package:f_journey/core/common/widgets/text_field.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/keyboard_util.dart';
import 'package:f_journey/core/utils/reg_util.dart';
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
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _submit() {
    KeyboardUtil.hideKeyboard();
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEmailPasswordStarted(
          email: emailController.text, password: passwordController.text));
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              key: const ValueKey<bool>(true),
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 34,
                  ),
                ),
                Text('Login',
                    style:
                        widget.textTheme.headlineLarge?.copyWith(fontSize: 32)),
                const SizedBox(height: 8),
                Text(
                  'Enter your email and password to log in',
                  style: widget.textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                    controller: emailController,
                    labelText: 'Email',
                    isPassword: false,
                    validator: ((value) => RegUtil.validateEmail(value))),
                const SizedBox(height: 16),
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
                        }),
                    validator: ((value) => RegUtil.validatePassword(value))),
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
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () => _submit(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Log In',
                      style: widget.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.black12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or login with',
                        style: widget.textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/google.png',
                          height: 24, width: 24),
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        side: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Image.asset('assets/images/facebook.png',
                          height: 24, width: 24),
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        side: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}