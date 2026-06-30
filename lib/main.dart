import 'package:flutter/material.dart';
import 'pantallas/splash/splash.dart';
import 'pantallas/login/login.dart';
import 'pantallas/main-layout.dart';
import 'pantallas/introduccion/introduccion.dart';
import 'pantallas/perfil/perfil-config.dart';
import 'pantallas/theme/app_theme.dart';

void main() {
  runApp(const AlertaUnachApp());
}

class AlertaUnachApp extends StatelessWidget {
  const AlertaUnachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alerta UnACh',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/introduccion': (context) => const IntroduccionScreen(),
        '/perfil-config': (context) => const PerfilConfigScreen(),
        '/inicio': (context) => const MainLayoutScreen(),
      },
    );
  }
}