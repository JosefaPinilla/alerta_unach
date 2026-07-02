import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertaDetalleScreen extends StatelessWidget {
  final DocumentSnapshot alerta;

  const AlertaDetalleScreen({super.key, required this.alerta});

  Future<void> _abrirMapa(String lat, String lng) async {
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final esAutor = user?.uid == alerta['usuarioId'];
    final data = alerta.data() as Map<String, dynamic>;
    final tipo = data['tipo'] ?? 'Emergencia';
    final nombreUsuario = data['nombreUsuario'] ?? 'Usuario';
    final lat = data['latitud']?.toString() ?? '0.0';
    final lng = data['longitud']?.toString() ?? '0.0';
    final bool finalizado = data['estado'] == 'finalizado';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
              decoration: const BoxDecoration(color: Color(0xFFD32F2F)),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
                  SizedBox(width: 8),
                  Text("Detalle de Emergencia", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)),
                    child: Text(tipo.toUpperCase(), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline, size: 50, color: Colors.black45),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("REPORTADO POR", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
                            Text(nombreUsuario, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _abrirMapa(lat, lng),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Icon(Icons.map, color: Colors.blue, size: 30),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("UBICACIÓN (Presiona para abrir Google Maps)", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.blue)),
                                Text("$lat, $lng", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: esAutor && !finalizado ? const Color(0xFF001F3F) : Colors.grey.shade200,
                          foregroundColor: esAutor && !finalizado ? Colors.white : Colors.black
                      ),
                      onPressed: () {
                        if (esAutor && !finalizado) {
                          alerta.reference.update({'estado': 'finalizado'});
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(esAutor && !finalizado ? "Finalizar Emergencia" : "Volver"),
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