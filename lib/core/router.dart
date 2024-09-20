import 'package:f_journey/features/auth/bloc/auth_bloc.dart';
import 'package:f_journey/features/auth/widgets/forgot-pw/forgot-pw.dart';
import 'package:f_journey/features/auth/widgets/index.dart';
import 'package:f_journey/features/trip/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteName {
  static const String home = '/';
  static const String auth = '/auth';
  static const String forgotPw = '/forgot-pw';

  static const publicRoutes = [auth, forgotPw];
}

final router = GoRouter(
    redirect: (context, state) {
      if (RouteName.publicRoutes.contains(state.fullPath)) {
        return null;
      }
      if (context.read<AuthBloc>().state is LoginSuccess) {
        return null;
      }
      return RouteName.auth;
    },
    routes: [
      GoRoute(
        path: RouteName.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: RouteName.auth,
          builder: (context, state) {
            final TextTheme textTheme = Theme.of(context).textTheme;
            return AuthWidget(textTheme: textTheme);
          }),
      GoRoute(
          path: RouteName.forgotPw,
          builder: (context, state) {
            final TextTheme textTheme = Theme.of(context).textTheme;
            return ForgotPwWidget(
              textTheme: textTheme,
            );
          })
    ]);
