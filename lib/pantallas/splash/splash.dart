import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _iniciarFlujo();
  }

  Future<void> _iniciarFlujo() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final User? usuario = FirebaseAuth.instance.currentUser;

    if (usuario == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(usuario.uid)
        .get();

    if (!mounted) return;

    if (doc.exists) {
      Navigator.pushReplacementNamed(context, '/inicio');
    } else {
      await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).set({
        'email': usuario.email,
        'perfilConfigurado': false,
      });
      Navigator.pushReplacementNamed(context, '/perfil-config');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.azulMarino,
              AppTheme.azulOscuro,
              AppTheme.azulClaro,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('assets/logos/logo-app.png', width: 150, height: 150),
              const SizedBox(height: 40),
              Container(width: 200, height: 1, color: AppTheme.blanco.withOpacity(0.2)),
              const SizedBox(height: 40),
              Image.asset('assets/logos/logo01blanco.png', width: 200),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}