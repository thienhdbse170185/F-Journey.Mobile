import 'package:f_journey/features/auth/widgets/components/text_field_required.dart';
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
        title: const Text('Bạn cần đi nhờ đến đâu?'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 8),
            TextFieldRequired(
                label: "From Zone | Điểm đón", hintText: "Chọn điểm đón"),
            SizedBox(height: 16),
            TextFieldRequired(
                label: "To Zone | Điểm đi", hintText: "Chọn điểm đến")
          ],
        ),
      ),
    );
  }
}
