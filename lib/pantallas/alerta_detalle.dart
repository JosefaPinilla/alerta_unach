import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlertaDetalleScreen extends StatelessWidget {
  final DocumentSnapshot alerta;

  const AlertaDetalleScreen({super.key, required this.alerta});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final esAutor = user?.uid == alerta['usuarioId'];
    final data = alerta.data() as Map<String, dynamic>;
    final tipo = data['tipo'] ?? 'Emergencia';
    final nombreUsuario = data['nombreUsuario'] ?? 'Usuario';
    final lugar = data['lugar'] ?? 'Ubicación no especificada';

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
                  Text("Nueva Alerta de Emergencia", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
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
                  const SizedBox(height: 16),
                  const Text("Se ha registrado una emergencia dentro de tu grupo institucional.", style: TextStyle(fontSize: 16)),
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
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
                    child: const Center(child: Icon(Icons.map, size: 50, color: Colors.black26)),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF001F3F), foregroundColor: Colors.white),
                      onPressed: () {
                        // AQUÍ ESTÁ LA SEGURIDAD: Solo si eres autor, intentas escribir.
                        // Si no eres autor, la app solo te saca de la pantalla.
                        if (esAutor) {
                          alerta.reference.update({'estado': 'finalizado'});
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text("Entendido"),
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