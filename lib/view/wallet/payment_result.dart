import 'package:f_journey/viewmodel/wallet/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              body: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Giao dịch thành công! \nTiền của bạn đã được nạp vào ví',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ],
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
