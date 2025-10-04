import 'package:fit_finder/app/core/ui/theme.dart';
import 'package:fit_finder/app/modules/home/home_screen.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit Finder',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
