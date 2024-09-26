import 'package:flutter/material.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key, required this.textTheme, required this.child});
  final TextTheme textTheme;
  final Widget child;
  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/login_bg.png', fit: BoxFit.cover),
        Center(
          child: SizedBox(
            height: 730,
            child: widget.child,
          ),
        )
      ],
    ));
  }
}
