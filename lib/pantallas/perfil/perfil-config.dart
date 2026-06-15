import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PerfilConfigScreen extends StatefulWidget {
  const PerfilConfigScreen({super.key});

  @override
  State<PerfilConfigScreen> createState() => _PerfilConfigScreenState();
}

class _PerfilConfigScreenState extends State<PerfilConfigScreen> {
  // Lista de elementos seleccionados de forma múltiple
  final List<String> _rolesSeleccionados = [];

  final List<String> _roles = [
    'Facultad de Ciencias de la Salud',
    'Facultad de Ciencias Jurídicas y Sociales',
    'Facultad de Educación',
    'Facultad de Ingeniería y Negocios',
    'Facultad de Teología',
    'Admisión',
    'Apoyo Integral al Estudiante',
    'Biblioteca',
    'Bienestar Estudiantil',
    'Comunicaciones',
    'Docencia',
    'Educación Continua',
    'Equidad e Inclusión',
    'Investigación',
    'Pastoral e Identidad Universitaria',
    'Planificación y Aseguramiento de la Calidad',
    'Posgrado',
    'Proyectos y Emprendimiento',
    'Servicios Estudiantiles',
    'Vinculación con el Medio',
  ];

  void _guardarYContinuar() {
    if (_rolesSeleccionados.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/perfil');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona al menos una opción antes de continuar.')),
      );
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
    return Scaffold(
      backgroundColor: AppTheme.blanco,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Cabecera institucional horizontal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logos/logo-horizontal.png',
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                  Icon(Icons.shield_outlined, color: AppTheme.azulOscuro.withOpacity(0.7)),
                ],
              ),
              const SizedBox(height: 20),

              // Tarjeta Google User
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.grisFondo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppTheme.azulClaro,
                      child: Icon(Icons.person, color: AppTheme.blanco),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Josefa Pinilla',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.azulOscuro,
                          ),
                        ),
                        Text(
                          'josefapinilla@unach.cl',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 13,
                            color: AppTheme.azulOscuro.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Configura tu perfil',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.azulOscuro,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecciona las facultades o áreas con las que te identificas para recibir alertas relevantes.',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),

              // Lista Scrolleable
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
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: esSeleccionado ? AppTheme.azulOscuro : Colors.black12,
                              width: esSeleccionado ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: esSeleccionado ? AppTheme.azulClaro.withOpacity(0.05) : AppTheme.blanco,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  rol,
                                  style: TextStyle(
                                    fontFamily: 'Prompt',
                                    fontSize: 13.5,
                                    fontWeight: esSeleccionado ? FontWeight.w600 : FontWeight.w400,
                                    color: AppTheme.azulOscuro,
                                  ),
                                ),
                              ),
                              if (esSeleccionado)
                                const Icon(Icons.check_circle, color: AppTheme.azulOscuro, size: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Botón Continuar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _guardarYContinuar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.azulOscuro,
                      foregroundColor: AppTheme.blanco,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continuar',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}