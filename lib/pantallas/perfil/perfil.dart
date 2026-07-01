import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('usuarios').doc(_user?.uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_user?.photoURL ?? ''),
                  ),
                ),
                const SizedBox(height: 16),
                Text(_user?.displayName ?? 'Usuario', style: const TextStyle(fontFamily: 'Prompt', fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.azulOscuro)),
                Text(_user?.email ?? '', style: TextStyle(fontFamily: 'Prompt', fontSize: 14, color: AppTheme.azulOscuro.withOpacity(0.6))),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(color: AppTheme.blanco, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                  child: Column(
                    children: [
                      _buildOptionItem(icon: Icons.swap_horiz, title: 'Cambiar áreas de interés', onTap: () {}),
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
                    colorIconBackground: Colors.red.withOpacity(0.1),
                    colorIcon: Colors.red,
                    onTap: () async {
                      await AuthService().signOut();
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, '/login');
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

  Widget _buildOptionItem({required IconData icon, required String title, required VoidCallback onTap, Color colorText = AppTheme.azulOscuro, Color? colorIconBackground, Color colorIcon = AppTheme.azulOscuro}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: colorIconBackground ?? AppTheme.azulClaro.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: colorIcon, size: 20)),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: TextStyle(fontFamily: 'Prompt', fontSize: 15, fontWeight: FontWeight.w500, color: colorText))),
            const Icon(Icons.chevron_right, color: Colors.black26, size: 20),
          ],
        ),
      ),
    );
  }
}