import 'package:flutter/material.dart';

class TripDestinationWidget extends StatefulWidget {
  const TripDestinationWidget({super.key});

  @override
  State<TripDestinationWidget> createState() => _TripDestinationWidgetState();
}

class _TripDestinationWidgetState extends State<TripDestinationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bạn cần đi nhờ đến đâu?'),
      ),
    );
  }
}
