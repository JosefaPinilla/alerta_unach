import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Barra superior fija con el logotipo miniatura y la campana de notificaciones
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/logos/logo-app.png',
                  height: 35,
                  width: 35,
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined, color: AppTheme.azulOscuro, size: 26),
                  onPressed: () {
                    // Acción para ver notificaciones futuras
                  },
                ),
              ],
            ),
          ),

          // Divider sutil debajo de la cabecera
          const SizedBox(height: 8),
          Divider(color: Colors.black.withOpacity(0.05), height: 1),

          // Contenedor flexible para los botones grandes centrados
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Botón de SALUD (Azul Marino institucional)
                  _buildEmergencyButton(
                    logoPath: 'assets/logos/salud-logo.png',
                    fallbackIcon: Icons.favorite,
                    label: 'SALUD',
                    backgroundColor: AppTheme.azulOscuro,
                    onTap: () => _mostrarAlertaSimulada(context, 'Salud'),
                  ),
                  const SizedBox(height: 24),

                  // Botón de BOMBEROS (Rojo Vivo)
                  _buildEmergencyButton(
                    logoPath: 'assets/logos/bomberos-logo.png',
                    fallbackIcon: Icons.local_fire_department,
                    label: 'BOMBEROS',
                    backgroundColor: const Color(0xFFFF0000),
                    onTap: () => _mostrarAlertaSimulada(context, 'Bomberos'),
                  ),
                  const SizedBox(height: 24),

                  // Botón de SEGURIDAD (Amarillo Alerta)
                  _buildEmergencyButton(
                    logoPath: 'assets/logos/seguridad-logo.png',
                    fallbackIcon: Icons.shield,
                    label: 'SEGURIDAD',
                    backgroundColor: const Color(0xFFFFD600),
                    onTap: () => _mostrarAlertaSimulada(context, 'Seguridad'),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Generador de botones de emergencia con sombra suave (BoxShadow) idéntico a tu mockup
  Widget _buildEmergencyButton({
    required String logoPath,
    required IconData fallbackIcon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
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
              Icon(fallbackIcon, size: 55, color: AppTheme.blanco),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Prompt',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.blanco,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Simulación local al presionar un botón
  void _mostrarAlertaSimulada(BuildContext context, String tipo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Simulación: Alerta de $tipo enviada con éxito.'),
        backgroundColor: AppTheme.azulOscuro,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}