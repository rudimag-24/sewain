import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/core/theme/app_theme.dart';
import 'package:sewain/data/datasources/auth/auth_remote_datasource.dart';
import 'package:sewain/presentasion/auth/bloc/auth_bloc.dart';
import 'package:sewain/presentasion/auth/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Variables.appName,
        theme: AppTheme.light,
        home: const SplashPage(),
      ),
    );
  }
}
