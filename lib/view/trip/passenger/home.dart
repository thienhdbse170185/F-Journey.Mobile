import 'package:f_journey/core/common/widgets/dialog/loading_dialog.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/price_util.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/model/dto/trip_match_dto.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/view/trip/widget/home_appbar.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:f_journey/viewmodel/trip_match/trip_match_cubit.dart';
import 'package:f_journey/viewmodel/trip_request/trip_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePassengerWidget extends StatefulWidget {
  final String balance;
  final int userId;
  final List<TripRequestDto> tripRequests;
  final List<TripMatchDto> tripMatches,
      inProgressTripMatches,
      completedTripMatches,
      canceledTripMatches;
  const HomePassengerWidget(
      {super.key,
      required this.balance,
      required this.userId,
      required this.tripRequests,
      required this.tripMatches,
      required this.inProgressTripMatches,
      required this.completedTripMatches,
      required this.canceledTripMatches});

  @override
  State<HomePassengerWidget> createState() => _HomePassengerWidgetState();
}

class _HomePassengerWidgetState extends State<HomePassengerWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  String updatedBalance = '';
  List<TripRequestDto> updatedTripRequests = [];
  List<TripMatchDto> updatedTripMatches = [],
      updatedInProgressTripMatches = [],
      updatedCompletedTripMatches = [],
      updatedCanceledTripMatches = [];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    setState(() {
      updatedBalance = widget.balance;
      updatedTripRequests = widget.tripRequests;
      updatedTripMatches = widget.tripMatches;
      updatedInProgressTripMatches = widget.inProgressTripMatches;
      updatedCompletedTripMatches = widget.completedTripMatches;
      updatedCanceledTripMatches = widget.canceledTripMatches;
    }); // Initialize with the provided balance

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: false);

    _scaleAnimation = Tween(begin: 1.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Method to handle pull-to-refresh
  Future<void> _refreshUserProfile() async {
    context.read<AuthBloc>().add(GetUserProfileStarted());
    context.read<TripRequestCubit>().getTripRequestByUserId(widget.userId);
    context.read<TripMatchCubit>().getTripMatchByPassengerId(widget.userId);
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

  void _showConfirmDialog(
      String title, String content, Function() confirmFunction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close dialog
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: confirmFunction,
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
            if (state is DeleteTripRequestSuccess) {
              context
                  .read<TripRequestCubit>()
                  .getTripRequestByUserId(widget.userId);
              SnackbarUtil.openSuccessSnackbar(
                  context, 'Hủy yêu cầu thành công');
            } else if (state is DeleteTripRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is GetTripRequestSuccess) {
              setState(() {
                updatedTripRequests = state.tripRequests;
              });
            } else if (state is GetTripRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<TripMatchCubit, TripMatchState>(
            listener: (context, state) async {
          if (state is UpdateTripMatchStatusInProgress) {
            LoadingDialog.show(context);
          } else if (state is UpdateTripMatchStatusSuccess) {
            LoadingDialog.hide(context);
            SnackbarUtil.openSuccessSnackbar(
                context, 'Cập nhật trạng thái thành công');
            context
                .read<TripMatchCubit>()
                .getTripMatchByPassengerId(widget.userId);
          } else if (state is UpdateTripMatchStatusFailure) {
            LoadingDialog.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is GetTripMatchByPassengerIdSuccess) {
            setState(() {
              updatedInProgressTripMatches = state.inProgressTripMatches;
              updatedCompletedTripMatches = state.completedTripMatches;
              updatedCanceledTripMatches = state.canceledTripMatches;
            });
          } else if (state is GetTripMatchByPassengerIdFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        })
      ],
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
                  ],
                ),
                const SizedBox(height: 16),
                _buildTripMatchSection(context, "Chuyến đang diễn ra",
                    updatedInProgressTripMatches),
                const SizedBox(height: 16),
                BlocBuilder<TripMatchCubit, TripMatchState>(
                    builder: (context, state) {
                  if (state is GetTripMatchByPassengerIdSuccess) {
                    if (state.pendingTripMatches.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Stack để chứa cả hiệu ứng ping và icon thông báo
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Vòng tròn mờ mở rộng từ trung tâm icon
                                  AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.redAccent.withOpacity(
                                              1 - _animationController.value,
                                            ),
                                          ),
                                          transform: Matrix4.identity()
                                            ..scale(_scaleAnimation.value),
                                        ),
                                      );
                                    },
                                  ),
                                  // Icon thông báo
                                  const Icon(Icons.notifications_on_outlined,
                                      color: Colors.redAccent),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Bạn có Xế chờ ghép cặp!',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.255,
                            child: ListView.builder(
                              itemCount: state.pendingTripMatches.length,
                              itemBuilder: (BuildContext context, int index) {
                                final tripMatch =
                                    state.pendingTripMatches[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Handle card tap event
                                    context.push(RouteName.tripMatchDetail,
                                        extra: tripMatch);
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Driver Avatar and Name
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        tripMatch.driver
                                                            .profileImageUrl, // Assume avatar URL
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      tripMatch.driver
                                                          .name, // Driver name
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                  'From: ${tripMatch.tripRequest.fromZoneName}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                Text(
                                                  'To: ${tripMatch.tripRequest.toZoneName}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'When: ${tripMatch.tripRequest.tripDate} | Slot: ${tripMatch.tripRequest.slot}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: FilledButton(
                                                  onPressed: () {
                                                    context
                                                        .read<TripMatchCubit>()
                                                        .updateTripMatchStatus(
                                                          tripMatch.id,
                                                          'Accepted',
                                                          null,
                                                          true,
                                                        );
                                                  },
                                                  child: const Text('Đồng ý'),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              SizedBox(
                                                width: 100,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    _showConfirmDialog(
                                                      'Xác nhận hủy',
                                                      'Bạn xác nhận từ chối ghép cặp với bạn Xế này?',
                                                      () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        context
                                                            .read<
                                                                TripMatchCubit>()
                                                            .updateTripMatchStatus(
                                                              tripMatch.id,
                                                              'Rejected',
                                                              null,
                                                              true,
                                                            );
                                                      },
                                                    );
                                                  },
                                                  child: const Text('Từ chối'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else if (state is GetTripMatchByPassengerIdFailure) {
                    return Text(state.message);
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                BlocBuilder<TripRequestCubit, TripRequestState>(
                    builder: (context, state) {
                  if (state is GetTripRequestSuccess) {
                    return Column(
                      children: [
                        Text("Danh sách yêu cầu chuyến đi của bạn",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed)),
                        const SizedBox(height: 8),
                        ListView.builder(
                          itemCount: state.tripRequests.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final tripRequest = state.tripRequests[index];
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.all(16),
                              child: ListTile(
                                title: Text(
                                  "${tripRequest.fromZoneName} - ${tripRequest.toZoneName}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                subtitle: Text(
                                    "When: ${tripRequest.tripDate} | Slot: ${tripRequest.slot}"),
                                trailing: OutlinedButton(
                                  onPressed: () {
                                    _showConfirmDeleteDialog(tripRequest.id);
                                  },
                                  child: const Text('Hủy yêu cầu'),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is GetTripRequestFailure) {
                    return Text(state.message);
                  } else if (state is TripRequestIsEmpty) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 32),
                            Image.asset(
                              'assets/images/checking_image.png',
                              width: 260,
                            ),
                            const SizedBox(height: 32),
                            Text('Hi!',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 8),
                            Text(
                              'Hãy tạo chuyến đi để bắt đầu \nchuyến hành trình của bạn!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32)
                          ]),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 16),
                _buildTripMatchSection(context, "Chuyến đã hoàn thành",
                    updatedCompletedTripMatches),
                const SizedBox(height: 16),
                _buildTripMatchSection(
                    context, "Chuyến đã hủy", updatedCanceledTripMatches),
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

  Widget _buildTripMatchSection(
      BuildContext context, String title, List<TripMatchDto> tripMatches) {
    return tripMatches.isEmpty
        ? const SizedBox.shrink() // Không hiển thị nếu không có tripMatch nào
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primaryFixed),
              ),
              const SizedBox(height: 8),
              _buildTripMatchList(context, tripMatches),
            ],
          );
  }

  Widget _buildTripMatchList(
      BuildContext context, List<TripMatchDto> tripMatchList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.255,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tripMatchList.length,
        itemBuilder: (BuildContext context, int index) {
          final tripMatch = tripMatchList[index];
          return GestureDetector(
              onTap: () {
                // Navigate to trip match details
                context.push(RouteName.tripMatchDetail, extra: tripMatch);
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'From: ${tripMatch.tripRequest.fromZoneName}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'To: ${tripMatch.tripRequest.toZoneName}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'When: ${tripMatch.tripRequest.tripDate} | Slot: ${tripMatch.tripRequest.slot}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildStatusButtons(tripMatch),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  List<Widget> _buildStatusButtons(TripMatchDto tripMatch) {
    switch (tripMatch.status) {
      case 'Accepted':
        return [
          ElevatedButton(
            onPressed: () {
              context.read<TripMatchCubit>().updateTripMatchStatus(
                  tripMatch.id, 'InProgress', null, false);
              SnackbarUtil.openSuccessSnackbar(
                  context, "Bắt đầu chuyến thành công!");
              context.push(RouteName.tripMatchDetail, extra: tripMatch);
            },
            child: const Text('Bắt đầu khởi hành'),
          ),
        ];
      case 'InProgress':
        return [
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: const Text('Đang khởi hành'),
          ),
        ];
      case 'Completed':
        return [
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Đã hoàn thành'),
          ),
        ];
      case 'Canceled':
        return [
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Chuyến đã bị hủy'),
          ),
        ];
      default:
        return [];
    }
  }
}
