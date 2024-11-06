import 'package:flutter/material.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hoạt động')),
      body: const Center(
        child: Text('Màn hình hoạt động'),
      ),
    );
  }
}
