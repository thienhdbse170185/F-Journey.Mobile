import 'package:f_journey/core/common/cubits/theme_cubit.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/price_util.dart';
import 'package:f_journey/view/trip/widget/home_appbar.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePassengerWidget extends StatefulWidget {
  final String balance;
  const HomePassengerWidget({super.key, required this.balance});

  @override
  State<HomePassengerWidget> createState() => _HomePassengerWidgetState();
}

class _HomePassengerWidgetState extends State<HomePassengerWidget> {
  final TextEditingController _amountController = TextEditingController();
  String updatedBalance = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      updatedBalance = widget.balance;
    }); // Initialize with the provided balance
  }

  // Method to handle pull-to-refresh
  Future<void> _refreshUserProfile() async {
    context.read<AuthBloc>().add(GetUserProfileStarted());
  }

  // Function to show dialog for adding funds
  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nhập số tiền bạn muốn nạp'),
          content: TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              hintText: 'Nhập số tiền',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close dialog
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // Process the amount entered
                final amount = _amountController.text;
                if (amount.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nạp tiền: $amount')),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileUserApproved) {
          final balanceFormated =
              PriceUtil.formatPrice(state.profile.wallet.balance);
          setState(() {
            updatedBalance = balanceFormated;
          });
        }
      },
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: RefreshIndicator(
          onRefresh: _refreshUserProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.push(RouteName.wallet);
                        },
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
                                          'Nạp tiền',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(fontSize: 18),
                                        ),
                                        const SizedBox(width: 28),
                                        Icon(Icons.credit_card,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
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
                                    updatedBalance,
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(RouteName.createTripRequest);
          },
          tooltip: 'Tạo chuyến đi',
          child: const Icon(Icons.add_road_rounded),
        ),
      ),
    );
  }
}
