import 'package:flutter/material.dart';
import 'pantallas/splash/splash.dart';
import 'pantallas/login/login.dart';
import 'pantallas/perfil/perfil.dart';
import 'pantallas/perfil/perfil-config.dart';
import 'pantallas/theme/app_theme.dart';
import 'pantallas/inicio/inicio.dart';
import 'pantallas/introduccion/introduccion.dart';

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

      // tema institucional
      theme: AppTheme.lightTheme,

      // FLUJO REAL: Arranca estrictamente en el Splash Screen
      initialRoute: '/',

      // Mapeo oficial de pantallas de la aplicación
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/introduccion': (context) => const IntroduccionScreen(),
        '/perfil-config': (context) => const PerfilConfigScreen(),
        '/inicio': (context) => const InicioScreen(), // Contiene la barra integrada abajo
        '/perfil': (context) => const PerfilScreen(),
      },
    );
  }
}