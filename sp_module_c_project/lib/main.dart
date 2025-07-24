import 'package:flutter/material.dart';
import 'package:sp_module_c_project/pages/detalhes.dart';
import 'package:sp_module_c_project/pages/home.dart';
import 'package:sp_module_c_project/pages/login.dart';
import 'package:sp_module_c_project/pages/splash.dart';
import 'package:sp_module_c_project/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.azulClaro),
      ),
      routes: {
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/detalhes': (context) => const Detalhes(),
        '/splash': (context) => const Splash(),
      },
      initialRoute: '/splash',
    );
  }
}
