import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/view/auth/widgets/components/text_field_required.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdatePasswordWidget extends StatefulWidget {
  const UpdatePasswordWidget({super.key});

  @override
  State<UpdatePasswordWidget> createState() => _UpdatePasswordWidgetState();
}

class _UpdatePasswordWidgetState extends State<UpdatePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật mật khẩu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showSettingsBottomSheet(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 64, bottom: 16, left: 16, right: 16),
          child: Column(
            children: [
              Image.asset(
                'assets/images/checking_image.png',
                width: 260,
              ),
              const SizedBox(height: 32),
              const Text(
                'Nhập mật khẩu mới của bạn để cập nhật mật khẩu, \ncảm ơn bạn đã hợp tác!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const TextFieldRequired(
                  label: 'New Password | Mật khẩu mới',
                  hintText: 'Nhập mật khẩu mới'),
              const SizedBox(height: 16),
              const TextFieldRequired(
                  label: 'Confirm New Password | Xác nhận mật khẩu mới',
                  hintText: 'Nhập lại mật khẩu mới'),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width,
        child: FilledButton(
          onPressed: () {
            context.go(RouteName.getStarted);
          },
          child: const Text('Lưu'),
        ),
      ),
    );
  }
}
