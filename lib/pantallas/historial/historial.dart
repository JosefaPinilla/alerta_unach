import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../database_service.dart';
import '../alerta_detalle.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  String _filtroTipo = 'Todas';
  final user = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot> _obtenerStream() {
    Query query = FirebaseFirestore.instance.collection('alertas').orderBy('timestamp', descending: true);

    if (_filtroTipo == 'Mis alarmas') {
      query = query.where('usuarioId', isEqualTo: user?.uid);
    } else if (_filtroTipo == 'Externas') {
      query = query.where('usuarioId', isNotEqualTo: user?.uid);
    } else if (_filtroTipo != 'Todas') {
      query = query.where('tipo', isEqualTo: _filtroTipo);
    }
    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: ['Todas', 'Mis alarmas', 'Externas', 'Salud', 'Bomberos', 'Seguridad'].map((filtro) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(filtro),
                  selected: _filtroTipo == filtro,
                  onSelected: (bool selected) => setState(() => _filtroTipo = filtro),
                  selectedColor: AppTheme.azulOscuro.withOpacity(0.2),
                  checkmarkColor: AppTheme.azulOscuro,
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _obtenerStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Center(child: Text('Error al cargar'));
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;
              if (docs.isEmpty) return const Center(child: Text('No hay alertas disponibles'));

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  final doc = docs[index];
                  final tipo = data['tipo'] ?? 'Desconocido';
                  final autor = data['nombreUsuario'] ?? 'Anónimo';
                  final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
                  final fecha = timestamp != null
                      ? DateFormat('dd MMM yyyy, hh:mm a').format(timestamp)
                      : 'Sin fecha';
                  final finalizado = data['estado'] == 'finalizado';

                  Color color;
                  if (tipo == 'Salud') color = AppTheme.azulOscuro;
                  else if (tipo == 'Bomberos') color = Colors.red;
                  else color = Colors.amber.shade700;

                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlertaDetalleScreen(alerta: doc)),
                    ),
                    child: _buildAlertCard(tipo, autor, fecha, color, finalizado, doc.id),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard(String tipo, String autor, String fecha, Color color, bool finalizado, String docId) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: color, width: 4))
      ),
      child: Row(
        children: [
          Icon(tipo == 'Salud' ? Icons.medical_services : tipo == 'Bomberos' ? Icons.fire_truck : Icons.security, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tipo, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                            child: Text(finalizado ? 'FINALIZADO' : 'EN PROCESO', style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold))
                        )
                      ]
                  ),
                  Text('Reportado por: $autor', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  Text(fecha, style: const TextStyle(fontSize: 11, color: Colors.black45)),
                ]
            ),
          ),
          if (!finalizado)
            IconButton(
              icon: Icon(Icons.check_circle_outline, color: color),
              onPressed: () => DatabaseService().finalizarAlerta(docId),
            ),
        ],
      ),
    );
  }
}