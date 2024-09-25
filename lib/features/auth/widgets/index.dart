import 'package:f_journey/features/auth/widgets/login/login.dart';
import 'package:f_journey/features/auth/widgets/register/register.dart';
import 'package:f_journey/features/auth/widgets/register/role_selection.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key, required this.textTheme});
  final TextTheme textTheme;

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final PageController _pageController = PageController();
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
      if (showLogin) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_bg.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: SizedBox(
              height: 710,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  LoginWidget(
                    textTheme: widget.textTheme,
                    onToggle: toggleView,
                  ),
                  // RegisterWidget(
                  //   textTheme: widget.textTheme,
                  //   onToggle: toggleView,
                  // ),
                  RoleSelectionWidget(
                    textTheme: widget.textTheme,
                    onSubmit: () {},
                    onToggle: toggleView,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
