// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//PARA ABIR LA DISPONIBILIDAD DEL USUARIO DE LA PROPIEDAD Y AGENDAR UNA CITA

class CalendarDateViewer extends StatefulWidget {
  const CalendarDateViewer({
    super.key,
    this.width,
    this.height,
    this.idPropietario,
  });

  final double? width;
  final double? height;
  final String? idPropietario;

  @override
  State<CalendarDateViewer> createState() => _CalendarDateViewerState();
}

class _CalendarDateViewerState extends State<CalendarDateViewer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
