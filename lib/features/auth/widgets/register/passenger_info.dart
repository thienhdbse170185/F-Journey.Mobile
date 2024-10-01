import 'package:flutter/material.dart';

class PassengerInfoWidget extends StatefulWidget {
  const PassengerInfoWidget({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  State<PassengerInfoWidget> createState() => _PassengerInfoWidgetState();
}

class _PassengerInfoWidgetState extends State<PassengerInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            const EdgeInsets.only(top: 32, right: 16, bottom: 24, left: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Passenger Info'),
          ],
        ),
      ),
    );
  }
}
