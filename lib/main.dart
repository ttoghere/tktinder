import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tktinder/blocs/auth/auth_bloc.dart';
import 'package:tktinder/blocs/blocs.dart';
import 'package:tktinder/blocs/images/images_bloc.dart';
import 'package:tktinder/config/app_router.dart';
import 'package:tktinder/config/theme.dart';
import 'package:tktinder/cubits/signup/signup_cubit.dart';
import 'package:tktinder/models/models.dart';
import 'package:tktinder/repositories/auth/auth_repository.dart';
import 'package:tktinder/repositories/database/database_repository.dart';
import 'package:tktinder/screens/screens.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => SwipeBloc()
              ..add(
                LoadUsersEvent(users: User.users),
              ),
          ),
          BlocProvider(
            create: (_) => ImagesBloc(
              databaseRepository: DatabaseRepository(),
            )..add(LoadImages()),
          ),
        ],
        child: MaterialApp(
          title: 'Dating App',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
