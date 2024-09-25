import 'package:flutter/material.dart';

class ForgotPwWidget extends StatefulWidget {
  const ForgotPwWidget({super.key, required this.textTheme});
  final TextTheme textTheme;

  @override
  State<ForgotPwWidget> createState() => _ForgotPwWidgetState();
}

class _ForgotPwWidgetState extends State<ForgotPwWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Forgot password?'),
      ),
    );
  }
}
