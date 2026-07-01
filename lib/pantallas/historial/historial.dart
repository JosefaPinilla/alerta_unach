import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cabecera propia del historial
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar por usuario o tipo...',
              prefixIcon: const Icon(Icons.search, color: Colors.black45),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ),

        // Filtros (Mockup)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildFilterChip('Todas', true),
              _buildFilterChip('Salud', false),
              _buildFilterChip('Bomberos', false),
              _buildFilterChip('Seguridad', false),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Lista de alertas
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildAlertCard('Salud', 'Juan Pérez', '05 Jun 2026, 10:45 AM', AppTheme.azulOscuro, true),
              _buildAlertCard('Bomberos', 'María García', '05 Jun 2026, 11:20 AM', Colors.red, false),
              _buildAlertCard('Seguridad', 'Carlos Ruíz', '04 Jun 2026, 09:15 PM', Colors.amber, true),
              const SizedBox(height: 20),
              const Center(child: Text('FIN DEL HISTORIAL', style: TextStyle(fontFamily: 'Prompt', color: Colors.black26, fontSize: 10))),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.azulOscuro : Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildAlertCard(String tipo, String autor, String fecha, Color color, bool finalizado) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border(left: BorderSide(color: color, width: 4))),
      child: Row(
        children: [
          Icon(tipo == 'Salud' ? Icons.medical_services : tipo == 'Bomberos' ? Icons.fire_truck : Icons.security, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(tipo, style: const TextStyle(fontWeight: FontWeight.bold)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(finalizado ? 'FINALIZADO' : 'EN PROCESO', style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)))
              ]),
              Text('Reportado por: $autor', style: const TextStyle(fontSize: 12, color: Colors.black54)),
              Text(fecha, style: const TextStyle(fontSize: 11, color: Colors.black45)),
            ]),
          ),
          const Icon(Icons.chevron_right, color: Colors.black26),
        ],
      ),
    );
  }
}