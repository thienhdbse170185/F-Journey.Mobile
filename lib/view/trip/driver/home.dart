import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/view/trip/widget/home_appbar.dart';
import 'package:f_journey/viewmodel/trip_match/trip_match_cubit.dart';
import 'package:f_journey/viewmodel/trip_request/trip_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDriverWidget extends StatefulWidget {
  final int userId;
  final List<TripRequestDto> tripRequests;
  const HomeDriverWidget(
      {super.key, required this.userId, required this.tripRequests});

  @override
  State<HomeDriverWidget> createState() => _HomeDriverWidgetState();
}

class _HomeDriverWidgetState extends State<HomeDriverWidget>
    with SingleTickerProviderStateMixin {
  List<TripRequestDto> updatedTripRequests = [];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    setState(() {
      updatedTripRequests = widget.tripRequests;
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
                // Check if there are any trip requests
                updatedTripRequests.isEmpty
                    ? SizedBox(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: 8),
                              Text(
                                'Có vẻ như chưa có \nbạn Ôm nào xin đi nhờ ><',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              // Stack to display ping effect and notification icon
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Animated ping effect
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
                                  // Notification icon
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
                          ListView.builder(
                            itemCount: updatedTripRequests.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final tripRequest = updatedTripRequests[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'From: ${tripRequest.fromZoneName}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              'To: ${tripRequest.toZoneName}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'When: ${tripRequest.tripDate}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Slot: ${tripRequest.slot}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            )
                                          ],
                                        ),
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          _showConfirmDialog("Xác nhận",
                                              "Bạn xác nhận muốn ghép cặp với bạn Ôm này?",
                                              () {
                                            Navigator.of(context).pop();
                                            context
                                                .read<TripMatchCubit>()
                                                .createTripMatch(
                                                    tripRequest.id);
                                          });
                                        },
                                        child: const Text('Ghép cặp'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
