import 'package:f_journey/core/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckingWidget extends StatefulWidget {
  const CheckingWidget({super.key});

  @override
  State<CheckingWidget> createState() => _CheckingWidgetState();
}

class _CheckingWidgetState extends State<CheckingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          title: const Text('Checking'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
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
                'assets/images/checking_image.png',
                width: 260,
              ),
              const SizedBox(height: 32),
              Text('Hi!', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Có vẻ như bạn muốn tìm kiếm sự tiện lợi và thú vị cho mỗi chuyến hành trình của bản thân.\n>> Hãy điền thông tin để bắt đầu nhé!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.outline),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () {
                  context.push(RouteName.passengerRegister);
                },
                child: const Text('Okay ^~^'),
              ),
            ],
          ),
        ));
  }
}
