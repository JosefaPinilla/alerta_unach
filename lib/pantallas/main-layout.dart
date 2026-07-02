import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'theme/app_theme.dart';
import 'inicio/inicio.dart';
import 'perfil/perfil.dart';
import 'historial/historial.dart';
import 'alerta_detalle.dart';
import 'historial/notificaciones.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _indiceActual = 0;
  bool _mostrandoAlerta = false;
  bool _alertaYaProcesada = false;

  final List<Widget> _pantallas = [
    const InicioScreen(),
    const HistorialScreen(),
    const PerfilScreen(),
  ];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('alertas')
        .where('estado', isEqualTo: 'activa')
        .where('usuarioId', isNotEqualTo: user?.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty && mounted && !_mostrandoAlerta && !_alertaYaProcesada) {
        final alerta = snapshot.docs.first;
        _alertaYaProcesada = true;
        setState(() => _mostrandoAlerta = true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlertaDetalleScreen(alerta: alerta),
          ),
        ).then((_) {
          setState(() => _mostrandoAlerta = false);
          _alertaYaProcesada = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset('assets/logos/logo-horizontal.png', height: 50, fit: BoxFit.contain,),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: AppTheme.azulOscuro, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificacionesScreen()),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.black.withOpacity(0.05), height: 1.0),
        ),
      ),
      body: Container(
        color: const Color(0xFFF8F9FA),
        child: _pantallas[_indiceActual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        onTap: (index) => setState(() => _indiceActual = index),
        selectedItemColor: AppTheme.azulOscuro,
        unselectedItemColor: Colors.black38,
        selectedLabelStyle: const TextStyle(fontFamily: 'Prompt', fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Prompt', fontSize: 12),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.history), activeIcon: Icon(Icons.history_toggle_off), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}