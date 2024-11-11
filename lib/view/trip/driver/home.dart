import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/model/dto/trip_match_dto.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/view/trip/widget/home_appbar.dart';
import 'package:f_journey/viewmodel/trip_match/trip_match_cubit.dart';
import 'package:f_journey/viewmodel/trip_request/trip_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeDriverWidget extends StatefulWidget {
  final int userId;
  final String balance;
  final List<TripRequestDto> tripRequests;
  final List<TripMatchDto> acceptedTripMatches,
      inProgressTripmatches,
      completedTripMatches,
      canceledTripMatches;
  const HomeDriverWidget(
      {super.key,
      required this.balance,
      required this.userId,
      required this.tripRequests,
      required this.acceptedTripMatches,
      required this.inProgressTripmatches,
      required this.completedTripMatches,
      required this.canceledTripMatches});

  @override
  State<HomeDriverWidget> createState() => _HomeDriverWidgetState();
}

class _HomeDriverWidgetState extends State<HomeDriverWidget>
    with SingleTickerProviderStateMixin {
  List<TripRequestDto> updatedTripRequests = [];
  List<TripMatchDto> updatedAcceptedTripMatches = [],
      updatedInProgressTripmatches = [],
      updatedCompletedTripMatches = [],
      updatedCanceledTripMatches = [];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  String updatedBalance = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      updatedBalance = widget.balance;
      updatedTripRequests = widget.tripRequests;
      updatedAcceptedTripMatches = widget.acceptedTripMatches;
      updatedInProgressTripmatches = widget.inProgressTripmatches;
      updatedCompletedTripMatches = widget.completedTripMatches;
      updatedCanceledTripMatches = widget.canceledTripMatches;
    });

    // Tạo AnimationController và Tween để tạo hiệu ứng ping
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: false);

    _scaleAnimation = Tween(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _refreshUserProfile() async {
    context.read<TripRequestCubit>().getAllTripRequest();
    context.read<TripMatchCubit>().getTripMatchByDriverId(widget.userId);
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
        BlocListener<TripRequestCubit, TripRequestState>(
          listener: (context, state) {
            if (state is DeleteTripRequestSuccess) {
              SnackbarUtil.openSuccessSnackbar(
                  context, "Hủy chuyến thành công!");
              context.read<TripRequestCubit>().getAllTripRequest();
            } else if (state is GetAllTripRequestSuccess) {
              setState(() {
                updatedTripRequests = state.tripRequests;
              });
            } else if (state is GetAllTripRequestFailure) {
              SnackbarUtil.openFailureSnackbar(context, state.message);
            }
          },
        ),
        BlocListener<TripMatchCubit, TripMatchState>(
          listener: (context, state) {
            if (state is CreateTripMatchSuccess) {
              SnackbarUtil.openSuccessSnackbar(context, "Ghép cặp thành công!");
              context.read<TripRequestCubit>().getAllTripRequest();
            } else if (state is CreateTripMatchFailure) {
              SnackbarUtil.openFailureSnackbar(context, state.message);
            } else if (state is GetTripMatchByDriverIdSuccess) {
              setState(() {
                updatedAcceptedTripMatches = state.acceptedTripMatches;
                updatedInProgressTripmatches = state.inProgressTripMatches;
                updatedCompletedTripMatches = state.completedTripMatches;
                updatedCanceledTripMatches = state.canceledTripMatches;
              });
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
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
                const SizedBox(height: 16),
                _buildTripMatchSection(context, "Chuyến đã được ghép cặp",
                    updatedAcceptedTripMatches),
                const SizedBox(height: 16),
                _buildTripRequestSection(context),
                const SizedBox(height: 16),
                _buildTripMatchSection(context, "Chuyến đang diễn ra",
                    updatedInProgressTripmatches),
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
      ),
    );
  }

  Widget _buildTripRequestSection(BuildContext context) {
    return updatedTripRequests.isEmpty
        ? _buildNoTripRequestWidget(context)
        : Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
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
                      const Icon(Icons.notifications_on_outlined,
                          color: Colors.redAccent),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Có bạn Ôm xin đi nhờ nè!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              _buildTripList(context, updatedTripRequests),
            ],
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

// Helper function to display buttons based on status
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

  Widget _buildTripList(BuildContext context, List<TripRequestDto> tripList) {
    return ListView.builder(
      itemCount: tripList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final trip = tripList[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From: ${trip.fromZoneName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'To: ${trip.toZoneName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'When: ${trip.tripDate}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Slot: ${trip.slot}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                trip is TripRequestDto
                    ? FilledButton(
                        onPressed: () {
                          _showConfirmDialog("Xác nhận",
                              "Bạn xác nhận muốn ghép cặp với bạn Ôm này?", () {
                            Navigator.of(context).pop();
                            context
                                .read<TripMatchCubit>()
                                .createTripMatch(trip.id);
                          });
                        },
                        child: const Text('Ghép cặp'),
                      )
                    : const SizedBox
                        .shrink(), // Hiển thị nút cho TripRequestDto
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoTripRequestWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 32),
        Image.asset(
          'assets/images/checking_image.png',
          width: 260,
        ),
        const SizedBox(height: 32),
        Text('Hi!', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Có vẻ như chưa có \nbạn Ôm nào xin đi nhờ ><',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.outline),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
