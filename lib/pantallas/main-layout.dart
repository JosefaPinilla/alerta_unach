import 'package:flutter/material.dart';
import 'inicio/inicio.dart';
import 'perfil/perfil.dart';
import 'theme/app_theme.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _indiceActual = 2; // Inicia en Perfil

  final List<Widget> _pantallas = [
    const InicioScreen(),
    const Center(child: Text('Pantalla de Historial')), // Temporal hasta crear historial
    const PerfilScreen(), // Tu pantalla perfil.dart
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pantallas[_indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        onTap: (index) {
          setState(() {
            _indiceActual = index;
          });
        },
        selectedItemColor: AppTheme.azulOscuro,
        unselectedItemColor: Colors.black38,
        selectedLabelStyle: const TextStyle(fontFamily: 'Prompt', fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Prompt', fontSize: 12),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF8F9FA),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}