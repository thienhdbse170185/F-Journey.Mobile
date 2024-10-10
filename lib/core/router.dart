import 'package:f_journey/features/auth/bloc/auth_bloc.dart';
import 'package:f_journey/features/auth/widgets/forgot-pw/forgot-pw.dart';
import 'package:f_journey/features/auth/widgets/get-started/get-started.dart';
import 'package:f_journey/features/auth/widgets/index.dart';
import 'package:f_journey/features/auth/widgets/layout.dart';
import 'package:f_journey/features/auth/widgets/register/checking.dart';
import 'package:f_journey/features/auth/widgets/register/passenger.dart';
import 'package:f_journey/features/auth/widgets/register/register.dart';
import 'package:f_journey/features/trip/widgets/home.dart';
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

  static const publicRoutes = [
    auth,
    forgotPw,
    getStarted,
    register,
    //ONLY FOR DEV
    passengerRegister,
    checking
    //
  ];
}

final router = GoRouter(
    redirect: (context, state) {
      if (RouteName.publicRoutes.contains(state.fullPath)) {
        return null;
      }
      if (context.read<AuthBloc>().state is LoginSuccess ||
          context.read<AuthBloc>().state is LoginGoogleSuccess) {
        return null;
      }
      //return RouteName.getStarted
      return RouteName.checking; //ONLY FOR DEV
    },
    routes: [
      GoRoute(
        path: RouteName.home,
        builder: (context, state) => const HomeScreen(),
      ),
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
                path: RouteName.forgotPw,
                builder: (context, state) {
                  final TextTheme textTheme = Theme.of(context).textTheme;
                  return ForgotPwWidget(
                    textTheme: textTheme,
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
          path: RouteName.passengerRegister,
          builder: (context, state) {
            return const PassengerRegistrationWidget();
          }),
      GoRoute(
          path: RouteName.checking,
          builder: (context, state) {
            return const CheckingWidget();
          })
    ]);
