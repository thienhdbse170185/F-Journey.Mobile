import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterResultWidget extends StatefulWidget {
  const RegisterResultWidget({super.key});

  @override
  State<RegisterResultWidget> createState() => _RegisterResultWidgetState();
}

class _RegisterResultWidgetState extends State<RegisterResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          title: const Text('Trạng thái hồ sơ'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showSettingsBottomSheet(context);
              },
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 64, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/document.png',
                width: 260,
              ),
              const SizedBox(height: 32),
              Text('Hồ sơ đang được xét duyệt',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Tụi mình sẽ gửi thông báo cho bạn khi có kết quả xét duyệt thông qua Mail bạn đã cung cấp nhé! Thân chào bạn.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.outline),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () {
                  context.go(RouteName.getStarted);
                },
                child: const Text('Vâng, cảm ơn bạn!'),
              ),
            ],
          ),
        ));
  }
}
