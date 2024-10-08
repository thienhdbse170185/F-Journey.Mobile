import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/theme/text_theme.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                    AuthBloc(authRepository: context.read<AuthRepository>()))
          ],
          child: const AppContent(),
        ));
  }
}

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        disabledColor: Colors.white70,
        textTheme: customTextTheme,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
