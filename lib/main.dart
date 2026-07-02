import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pantallas/auth_gate.dart';
import 'pantallas/login/login.dart';
import 'pantallas/main-layout.dart';
import 'pantallas/introduccion/introduccion.dart';
import 'pantallas/perfil/perfil-config.dart';
import 'pantallas/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/': (context) => const AuthGate(),
        '/login': (context) => const LoginScreen(),
        '/introduccion': (context) => const IntroduccionScreen(),
        '/perfil-config': (context) => const PerfilConfigScreen(),
        '/inicio': (context) => const MainLayoutScreen(),
      },
    );
  }
}