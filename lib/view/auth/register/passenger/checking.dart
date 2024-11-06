import 'package:f_journey/core/common/widgets/settings_bottom_sheet.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/model/response/auth/get_user_profile_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckingWidget extends StatefulWidget {
  final GetUserProfileResult? userProfile;

  const CheckingWidget({super.key, this.userProfile});

  @override
  State<CheckingWidget> createState() => _CheckingWidgetState();
}

class _CheckingWidgetState extends State<CheckingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageOpacity;
  late Animation<double> _textOpacity;
  late Animation<double> _descriptionOpacity;
  late Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();

    // Giảm thời gian duration xuống 4 giây để nhanh hơn
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Điều chỉnh khoảng thời gian của từng Interval cho phù hợp hơn
    _imageOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );
    _descriptionOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
      ),
    );
    _buttonOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
      ),
    );

    // Bắt đầu animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          title: const Text('Checking'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showSettingsBottomSheet(context);
              },
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(top: 64, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image với hiệu ứng fade-in
              FadeTransition(
                opacity: _imageOpacity,
                child: Image.asset(
                  'assets/images/checking_image.png',
                  width: 260,
                ),
              ),
              const SizedBox(height: 32),
              // Text Hi với hiệu ứng fade-in
              FadeTransition(
                opacity: _textOpacity,
                child: Text('Hi!',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const SizedBox(height: 8),
              // Mô tả với hiệu ứng fade-in
              FadeTransition(
                opacity: _descriptionOpacity,
                child: Text(
                  'Có vẻ như bạn muốn tìm kiếm sự tiện lợi và thú vị cho mỗi chuyến hành trình của bản thân.\n>> Hãy điền thông tin để bắt đầu nhé!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.outline),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              // Nút Okay với hiệu ứng fade-in
              FadeTransition(
                opacity: _buttonOpacity,
                child: FilledButton(
                  onPressed: () {
                    context.push(RouteName.passengerRegister, extra: {
                      'profile': widget.userProfile,
                    });
                  },
                  child: const Text('Okay ^~^'),
                ),
              ),
            ],
          ),
        ));
  }
}
