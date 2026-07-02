import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos el inicio de hoy a las 00:00:00
    final DateTime ahora = DateTime.now();
    final DateTime inicioDeHoy = DateTime(ahora.year, ahora.month, ahora.day);
    final Timestamp inicioTimestamp = Timestamp.fromDate(inicioDeHoy);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notificaciones de hoy", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('alertas')
            .where('timestamp', isGreaterThanOrEqualTo: inicioTimestamp)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay alertas nuevas hoy"));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final tipo = data['tipo'] ?? 'Alerta';
              final autor = data['nombreUsuario'] ?? 'Anónimo';
              final fecha = (data['timestamp'] as Timestamp?)?.toDate();
              final hora = fecha != null ? DateFormat('HH:mm').format(fecha) : '';

              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.warning_amber_rounded, color: Colors.red),
                ),
                title: Text("Emergencia de $tipo", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Reportado por $autor a las $hora"),
              );
            },
          );
        },
      ),
    );
  }
}