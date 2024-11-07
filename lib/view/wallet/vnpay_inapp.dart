import 'package:f_journey/core/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;
  final Function(Uri) onPaymentSuccess;

  const PaymentWebViewScreen(
      {super.key, required this.url, required this.onPaymentSuccess});

  @override
  State<StatefulWidget> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        onLoadStop: (controller, url) {
          if (url != null && url.toString().contains('vnpay-return')) {
            if (kDebugMode) {
              print(url);
            }
            context.go(RouteName.payment, extra: url);
          }
        },
      ),
    );
  }
}
