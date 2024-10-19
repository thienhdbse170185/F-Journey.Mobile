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
  final List<String> recentZones = ['Zone 2', 'Zone 3']; // Example recent zones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bạn cần đi nhờ đến đâu?'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "From Zone | Điểm đi",
                hintText: "Chọn điểm đi",
                border: OutlineInputBorder(),
              ),
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
                labelText: "To Zone | Điểm đến",
                hintText: "Chọn điểm đến",
                helperText:
                    "Bạn cần chọn điểm đi và điểm đến để tụi mình \ntìm Xế cho bạn nha. Cảm ơn bạn!",
                border: OutlineInputBorder(),
              ),
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
            const SizedBox(height: 24),
            const Text(
              'Gần đây',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: recentZones.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(recentZones[index]),
                    onTap: () {
                      // Logic to select from recent zones
                      setState(() {
                        fromZone = recentZones[index];
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: FilledButton(
          onPressed: () {
            // Add logic for creating a trip
          },
          child: const Text('Bắt đầu tạo chuyến đi'),
        ),
      ),
    );
  }
}
