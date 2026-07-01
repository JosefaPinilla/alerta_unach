import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class IntroduccionScreen extends StatefulWidget {
  const IntroduccionScreen({super.key});

  @override
  State<IntroduccionScreen> createState() => _IntroduccionScreenState();
}

class _IntroduccionScreenState extends State<IntroduccionScreen> {
  final PageController _pageController = PageController();
  int _paginaActual = 0;

  final List<Map<String, String>> _datos = [
    {
      'titulo': 'Emergencias de Salud',
      'descripcion': 'Utiliza esta alerta para accidentes, desmayos, lesiones o situaciones médicas que requieran atención inmediata.',
      'imagen': 'assets/iconos/icono-salud.png',
    },
    {
      'titulo': 'Emergencias de Bomberos',
      'descripcion': 'Utiliza esta alerta para incendios, humo, fugas peligrosas o situaciones que comprometan la infraestructura.',
      'imagen': 'assets/iconos/icono-bomberos.png',
    },
    {
      'titulo': 'Emergencias de Seguridad',
      'descripcion': 'Utiliza el botón Seguridad para reportar situaciones que requieran intervención inmediata del personal de seguridad o de Carabineros.',
      'imagen': 'assets/iconos/icono-seguridad.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blanco,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/inicio'),
                child: const Text('Omitir', style: TextStyle(color: Colors.black54)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _paginaActual = index),
                itemCount: _datos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_datos[index]['imagen']!, height: 200),
                        const SizedBox(height: 30),
                        Text(_datos[index]['titulo']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.azulOscuro)),
                        const SizedBox(height: 15),
                        Text(_datos[index]['descripcion']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                        if (index == 2) ...[
                          const SizedBox(height: 20),
                          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), borderRadius: BorderRadius.circular(8)), child: const Row(children: [Icon(Icons.info_outline, size: 16), SizedBox(width: 8), Expanded(child: Text("Todas estas situaciones se reportan utilizando el botón Seguridad.", style: TextStyle(fontSize: 12)))]))
                        ]
                      ],
                    ),
                  );
                },
              ),
            ),
            // Indicadores y botón
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(3, (i) => Container(margin: const EdgeInsets.symmetric(horizontal: 4), width: _paginaActual == i ? 16 : 8, height: 8, decoration: BoxDecoration(color: _paginaActual == i ? AppTheme.azulOscuro : Colors.black26, borderRadius: BorderRadius.circular(4))))),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_paginaActual < 2) _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        else Navigator.pushReplacementNamed(context, '/inicio');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.azulOscuro, padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: Text(_paginaActual == 2 ? 'Comenzar' : 'Siguiente →', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}