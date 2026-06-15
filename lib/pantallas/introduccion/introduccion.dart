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

  // Estructura de datos con el contenido de tus 3 mockups
  final List<Map<String, String>> _datosIntroduccion = [
    {
      'titulo': 'Alertas en Tiempo Real',
      'descripcion': 'Recibe notificaciones instantáneas sobre emergencias dentro del campus de la universidad.',
      'imagen': 'assets/images/intro_1.png', // Reemplaza con tus ilustraciones exportadas
    },
    {
      'titulo': 'Comunicación Directa',
      'descripcion': 'Conéctate rápidamente con los servicios de salud, bomberos y seguridad interna.',
      'imagen': 'assets/images/intro_2.png',
    },
    {
      'titulo': 'Tu Seguridad Primero',
      'descripcion': 'Configura tu perfil según tu facultad para recibir alertas específicas y mantenerte a salvo.',
      'imagen': 'assets/images/intro_3.png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blanco,
      body: SafeArea(
        child: Column(
          children: [

            // Botón "Saltar" en la esquina superior derecha corregido
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                child: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/perfil_config'),
                  child: const Text(
                    'Saltar',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Carrusel deslizante de contenido
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _datosIntroduccion.length,
                onPageChanged: (index) {
                  setState(() {
                    _paginaActual = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ilustración o Imagen central
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              _datosIntroduccion[index]['imagen']!,
                              height: 240,
                              fit: BoxFit.contain,
                              // Callback por si aún no agregas las imágenes físicas a assets
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: AppTheme.azulClaro.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.image_outlined,
                                    size: 60,
                                    color: AppTheme.azulOscuro,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Título
                        Text(
                          _datosIntroduccion[index]['titulo']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.azulOscuro,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Descripción sutil
                        Text(
                          _datosIntroduccion[index]['descripcion']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Sección inferior: Indicador de puntos y botón Siguiente
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dots Indicator (Indicador de progreso de páginas)
                  Row(
                    children: List.generate(
                      _datosIntroduccion.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 6),
                        height: 8,
                        width: _paginaActual == index ? 24 : 8, // Se estira el punto actual
                        decoration: BoxDecoration(
                          color: _paginaActual == index
                              ? AppTheme.azulOscuro
                              : AppTheme.azulOscuro.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Botón Circular Dinámico / Continuar
                  ElevatedButton(
                    onPressed: () {
                      if (_paginaActual < _datosIntroduccion.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Si está en la última página, va a la configuración de facultades
                        Navigator.pushReplacementNamed(context, '/perfil_config');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: AppTheme.azulOscuro,
                      foregroundColor: AppTheme.blanco,
                      elevation: 2,
                    ),
                    child: Icon(
                      _paginaActual == _datosIntroduccion.length - 1
                          ? Icons.check
                          : Icons.arrow_forward,
                      size: 24,
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