const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.enviarNotificacionAlerta = functions.firestore
    .document("alertas/{alertaId}")
    .onCreate(async (snap, context) => {
        const nuevaAlerta = snap.data();

        const usuariosRef = await admin.firestore().collection("usuarios")
            .where("facultades", "array-contains", nuevaAlerta.facultad)
            .get();

        const tokens = usuariosRef.docs
            .map(doc => doc.data().fcmToken)
            .filter(token => token !== undefined);

        if (tokens.length === 0) return null;

        // Estructura mejorada: notification para el aviso, data para la lógica interna
        const message = {
            notification: {
                title: "¡Emergencia en " + nuevaAlerta.facultad + "!",
                body: "Tipo de alerta: " + nuevaAlerta.tipo + ". Revisa la app ahora."
            },
            data: {
                alertaId: context.params.alertaId,
                latitud: String(nuevaAlerta.latitud || ""),
                longitud: String(nuevaAlerta.longitud || ""),
                tipo: nuevaAlerta.tipo
            },
            tokens: tokens,
        };

        return admin.messaging().sendMulticast(message);
    });