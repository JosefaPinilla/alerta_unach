import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 24),

                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppTheme.azulOscuro),
                      onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        fontWeight: FontWeight.w700,
                        color: AppTheme.azulOscuro,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, color: AppTheme.azulOscuro),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Foto de Perfil con botón flotante
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black12, // COLOR CORREGIDO DENTRO DEL BOXDECORATION
                        ),
                        child: const Icon(Icons.person, size: 50, color: Colors.white54),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppTheme.azulOscuro,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.edit, color: AppTheme.blanco, size: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Datos de usuario
                const Text(
                  'Josefa Pinilla',
                  style: TextStyle(
                    fontFamily: 'Prompt',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.azulOscuro,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'josefapinilla@unach.cl',
                  style: TextStyle(
                    fontFamily: 'Prompt',
                    fontSize: 14,
                    color: AppTheme.azulOscuro.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 12),

                // Chip de Rol
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.azulClaro.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.azulClaro.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.school_outlined, size: 16, color: AppTheme.azulOscuro),
                      const SizedBox(width: 6),
                      Text(
                        'Estudiante - Campus Central',
                        style: const TextStyle(
                          fontFamily: 'Prompt',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.azulOscuro,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Menú de opciones
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.blanco,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildOptionItem(
                        icon: Icons.swap_horiz,
                        title: 'Cambiar rol',
                        onTap: () => Navigator.pushNamed(context, '/perfil-config'),
                      ),
                      const Divider(height: 1, indent: 55),
                      _buildOptionItem(
                        icon: Icons.refresh,
                        title: 'Ver inducción nuevamente',
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 55),
                      _buildOptionItem(
                        icon: Icons.security_outlined,
                        title: 'Políticas de Seguridad',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Botón Cerrar Sesión
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.blanco,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.withOpacity(0.1)),
                  ),
                  child: _buildOptionItem(
                    icon: Icons.logout,
                    title: 'Cerrar sesión',
                    colorText: Colors.red,
                    colorIconBackground: Colors.red.withOpacity(0.1),
                    colorIcon: Colors.red,
                    onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  'TOQUESOS UNACH 2026',
                  style: TextStyle(
                    fontFamily: 'Prompt',
                    fontSize: 10,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color colorText = AppTheme.azulOscuro,
    Color? colorIconBackground,
    Color colorIcon = AppTheme.azulOscuro,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorIconBackground ?? AppTheme.azulClaro.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: colorIcon, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Prompt',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: colorText,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black26, size: 20),
          ],
        ),
      ),
    );
  }
}