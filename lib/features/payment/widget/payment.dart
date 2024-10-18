import 'package:flutter/material.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh Toán'),
      ),
      body: const Center(child: Text('Màn hình thanh toán')),
    );
  }
}
