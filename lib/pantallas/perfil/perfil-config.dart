import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';

class PerfilConfigScreen extends StatefulWidget {
  const PerfilConfigScreen({super.key});

  @override
  State<PerfilConfigScreen> createState() => _PerfilConfigScreenState();
}

class _PerfilConfigScreenState extends State<PerfilConfigScreen> {
  final List<String> _rolesSeleccionados = [];
  final List<String> _roles = [
    'Facultad de Ciencias de la Salud', 'Facultad de Ciencias Jurídicas y Sociales',
    'Facultad de Educación', 'Facultad de Ingeniería y Negocios', 'Facultad de Teología',
    'Admisión', 'Apoyo Integral al Estudiante', 'Biblioteca', 'Bienestar Estudiantil',
    'Comunicaciones', 'Docencia', 'Educación Continua', 'Equidad e Inclusión',
    'Investigación', 'Pastoral e Identidad Universitaria', 'Planificación y Aseguramiento de la Calidad',
    'Posgrado', 'Proyectos y Emprendimiento', 'Servicios Estudiantiles', 'Vinculación con el Medio',
  ];

  @override
  void initState() {
    super.initState();
    _cargarRolesActuales();
  }

  Future<void> _cargarRolesActuales() async {
    final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance.collection('usuarios').doc(user?.uid).get();
    if (doc.exists && doc.data()!.containsKey('facultades')) {
      setState(() {
        _rolesSeleccionados.addAll(List<String>.from(doc.data()!['facultades']));
      });
    }
  }

  Future<void> _guardarYContinuar() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).update({
        'facultades': _rolesSeleccionados,
        'perfilConfigurado': true,
      });
    }
    if (!mounted) return;
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/introduccion');
    }
  }

  void _alternarSeleccion(String rol) {
    setState(() {
      if (_rolesSeleccionados.contains(rol)) {
        _rolesSeleccionados.remove(rol);
      } else {
        _rolesSeleccionados.add(rol);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: AppTheme.blanco,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/logos/logo-horizontal.png', height: 50, fit: BoxFit.contain),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    CircleAvatar(radius: 20, backgroundImage: NetworkImage(user?.photoURL ?? '')),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.displayName ?? 'Usuario', style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(user?.email ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Configura tu perfil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('Selecciona las facultades o áreas a las que perteneces para recibir alertas.', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _roles.length,
                  itemBuilder: (context, index) {
                    final rol = _roles[index];
                    final esSeleccionado = _rolesSeleccionados.contains(rol);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: () => _alternarSeleccion(rol),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            border: Border.all(color: esSeleccionado ? AppTheme.azulOscuro : Colors.black12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(rol, style: TextStyle(fontSize: 13, fontWeight: esSeleccionado ? FontWeight.w600 : FontWeight.w400)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardarYContinuar,
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.azulOscuro, padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Continuar', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}