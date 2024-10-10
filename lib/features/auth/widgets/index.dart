import 'package:f_journey/features/auth/widgets/login/login.dart';
import 'package:f_journey/features/auth/widgets/register/driver.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key, required this.textTheme, this.view});
  final TextTheme textTheme;
  final String? view;

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final PageController _pageController = PageController();
  bool showLogin = true;

  @override
  void initState() {
    super.initState();

    if (widget.view == 'driver-license') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          showLogin = false;
          _pageController.jumpToPage(1);
        });
      });
    }
  }

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
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoginWidget(
            textTheme: widget.textTheme,
            onToggle: toggleView,
          ),
          DriverLicenseRegisterWidget(
            textTheme: widget.textTheme,
            onSubmit: () {},
            onToggle: toggleView,
          ),
        ],
      ),
    );
  }
}
