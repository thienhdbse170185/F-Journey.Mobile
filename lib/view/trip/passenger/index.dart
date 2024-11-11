import 'package:f_journey/core/utils/price_util.dart';
import 'package:f_journey/model/dto/trip_match_dto.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/model/response/auth/get_user_profile_response.dart';
import 'package:f_journey/view/trip/passenger/home.dart';
import 'package:f_journey/view/profile/profile.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:f_journey/viewmodel/trip_match/trip_match_cubit.dart';
import 'package:f_journey/viewmodel/trip_request/trip_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key});

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int _selectedIndex = 0;
  String balance = "0";
  late GetUserProfileResult profile;
  List<TripRequestDto> tripRequests = [];
  List<TripMatchDto> tripMatches = [],
      inProgressTripMatches = [],
      completedTripMatches = [],
      canceledTripMatches = [];

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthBloc>().state;
    if (state is ProfileUserApproved) {
      final balanceFormated =
          PriceUtil.formatPrice(state.profile.wallet.balance);
      setState(() {
        profile = state.profile;
        balance = balanceFormated;
      });
    }

    context.read<TripRequestCubit>().getTripRequestByUserId(profile.id);
    final tripRequestState = context.read<TripRequestCubit>().state;
    if (tripRequestState is GetTripRequestSuccess) {
      setState(() {
        tripRequests = tripRequestState.tripRequests;
      });
    }

    context.read<TripMatchCubit>().getTripMatchByPassengerId(profile.id);
    final tripMatchState = context.read<TripMatchCubit>().state;
    if (tripMatchState is GetTripMatchByPassengerIdSuccess) {
      setState(() {
        tripMatches = tripMatchState.pendingTripMatches;
        inProgressTripMatches = tripMatchState.inProgressTripMatches;
        completedTripMatches = tripMatchState.completedTripMatches;
        canceledTripMatches = tripMatchState.canceledTripMatches;
      });
    }

    _widgetOptions = <Widget>[
      HomePassengerWidget(
        balance: balance,
        userId: profile.id,
        tripRequests: tripRequests,
        tripMatches: tripMatches,
        inProgressTripMatches: inProgressTripMatches,
        completedTripMatches: completedTripMatches,
        canceledTripMatches: canceledTripMatches,
      ),
      ProfileWidget(
        profileImageUrl: profile.profileImageUrl,
        name: profile.name,
        email: profile.email,
        userId: profile.id,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false, // Tắt phản hồi âm thanh và rung khi nhấn
        type: BottomNavigationBarType
            .fixed, // Đảm bảo tất cả item hiển thị đầy đủ
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const Icon(Icons.home_rounded)
                : const Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? const Icon(Icons.account_circle_rounded)
                : const Icon(Icons.account_circle_outlined),
            label: 'Cá nhân',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Xử lý khi một item được nhấn
        selectedFontSize: 12, // Điều chỉnh kích thước chữ của item được chọn
        unselectedFontSize:
            12, // Điều chỉnh kích thước chữ của item không được chọn
      ),
    );
  }
}
