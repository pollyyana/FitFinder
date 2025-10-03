// lib/app_module.dart
import 'package:dio/dio.dart';
import 'package:fit_finder/core/controllers/personal_controller.dart';
import 'package:fit_finder/core/repositories/personal_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/ui/theme.dart';
import 'pages/modules/home/home_screen.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Dio global
        Provider<Dio>(
          create: (_) => Dio(
            BaseOptions(
              baseUrl: 'http://192.168.15.6:8080',
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            ),
          ),
          lazy: false,
        ),

        // Repository
        ChangeNotifierProvider<PersonalRepository>(
          create: (context) => PersonalRepository(dio: context.read()),
          lazy: false,
        ),

        // Controller
        ChangeNotifierProvider<PersonalController>(
          create: (context) => PersonalController(repository: context.read()),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Fit Finder',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}
