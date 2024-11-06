import 'package:f_journey/view/message/message.dart';
import 'package:f_journey/view/notification/notification.dart';
import 'package:f_journey/view/payment/payment.dart';
import 'package:f_journey/view/trip/passenger/home.dart';
import 'package:f_journey/view/profile/profile.dart';
import 'package:flutter/material.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key});

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePassengerWidget(),
    NotificationWidget(),
    PaymentWidget(),
    MessageWidget(),
    ProfileWidget(),
  ];

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
            icon: _selectedIndex == 1
                ? const Icon(Icons.work_history_rounded)
                : const Icon(Icons.work_history_outlined),
            label: 'Hoạt động',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(Icons.account_balance_wallet_rounded)
                : const Icon(Icons.account_balance_wallet_outlined),
            label: 'Thanh toán',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(Icons.message_rounded)
                : const Icon(Icons.message_outlined),
            label: 'Tin nhắn',
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
