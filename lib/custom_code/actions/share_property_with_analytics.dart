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

import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> sharePropertyWithAnalytics(
  String propertyId,
  String propertyName,
  String propertyPrice,
  String? propertyImage,
) async {
  // Generar URL única para compartir
  final shareUrl =
      'https://gpipropiedades.web.app/propertyDetails?propertyRef=$propertyId';

  // Texto para compartir
  final shareText = '🏠 $propertyName\n'
      '💰 Precio: $propertyPrice\n'
      '✅ Ver detalles: $shareUrl';

  print('🔗 Compartiendo propiedad: $shareUrl');

  try {
    // Registrar el evento de compartir en Firestore (Analytics)
    await FirebaseFirestore.instance.collection('property_shares').add({
      'propertyId': propertyId,
      'propertyName': propertyName,
      'shareUrl': shareUrl,
      'sharedAt': FieldValue.serverTimestamp(),
      'platform': 'web', // Puedes detectar la plataforma
    });

    print('✅ Analytics registrado');

    // Compartir
    await Share.share(
      shareText,
      subject: 'Mira esta propiedad en GPI Homes',
    );
  } catch (e) {
    print('❌ Error al compartir: $e');
  }
}
