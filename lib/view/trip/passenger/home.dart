import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/price_util.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/view/trip/widget/home_appbar.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:f_journey/viewmodel/trip_request/trip_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePassengerWidget extends StatefulWidget {
  final String balance;
  final int userId;
  final List<TripRequestDto> tripRequests;
  const HomePassengerWidget(
      {super.key,
      required this.balance,
      required this.userId,
      required this.tripRequests});

  @override
  State<HomePassengerWidget> createState() => _HomePassengerWidgetState();
}

class _HomePassengerWidgetState extends State<HomePassengerWidget> {
  final TextEditingController _amountController = TextEditingController();
  String updatedBalance = '';
  List<TripRequestDto> updatedTripRequests = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      updatedBalance = widget.balance;
      updatedTripRequests = widget.tripRequests;
    }); // Initialize with the provided balance
  }

  // Method to handle pull-to-refresh
  Future<void> _refreshUserProfile() async {
    context.read<AuthBloc>().add(GetUserProfileStarted());
    context.read<TripRequestCubit>().getTripRequestByUserId(widget.userId);
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

  void _showConfirmDeleteDialog(int tripRequestId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa đơn'),
          content: const Text('Bạn có chắc chắn muốn xóa đơn này không?'),
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
                context
                    .read<TripRequestCubit>()
                    .deleteTripRequest(tripRequestId);
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ProfileUserApproved) {
              final balanceFormated =
                  PriceUtil.formatPrice(state.profile.wallet.balance);
              setState(() {
                updatedBalance = balanceFormated;
              });
            }
          },
        ),
        BlocListener<TripRequestCubit, TripRequestState>(
          listener: (context, state) {
            if (state is GetTripRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is GetTripRequestSuccess) {
              setState(() {
                updatedTripRequests = state.tripRequests;
              });
            } else if (state is DeleteTripRequestSuccess) {
              context
                  .read<TripRequestCubit>()
                  .getTripRequestByUserId(widget.userId);
              SnackbarUtil.openSuccessSnackbar(
                  context, 'Xóa chuyến đi thành công');
            } else if (state is DeleteTripRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: RefreshIndicator(
          onRefresh: _refreshUserProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
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
                      const SizedBox(width: 16),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Danh sách yêu cầu chuyến đi",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: updatedTripRequests.length,
                      itemBuilder: (context, index) {
                        final tripRequest = updatedTripRequests[index];
                        return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                "${tripRequest.fromZoneName} - ${tripRequest.toZoneName}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              subtitle: Text(
                                  "When: ${tripRequest.tripDate} - ${tripRequest.startTime}"),
                              trailing: OutlinedButton(
                                  onPressed: () {
                                    _showConfirmDeleteDialog(tripRequest.id);
                                  },
                                  child: const Text('Hủy yêu cầu')),
                            ));
                      },
                    ),
                  ),
                ],
              ),
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
