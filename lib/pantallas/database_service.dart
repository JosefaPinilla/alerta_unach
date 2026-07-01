import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> crearUsuario(String uid, String email, String nombre) async {
    await _db.collection('usuarios').doc(uid).set({
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'perfilConfigurado': false, // Esto nos servirá para saber si falta configurar
      'fechaCreacion': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot> obtenerUsuario(String uid) async {
    return await _db.collection('usuarios').doc(uid).get();
  }
}