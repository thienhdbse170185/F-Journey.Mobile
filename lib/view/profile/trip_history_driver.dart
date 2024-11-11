import 'package:f_journey/core/router.dart';
import 'package:f_journey/viewmodel/trip_match/trip_match_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TripHistoryDriverWidget extends StatefulWidget {
  final int userId;
  const TripHistoryDriverWidget({super.key, required this.userId});

  @override
  State<TripHistoryDriverWidget> createState() =>
      _TripHistoryDriverWidgetState();
}

class _TripHistoryDriverWidgetState extends State<TripHistoryDriverWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // Two tabs: Completed and Canceled
    context.read<TripMatchCubit>().getTripMatchByPassengerId(widget.userId);
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // Trigger the refresh action, e.g., by fetching the trip data again
    context.read<TripMatchCubit>().getTripMatchByPassengerId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử chuyến đi'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Đã hoàn thành'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Completed trips
          Center(
            child: BlocBuilder<TripMatchCubit, TripMatchState>(
              builder: (context, state) {
                if (state is GetTripMatchByPassengerIdSuccess) {
                  if (state.completedTripMatches.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh, // Trigger the refresh
                      child: ListView.builder(
                        itemCount: state.completedTripMatches.length,
                        itemBuilder: (context, index) {
                          final tripMatch = state.completedTripMatches[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                  "${tripMatch.tripRequest.fromZoneName} - ${tripMatch.tripRequest.toZoneName}"),
                              subtitle: Text(
                                  "Date: ${tripMatch.tripRequest.tripDate} | Slot: ${tripMatch.tripRequest.slot}"),
                              trailing:
                                  const Chip(label: Text('Đã hoàn thành')),
                              onTap: () {
                                context.push(RouteName.tripMatchDetail,
                                    extra: tripMatch);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text('Chưa có chuyến nào hoàn thành');
                  }
                } else if (state is GetTripMatchByPassengerIdFailure) {
                  return Text(state.message);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          // Tab 2: Canceled trips
          Center(
            child: BlocBuilder<TripMatchCubit, TripMatchState>(
              builder: (context, state) {
                if (state is GetTripMatchByPassengerIdSuccess) {
                  if (state.canceledTripMatches.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh, // Trigger the refresh
                      child: ListView.builder(
                        itemCount: state.canceledTripMatches.length,
                        itemBuilder: (context, index) {
                          final tripMatch = state.canceledTripMatches[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                  "${tripMatch.tripRequest.fromZoneName} - ${tripMatch.tripRequest.toZoneName}"),
                              subtitle: Text(
                                  "Date: ${tripMatch.tripRequest.tripDate} | Slot: ${tripMatch.tripRequest.slot}"),
                              trailing: const Chip(label: Text('Đã hủy')),
                              onTap: () {
                                context.push(RouteName.tripMatchDetail,
                                    extra: tripMatch);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text('Chưa có chuyến nào bị hủy');
                  }
                } else if (state is GetTripMatchByPassengerIdFailure) {
                  return Text(state.message);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
