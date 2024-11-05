import 'package:f_journey/core/router.dart';
import 'package:f_journey/features/trip/widgets/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePassengerWidget extends StatefulWidget {
  const HomePassengerWidget({super.key});

  @override
  State<HomePassengerWidget> createState() => _HomePassengerWidgetState();
}

class _HomePassengerWidgetState extends State<HomePassengerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thanh toán',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Nạp tiền', // Thay đổi giá trị này theo dữ liệu thực tế
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(width: 28),
                                  Icon(Icons.credit_card,
                                      color:
                                          Theme.of(context).colorScheme.primary)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Khoảng cách giữa các thẻ
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ví của bạn',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '0', // Thay đổi giá trị này theo dữ liệu thực tế
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .push(RouteName.createTripRequest); // Thay đổi route theo nhu cầu
        }, // Biểu tượng cho nút tạo chuyến
        tooltip: 'Tạo chuyến đi',
        child: const Icon(Icons.add_road_rounded), // Tooltip cho nút
      ),
    );
  }
}
