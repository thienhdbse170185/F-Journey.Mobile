import 'package:flutter/material.dart';

class TripDestinationWidget extends StatefulWidget {
  const TripDestinationWidget({super.key});

  @override
  State<TripDestinationWidget> createState() => _TripDestinationWidgetState();
}

class _TripDestinationWidgetState extends State<TripDestinationWidget> {
  String? fromZone;
  String? toZone;

  final List<String> zones = ['Zone 1', 'Zone 2', 'Zone 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bạn cần đi nhờ đến đâu?'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  labelText: "From Zone | Điểm đón",
                  hintText: "Chọn điểm đón",
                  border: OutlineInputBorder()),
              value: fromZone,
              items: zones.map((String zone) {
                return DropdownMenuItem<String>(
                  value: zone,
                  child: Text(zone),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  fromZone = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  labelText: "To Zone | Điểm đi",
                  hintText: "Chọn điểm đến",
                  border: OutlineInputBorder()),
              value: toZone,
              items: zones.map((String zone) {
                return DropdownMenuItem<String>(
                  value: zone,
                  child: Text(zone),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  toZone = newValue;
                });
              },
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: FilledButton(
          onPressed: () {},
          child: const Text('Bắt đầu tạo chuyến đi'),
        ),
      ),
    );
  }
}
