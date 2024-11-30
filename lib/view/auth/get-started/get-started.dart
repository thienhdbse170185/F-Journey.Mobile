import 'package:f_journey/core/common/widgets/dialog/loading_dialog.dart';
import 'package:f_journey/core/common/widgets/dialog/success_dialog.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GetStartedWidget extends StatefulWidget {
  const GetStartedWidget({super.key, required this.textTheme, this.onToggle});

  final TextTheme textTheme;
  final VoidCallback? onToggle;

  @override
  State<GetStartedWidget> createState() => _GetStartedWidgetState();
}

class _GetStartedWidgetState extends State<GetStartedWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, state) async {
        if (state is AuthInProgress) {
          LoadingDialog.show(context);
        } else if (state is LoginGoogleSuccess) {
          await Future.delayed(const Duration(milliseconds: 2900));
          LoadingDialog.hide(context);
          await Future.delayed(const Duration(milliseconds: 500));
          SuccessDialog.show(context);
          await Future.delayed(const Duration(milliseconds: 2900));
          SuccessDialog.hide(context);
          context.read<AuthBloc>().add(GetUserProfileStarted());
        } else if (state is LoginGoogleError) {
          SnackbarUtil.openFailureSnackbar(context, state.message);
        } else if (state is UserDoesNotExist) {
          context.go(RouteName.checking, extra: {'profile': state.profile});
        } else if (state is ProfileUserApproved) {
          context.go(RouteName.homePassenger);
        } else if (state is ProfileUserPending) {
          context.go(RouteName.registerResult);
        } else if (state is ProfileUserRejected) {
          context.go(RouteName.registerResult, extra: {'isRejected': true});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            padding: const EdgeInsets.only(
                top: 8.0, right: 16.0, bottom: 16.0, left: 16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                    offset: const Offset(0, 5))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 48.0),
                    child: Image.asset('assets/images/cover_bike.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'F-Journey',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 28.0),
                    width: 250,
                    child: Text(
                      'Mang lại những trải nghiệm tuyệt vời cho mọi chuyến đi của bạn',
                      style: widget.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  // Button for Google Login as Passenger (styled like official Google button)
                  OutlinedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginGoogleStarted());
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey), // Grey border
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png', // Path to Google logo asset
                          height: 24.0,
                        ),
                        const SizedBox(width: 12.0),
                        Text(
                          'Đăng nhập trở thành Ôm',
                          style: widget.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
