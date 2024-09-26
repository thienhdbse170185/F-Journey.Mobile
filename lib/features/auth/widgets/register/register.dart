import 'package:f_journey/core/common/widgets/text_field.dart';
import 'package:f_journey/core/utils/keyboard_util.dart';
import 'package:f_journey/core/utils/reg_util.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key, required this.textTheme, this.onToggle});

  final TextTheme textTheme;
  final VoidCallback? onToggle;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;

  void _submit() {
    KeyboardUtil.hideKeyboard();
    if (_formKey.currentState!.validate()) {
      // Perform the register action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            key: const ValueKey<bool>(false),
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 34,
                ),
              ),
              Text('Sign Up',
                  style:
                      widget.textTheme.headlineLarge?.copyWith(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                'Create a new account',
                style: widget.textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),
              // Email TextField
              CustomTextField(
                  controller: emailController,
                  labelText: 'Email',
                  isPassword: false,
                  validator: ((value) => RegUtil.validateEmail(value))),
              const SizedBox(height: 24),
              // Password TextField
              CustomTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  isObscure: !showPassword,
                  isPassword: true,
                  helperText: 'Password must be at least 6 characters long',
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
              const SizedBox(height: 24),
              CustomTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  isObscure: !showConfirmPassword,
                  isPassword: true,
                  suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  }),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.purple.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Sign Up',
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
                    "Already have an account?",
                    style: widget.textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: widget.onToggle,
                    child: Text(
                      'Log In',
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
    );
  }
}
