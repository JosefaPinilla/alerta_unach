import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    _revisarNavegacion();
  }

  // logica de transicion sin firebase
  Future<void> _revisarNavegacion() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    // simulacion local
    bool estaLogueadoSimulado = false;

    if (estaLogueadoSimulado) {
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    // flujo primer ingreso local temporal
    Navigator.pushReplacementNamed(context, '/inicio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // fondo degradado invertido
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
              // logo app
              Image.asset(
                'assets/logos/logo-app.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 40),
              // linea divisoria
              Container(
                width: 200,
                height: 1,
                color: AppTheme.blanco.withOpacity(0.2),
              ),
              const SizedBox(height: 40),
              // logo unach
              Image.asset(
                'assets/logos/logo01blanco.png',
                width: 200,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}