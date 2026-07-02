const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.enviarNotificacionAlerta = functions.firestore
    .document("alertas/{alertaId}")
    .onCreate(async (snap, context) => {
        const nuevaAlerta = snap.data();

        // Buscamos usuarios de la misma facultad para enviarles el aviso
        const usuariosRef = await admin.firestore().collection("usuarios")
            .where("facultades", "array-contains", nuevaAlerta.facultad)
            .get();

        const tokens = usuariosRef.docs
            .map(doc => doc.data().fcmToken)
            .filter(token => token !== undefined);

        if (tokens.length === 0) return null;

        const message = {
            notification: {
                title: "¡Emergencia en " + nuevaAlerta.facultad + "!",
                body: "Tipo de alerta: " + nuevaAlerta.tipo + ". Revisa la app ahora."
            },
            tokens: tokens,
        };

        return admin.messaging().sendMulticast(message);
    });