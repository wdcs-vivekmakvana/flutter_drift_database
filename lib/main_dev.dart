import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/env/env_type.dart';
import 'package:flutter_local_data_base_drift/home_screen.dart';
import 'package:flutter_local_data_base_drift/injector/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.initModules();
  currentEnv = EnvTypes.dev;
  runApp(const MyApp());
}

/// Entry point of the application.
class MyApp extends StatelessWidget {
  /// Default constructor.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drift App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
