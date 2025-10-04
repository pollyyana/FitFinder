import 'package:dio/dio.dart';
import 'package:fit_finder/app/app_widget.dart';
import 'package:fit_finder/app/core/service/dio_connection.dart';
import 'package:fit_finder/app/pages/controllers/personal_controller.dart';
import 'package:fit_finder/app/repositories/personal_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Dio global - lazy para não conectar na abertura
        Provider<Dio>(
          create: (_) => DioConnection.instance,
          lazy: true,
        ),

        // Repository - lazy para não conectar na abertura
        ChangeNotifierProvider<PersonalRepository>(
          create: (context) => PersonalRepository(dio: context.read<Dio>()),
          lazy: true,
        ),

        // Controller - lazy para não conectar na abertura
        ChangeNotifierProvider<PersonalController>(
          create: (context) => PersonalController(
            repository: context.read<PersonalRepository>(),
          ),
          lazy: true,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
