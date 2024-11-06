import 'package:f_journey/core/common/cubits/theme_cubit.dart';
import 'package:f_journey/core/network/http_client.dart';
import 'package:f_journey/core/router.dart';
import 'package:f_journey/core/theme/theme.dart';
import 'package:f_journey/core/theme/util.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:f_journey/model/repository/auth/auth_api_client.dart';
import 'package:f_journey/model/repository/auth/auth_repository.dart';
import 'package:f_journey/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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
        RepositoryProvider(
            create: (context) =>
                AuthRepository(authApiClient: AuthApiClient(dio: dio))),
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

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          theme: themeMode == true ? theme.dark() : theme.light(),
          routerConfig: router,
        );
      },
    );
  }
}
