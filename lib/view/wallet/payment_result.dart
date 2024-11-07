import 'package:f_journey/core/router.dart';
import 'package:f_journey/viewmodel/wallet/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentResultWidget extends StatefulWidget {
  final Uri url;
  const PaymentResultWidget({super.key, required this.url});

  @override
  State<PaymentResultWidget> createState() => _PaymentResultWidgetState();
}

class _PaymentResultWidgetState extends State<PaymentResultWidget> {
  @override
  void initState() {
    super.initState();
    context.read<WalletCubit>().checkPaymentStarted(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is CheckPaymentInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CheckPaymentSuccess) {
          return Scaffold(
              body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Giao dịch thành công'),
                ),
                const Center(
                  child: Text('Tiền của bạn đã được cộng vào ví'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                    onPressed: () {
                      context.go(RouteName.homePassenger);
                    },
                    child: Text('Quay lại trang chủ'))
              ],
            ),
          ));
        } else {
          return Scaffold(
            body: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Giao dịch thất bại! \nVui lòng thử lại sau',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
