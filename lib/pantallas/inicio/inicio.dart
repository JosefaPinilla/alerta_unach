import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../database_service.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmergencyButton(
            label: 'SALUD',
            backgroundColor: AppTheme.azulOscuro,
            icon: Icons.favorite,
            onTap: () => _enviarAlerta(context, 'Salud'),
          ),
          const SizedBox(height: 24),
          _buildEmergencyButton(
            label: 'BOMBEROS',
            backgroundColor: const Color(0xFFFF0000),
            icon: Icons.local_fire_department,
            onTap: () => _enviarAlerta(context, 'Bomberos'),
          ),
          const SizedBox(height: 24),
          _buildEmergencyButton(
            label: 'SEGURIDAD',
            backgroundColor: const Color(0xFFFFD600),
            icon: Icons.shield,
            onTap: () => _enviarAlerta(context, 'Seguridad'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyButton({
    required String label,
    required Color backgroundColor,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 55, color: AppTheme.blanco),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontFamily: 'Prompt', fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.blanco, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _enviarAlerta(BuildContext context, String tipo) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Enviando alerta de $tipo...'), backgroundColor: Colors.orange),
    );

    await DatabaseService().registrarAlerta(tipo);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alerta de $tipo enviada correctamente.'), backgroundColor: Colors.green),
    );
  }
}