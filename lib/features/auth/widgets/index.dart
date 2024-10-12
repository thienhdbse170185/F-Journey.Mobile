import 'package:f_journey/features/auth/widgets/login/login.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key, required this.textTheme, this.view});
  final TextTheme textTheme;
  final String? view;

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: LoginWidget(
          textTheme: widget.textTheme,
        ));
  }
}
