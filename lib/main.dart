import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'pantallas/auth_gate.dart';
import 'pantallas/login/login.dart';
import 'pantallas/main-layout.dart';
import 'pantallas/introduccion/introduccion.dart';
import 'pantallas/perfil/perfil-config.dart';
import 'pantallas/theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pantallas/alerta_detalle.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Escuchar cuando la app se abre desde una notificación
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.data.isNotEmpty) {
      // Obtenemos el ID de la alerta
      String alertaId = message.data['alertaId'];

      // Obtenemos el documento de Firestore para pasárselo a la pantalla
      FirebaseFirestore.instance.collection('alertas').doc(alertaId).get().then((doc) {
        if (doc.exists) {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => AlertaDetalleScreen(alerta: doc)),
          );
        }
      });
    }
  });

  runApp(const AlertaUnachApp());
}

class AlertaUnachApp extends StatelessWidget {
  const AlertaUnachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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