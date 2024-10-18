import 'package:f_journey/core/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePassengerWidget extends StatefulWidget {
  const HomePassengerWidget({super.key});

  @override
  State<HomePassengerWidget> createState() => _HomePassengerWidgetState();
}

class _HomePassengerWidgetState extends State<HomePassengerWidget> {
  void navigateToSelectLocation(String locationName) {
    // Chuyển sang màn hình chọn điểm đi
    context.push(RouteName.createTripRequest, extra: locationName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Bạn cần đi nhờ đến đâu?',
            labelText: 'Điểm đến',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(99.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      'Tp. Dĩ An, Bình Dương',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.thermostat, color: Colors.blue),
                    SizedBox(width: 10),
                    Icon(Icons.wb_sunny, color: Colors.orange),
                  ],
                )
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Gợi ý cho bạn',
                    style: Theme.of(context).textTheme.titleLarge),
                Text('Tất cả',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(decoration: TextDecoration.underline)),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      onPressed: () {
                        context.pushReplacement(RouteName.createTripRequest);
                      },
                      icon: const Icon(Icons.directions_car_rounded)),
                ),
                const SizedBox(height: 8),
                Text('Tạo chuyến',
                    style: Theme.of(context).textTheme.titleSmall)
              ],
            )
          ],
        ),
      ),
    );
  }
}
