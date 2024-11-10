import 'package:f_journey/core/utils/price_util.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/model/response/auth/get_user_profile_response.dart';
import 'package:f_journey/view/profile/profile.dart';
import 'package:f_journey/view/trip/driver/home.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:f_journey/viewmodel/trip_request/trip_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsDriverWidget extends StatefulWidget {
  const TabsDriverWidget({super.key});

  @override
  State<TabsDriverWidget> createState() => _TabsDriverWidgetState();
}

class _TabsDriverWidgetState extends State<TabsDriverWidget> {
  int _selectedIndex = 0;
  String balance = "0";
  GetUserProfileResult? profile;
  List<TripRequestDto> tripRequests = [];

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

    context.read<TripRequestCubit>().getAllTripRequest();
    final tripRequestState = context.read<TripRequestCubit>().state;
    if (tripRequestState is GetAllTripRequestSuccess) {
      setState(() {
        tripRequests = tripRequestState.tripRequests;
      });
    }

    _widgetOptions = <Widget>[
      HomeDriverWidget(
        userId: profile?.id ?? 0,
        tripRequests: tripRequests,
        balance: balance,
      ),
      ProfileWidget(
        profileImageUrl: profile?.profileImageUrl ?? '',
        name: profile?.name ?? 'Tên mặc định',
        email: profile?.email ?? 'Email mặc định',
        userId: profile?.id ?? 0,
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
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
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
        onTap: _onItemTapped,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
