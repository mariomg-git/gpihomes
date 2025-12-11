// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addFavoritos(
  String? idUserProp,
  String? idPropProp,
) async {
  try {
    // Referencia a la colección 'favoritos'
    DocumentReference favoritoRef =
        FirebaseFirestore.instance.collection('favoritos').doc();

    // Inserta el nuevo documento en 'favoritos' con el campo 'idUsuario'
    await favoritoRef.set({
      'idUser': idUserProp,
    });

    // Inserta el subdocumento 'favProps' con id '00001' y el campo 'idPropertie'
    await favoritoRef.collection('favPropers').doc(idPropProp).set({
      'idPropertie': idPropProp,
    });

    print('Documento y subdocumento agregados exitosamente.');
  } catch (e) {
    print('Error al agregar el documento: $e');
  }
}
