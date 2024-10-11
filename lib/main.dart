import 'package:f_journey/core/common/cubits/theme_cubit.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/theme/theme.dart';
import 'package:f_journey/core/theme/util.dart';
import 'package:f_journey/features/auth/bloc/auth_bloc.dart';
import 'package:f_journey/features/auth/model/repository/auth_repository.dart';
import 'package:f_journey/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(), // Add ThemeCubit
          ),
        ],
        child: const AppContent(),
      ),
    );
  }
}

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          theme: themeMode == ThemeMode.light ? theme.light() : theme.dark(),
          routerConfig: router,
        );
      },
    );
  }
}
