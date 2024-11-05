import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeDriverWidget extends StatefulWidget {
  const WelcomeDriverWidget({super.key});

  @override
  State<WelcomeDriverWidget> createState() => _WelcomeDriverWidgetState();
}

class _WelcomeDriverWidgetState extends State<WelcomeDriverWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageOpacity;
  late Animation<double> _textOpacity;
  late Animation<double> _descriptionOpacity;
  late Animation<double> _noteOpacity;
  late Animation<double> _buttonOpacity;

  bool _isAgreeTerms = false;
  final bool _isDarkMode = false; // State variable for dark mode

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _imageOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );
    _descriptionOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
      ),
    );
    _noteOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
      ),
    );
    _buttonOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('Chào mừng bạn!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showSettingsBottomSheet(context);
            }, // Show the bottom sheet
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image with fade-in effect
            FadeTransition(
              opacity: _imageOpacity,
              child: Image.asset(
                'assets/images/checking_image.png',
                width: 260,
              ),
            ),
            const SizedBox(height: 32),
            // Welcome text with fade-in effect
            FadeTransition(
              opacity: _textOpacity,
              child: Text(
                'Tiến hành đăng ký hồ sơ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 8),
            // Description with fade-in effect
            FadeTransition(
              opacity: _descriptionOpacity,
              child: Text(
                'Bạn vui lòng cung cấp thông tin cá nhân để tụi mình xác thực và hoàn thiện hồ sơ của bạn nhé!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            // Note section
            FadeTransition(
              opacity: _noteOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lưu ý:',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '- Bạn cần cung cấp ảnh chụp bằng lái xe và cà vẹt xe để xác minh.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '- Thông tin của bạn sẽ được bảo mật theo chính sách bảo mật của chúng tôi.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  // Terms agreement checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _isAgreeTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAgreeTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Tôi đồng ý với các điều khoản và chính sách bảo mật của ứng dụng.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Okay button with fade-in effect
            FadeTransition(
              opacity: _buttonOpacity,
              child: FilledButton(
                onPressed: _isAgreeTerms
                    ? () {
                        // Navigate when terms are agreed
                        context.push(RouteName.driverRegister);
                      }
                    : null,
                child: const Text('Okay ^~^'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
