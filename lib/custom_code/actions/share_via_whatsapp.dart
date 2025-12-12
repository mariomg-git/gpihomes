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

import 'package:url_launcher/url_launcher.dart';

Future<void> shareViaWhatsapp(
  String propertyId,
  String propertyName,
  String propertyPrice,
) async {
  // Generar URL única
  final shareUrl =
      'https://gpipropiedades.web.app/propertyDetails?propertyRef=$propertyId';

  // Mensaje pre-formateado para WhatsApp
  final message = '¡Hola! 👋\n\n'
      'Encontré esta propiedad que te puede interesar:\n\n'
      '🏠 *$propertyName*\n'
      '💰 Precio: *$propertyPrice*\n\n'
      '✅ Ver detalles completos aquí:\n'
      '$shareUrl\n\n'
      '_Enviado desde GPI Homes_';

  // Codificar el mensaje para URL
  final encodedMessage = Uri.encodeComponent(message);

  // URL de WhatsApp
  final whatsappUrl = 'https://wa.me/?text=$encodedMessage';

  print('📱 Compartiendo por WhatsApp: $whatsappUrl');

  try {
    final uri = Uri.parse(whatsappUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      print('✅ WhatsApp abierto');
    } else {
      print('❌ No se puede abrir WhatsApp');
    }
  } catch (e) {
    print('❌ Error al abrir WhatsApp: $e');
  }
}
