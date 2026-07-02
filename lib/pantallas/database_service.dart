import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> crearUsuario(String uid, String email, String nombre) async {
    String rol = email.endsWith('@unach.cl') ? 'Funcionario' : 'Estudiante';
    await _db.collection('usuarios').doc(uid).set({
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'rol': rol,
      'facultades': [],
      'perfilConfigurado': false,
      'fechaCreacion': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot> obtenerUsuario(String uid) async {
    return await _db.collection('usuarios').doc(uid).get();
  }

  Future<void> registrarAlerta(String tipo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      double lat = 0.0;
      double lon = 0.0;

      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high
          );
          lat = position.latitude;
          lon = position.longitude;
        }
      } catch (e) {
        lat = 0.0;
        lon = 0.0;
      }

      await _db.collection('alertas').add({
        'usuarioId': user.uid,
        'nombreUsuario': user.displayName ?? 'Anónimo',
        'tipo': tipo,
        'timestamp': FieldValue.serverTimestamp(),
        'estado': 'pendiente',
        'latitud': lat,
        'longitud': lon,
      });
    }
  }

  Future<void> finalizarAlerta(String docId) async {
    await _db.collection('alertas').doc(docId).update({
      'estado': 'finalizado',
    });
  }
}