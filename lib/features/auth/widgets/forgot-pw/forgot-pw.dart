import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/features/auth/widgets/components/text_field_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ForgotPwWidget extends StatefulWidget {
  const ForgotPwWidget({super.key, required this.textTheme});
  final TextTheme textTheme;

  @override
  State<ForgotPwWidget> createState() => _ForgotPwWidgetState();
}

class _ForgotPwWidgetState extends State<ForgotPwWidget> {
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
        title: const Text('Quên mật khẩu'),
        actions: [
          IconButton(
            onPressed: () {
              showSettingsBottomSheet(context);
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 64, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/checking_image.png',
                width: 260,
              ),
              const SizedBox(height: 32),
              Text('Cung cấp Email', style: widget.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Nhập email của bạn để tụi mình hướng dẫn khôi phục mật khẩu, cảm ơn bạn đã hợp tác!',
                style: widget.textTheme.bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.outline),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const TextFieldRequired(
                  label: 'Email của bạn', hintText: 'Nhập email của bạn'),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width,
        child: FilledButton(
          onPressed: () {
            context.push(RouteName.verifyOtp);
          },
          child: const Text('Bước tiếp theo'),
        ),
      ),
    );
  }
}
