import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('usuarios').doc(user?.uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final String rol = data['rol'] ?? 'Estudiante';

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Center(child: Container(width: 100, height: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), image: DecorationImage(image: NetworkImage(user?.photoURL ?? ''), fit: BoxFit.cover)))),
                const SizedBox(height: 16),
                Text(user?.displayName ?? 'Usuario', style: const TextStyle(fontFamily: 'Prompt', fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.azulOscuro)),
                Text(user?.email ?? '', style: TextStyle(fontFamily: 'Prompt', fontSize: 14, color: AppTheme.azulOscuro.withOpacity(0.6))),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(color: AppTheme.azulClaro.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.azulClaro.withOpacity(0.3))),
                  child: Text(rol, style: const TextStyle(fontFamily: 'Prompt', fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.azulOscuro)),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(color: AppTheme.blanco, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                  child: Column(
                    children: [
                      _buildOptionItem(icon: Icons.swap_horiz, title: 'Cambiar rol', onTap: () => Navigator.pushNamed(context, '/perfil-config')),
                      const Divider(height: 1, indent: 55),
                      _buildOptionItem(icon: Icons.refresh, title: 'Ver inducción nuevamente', onTap: () => Navigator.pushNamed(context, '/introduccion')),
                      const Divider(height: 1, indent: 55),
                      _buildOptionItem(icon: Icons.security_outlined, title: 'Políticas de Seguridad', onTap: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(color: AppTheme.blanco, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.withOpacity(0.1))),
                  child: _buildOptionItem(
                    icon: Icons.logout,
                    title: 'Cerrar sesión',
                    colorText: Colors.red,
                    colorIcon: Colors.red,
                    onTap: () async {
                      await AuthService().signOut();
                      if (!context.mounted) return;
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem({required IconData icon, required String title, required VoidCallback onTap, Color colorText = AppTheme.azulOscuro, Color colorIcon = AppTheme.azulOscuro}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.azulClaro.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: colorIcon, size: 20)),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: TextStyle(fontFamily: 'Prompt', fontSize: 15, fontWeight: FontWeight.w500, color: colorText))),
            const Icon(Icons.chevron_right, color: Colors.black26, size: 20),
          ],
        ),
      ),
    );
  }
}