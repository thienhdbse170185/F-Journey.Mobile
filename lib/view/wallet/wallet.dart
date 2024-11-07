import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/view/auth/widgets/components/text_field_required.dart';
import 'package:f_journey/view/wallet/vnpay_inapp.dart';
import 'package:f_journey/viewmodel/wallet/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({super.key});

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  String? balance;
  bool get isButtonEnabled => balance != null && balance!.isNotEmpty;

  final TextEditingController priceController = TextEditingController();
  InAppWebViewController? webView;

  @override
  void initState() {
    super.initState();
    priceController.addListener(_onPriceChanged);
  }

  @override
  void dispose() {
    priceController.removeListener(_onPriceChanged);
    priceController.dispose();
    super.dispose();
  }

  void _onPriceChanged() {
    setState(() {
      balance = priceController.text;
    });
  }

  void submitImportWallet() {
    try {
      if (isButtonEnabled) {
        // Send the price to the API or handle the top-up logic here
        context
            .read<WalletCubit>()
            .updateWalletBalanceStarted(int.parse(balance!));
      }
    } catch (e) {
      SnackbarUtil.openSnackbar(context, "Check balance field again");
    }
  }

  void _handlePaymentCallback(Uri uri) {
    final paymentResult = uri.queryParameters['result'];
    if (paymentResult != null) {
      _navigateToPaymentSuccessScreen(paymentResult);
    }
  }

  void _navigateToPaymentSuccessScreen(String paymentResult) {
    context.go(RouteName.payment, extra: paymentResult);
  }

  Future<void> _launchPaymentUrl(String url) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentWebViewScreen(
          url: url,
          onPaymentSuccess: _handlePaymentCallback,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is ImportWalletInProgress) {
          SnackbarUtil.openSnackbar(context, "Processing...");
        } else if (state is ImportWalletSuccess) {
          _launchPaymentUrl(state.paymentUrl);
        } else if (state is ImportWalletFailure) {
          SnackbarUtil.openFailureSnackbar(context, "Failed to import wallet");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text('Nạp tiền vào Ví'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Nạp tiền vào',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline, // Outline color
                                width: 1.0, // Outline thickness
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Text(
                                        '0', // Replace with actual data value
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
                          )),
                      const SizedBox(height: 8),
                      TextFieldRequired(
                        label: 'Số tiền cần nạp',
                        hintText: '0đ',
                        controller: priceController,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Từ nguồn tiền',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Outline color
                            width: 1.0, // Outline thickness
                          ),
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'VNPAY Wallet',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  Text(
                                    'Miễn phí thanh toán', // Replace with actual data value
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          child: FilledButton(
            onPressed: isButtonEnabled ? submitImportWallet : null,
            child: const Text('Nạp tiền'),
          ),
        ),
      ),
    );
  }
}
