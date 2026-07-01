import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _cargando = false;

  Future<void> _manejarLogin() async {
    setState(() => _cargando = true);

    final userCredential = await _authService.signInWithGoogle();

    if (!mounted) return;

    setState(() => _cargando = false);

    if (userCredential != null) {
      // Al ser exitoso, no navegamos manualmente.
      // El AuthGate en main.dart detectará el cambio y redirigirá.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión con Google')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blanco,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Image.asset('assets/logos/logo-app.png', width: 90, height: 90),
              const SizedBox(height: 35),
              const Text(
                'Bienvenido a ALERTA',
                style: TextStyle(fontFamily: 'Prompt', fontSize: 26, fontWeight: FontWeight.w700, color: AppTheme.azulOscuro),
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Sistema de alertas de emergencia de la Universidad Adventista de Chile',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Prompt', fontSize: 14, color: Colors.black54, height: 1.4),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(color: const Color(0xFFF0F5FA), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.azulClaro, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Utiliza tu cuenta institucional @unach.cl para acceder a la aplicación.',
                        style: TextStyle(fontFamily: 'Prompt', fontSize: 12.5, color: AppTheme.azulOscuro.withOpacity(0.8), height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              _cargando
                  ? const CircularProgressIndicator(color: AppTheme.azulOscuro)
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _manejarLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.azulOscuro,
                    foregroundColor: AppTheme.blanco,
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.g_mobiledata, size: 32),
                      SizedBox(width: 6),
                      Text('Iniciar sesión con Google', style: TextStyle(fontFamily: 'Prompt', fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
              const Text(
                'SOLO USUARIOS AUTORIZADOS DE LA UNIVERSIDAD\nADVENTISTA DE CHILE',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Prompt', fontSize: 10.5, color: Colors.black38, fontWeight: FontWeight.w600, letterSpacing: 0.3),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(onTap: () {}, child: const Text('Privacy Policy', style: TextStyle(fontFamily: 'Prompt', color: Colors.black45, fontSize: 12))),
                  const SizedBox(width: 24),
                  GestureDetector(onTap: () {}, child: const Text('Contact Support', style: TextStyle(fontFamily: 'Prompt', color: Colors.black45, fontSize: 12))),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}