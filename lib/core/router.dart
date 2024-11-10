import 'package:f_journey/model/dto/trip_match_dto.dart';
import 'package:f_journey/view/profile/trip_history.dart';
import 'package:f_journey/view/trip/passenger/trip_match_detail.dart';
import 'package:f_journey/view/wallet/payment_result.dart';
import 'package:f_journey/view/wallet/wallet.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:f_journey/model/response/auth/get_user_profile_response.dart';
import 'package:f_journey/view/auth/forgot-pw/forgot-pw.dart';
import 'package:f_journey/view/auth/forgot-pw/update-pw.dart';
import 'package:f_journey/view/auth/forgot-pw/verify-otp.dart';
import 'package:f_journey/view/auth/get-started/get-started.dart';
import 'package:f_journey/view/auth/index.dart';
import 'package:f_journey/view/auth/layout.dart';
import 'package:f_journey/view/auth/register/driver/driver.dart';
import 'package:f_journey/view/auth/register/driver/welcome_driver.dart';
import 'package:f_journey/view/auth/register/passenger/checking.dart';
import 'package:f_journey/view/auth/register/passenger/passenger.dart';
import 'package:f_journey/view/auth/register/register.dart';
import 'package:f_journey/view/auth/register/register_result.dart';
import 'package:f_journey/view/trip/driver/index.dart';
import 'package:f_journey/view/trip/passenger/index.dart';
import 'package:f_journey/view/trip/passenger/trip_dest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteName {
  static const String home = '/';
  static const String getStarted = '/get-started';
  static const String auth = '/auth';
  static const String forgotPw = '/forgot-pw';
  static const String register = '/register';
  static const String passengerRegister = '/passenger-register';
  static const String checking = '/checking';
  static const String registerResult = '/register-result';
  static const String welcomeDriver = '/welcome-driver';
  static const String driverRegister = '/driver-register';
  static const String verifyOtp = '/verify-otp';
  static const String updatePw = '/update-pw';
  static const String homePassenger = '/passenger';
  static const String createTripRequest = '/create-trip-request';
  static const String homeDriver = '/driver';
  static const String wallet = '/wallet';
  static const String payment = '/payment';
  static const String tripMatchDetail = '/trip-match-detail';
  static const String tripHistory = '/trip-history';

  static const publicRoutes = [
    auth,
    forgotPw,
    getStarted,
    register,
    welcomeDriver,
    driverRegister,
    registerResult,
    verifyOtp,
    updatePw,
    //ONLY FOR DEV
    homePassenger,
    createTripRequest,
    //PROD REMOVE THIS
    passengerRegister,
    registerResult
  ];
}

final router = GoRouter(
    redirect: (context, state) {
      if (RouteName.publicRoutes.contains(state.fullPath)) {
        return null;
      }
      if (context.read<AuthBloc>().state is LoginSuccess ||
          context.read<AuthBloc>().state is LoginGoogleSuccess ||
          context.read<AuthBloc>().state is UserDoesNotExist ||
          context.read<AuthBloc>().state is ProfileUserApproved ||
          context.read<AuthBloc>().state is RegisterPassengerProfileSuccess) {
        return null;
      }
      //return RouteName.getStarted
      return RouteName.getStarted; //ONLY FOR DEV
    },
    routes: [
      ShellRoute(
          builder: (context, state, child) {
            final TextTheme textTheme = Theme.of(context).textTheme;
            return AuthLayout(
              textTheme: textTheme,
              child: child,
            );
          },
          routes: [
            GoRoute(
                path: RouteName.auth,
                builder: (context, state) {
                  final TextTheme textTheme = Theme.of(context).textTheme;
                  final view = state.extra as String?;
                  return AuthWidget(
                    textTheme: textTheme,
                    view: view,
                  );
                }),
            GoRoute(
                path: RouteName.getStarted,
                builder: (context, state) {
                  final TextTheme textTheme = Theme.of(context).textTheme;
                  return GetStartedWidget(textTheme: textTheme);
                }),
            GoRoute(
                path: RouteName.register,
                builder: (context, state) {
                  final TextTheme textTheme = Theme.of(context).textTheme;
                  return RegisterWidget(textTheme: textTheme);
                })
          ]),
      GoRoute(
          path: RouteName.forgotPw,
          builder: (context, state) {
            final TextTheme textTheme = Theme.of(context).textTheme;
            return ForgotPwWidget(
              textTheme: textTheme,
            );
          }),
      GoRoute(
          path: RouteName.passengerRegister,
          builder: (context, state) {
            final profile =
                (state.extra as Map<String, GetUserProfileResult?>)['profile']!;
            return PassengerRegistrationWidget(
              userProfile: profile,
            );
          }),
      GoRoute(
          path: RouteName.checking,
          builder: (context, state) {
            final profile =
                (state.extra as Map<String, GetUserProfileResult>)['profile']!;
            return CheckingWidget(
              userProfile: profile,
            );
          }),
      GoRoute(
          path: RouteName.registerResult,
          builder: (context, state) {
            final isRejected = state.extra as bool?;
            return RegisterResultWidget(
              isRejected: isRejected,
            );
          }),
      GoRoute(
          path: RouteName.welcomeDriver,
          builder: (context, state) => const WelcomeDriverWidget()),
      GoRoute(
          path: RouteName.driverRegister,
          builder: (context, state) => const DriverRegisterWidget()),
      GoRoute(
          path: RouteName.verifyOtp,
          builder: (context, state) => const VerifyOtpWidget()),
      GoRoute(
          path: RouteName.updatePw,
          builder: (context, state) => const UpdatePasswordWidget()),
      GoRoute(
          path: RouteName.homePassenger,
          builder: (context, state) => const TabsWidget()),
      GoRoute(
          path: RouteName.createTripRequest,
          builder: (context, state) => const TripDestinationWidget()),
      GoRoute(
          path: RouteName.homeDriver,
          builder: (context, state) => const TabsDriverWidget()),
      GoRoute(
          path: RouteName.wallet,
          builder: (context, state) => const WalletWidget()),
      GoRoute(
          path: RouteName.payment,
          builder: (context, state) {
            final uri = state.extra as Uri;
            return PaymentResultWidget(url: uri);
          }),
      GoRoute(
          path: RouteName.tripMatchDetail,
          builder: (context, state) {
            final tripMatch = state.extra as TripMatchDto;
            return TripMatchDetailWidget(
              tripMatch: tripMatch,
            );
          }),
      GoRoute(
          path: RouteName.tripHistory,
          builder: (context, state) {
            final userId = state.extra as int;
            return TripHistoryWidget(
              userId: userId,
            );
          })
    ]);
