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

import 'index.dart'; // Imports other custom widgets

// ++++PARA QUE LOS USUARIOS VEAN LA DISPONIBILIDAD DE GPI PARA SOLICITAR UN TOURVIRTUAL

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTourWidget extends StatefulWidget {
  const CalendarTourWidget({
    super.key,
    this.width,
    this.height,
    this.idUser,
    this.idPropiedad,
  });

  final double? width;
  final double? height;
  final String? idUser;
  final String? idPropiedad;

  @override
  State<CalendarTourWidget> createState() => _CalendarTourWidgetState();
}

class _CalendarTourWidgetState extends State<CalendarTourWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  Future<void> _saveAvailability() async {
    if (_startTime == null || _endTime == null) {
      // Mostrar un mensaje de error si faltan datos
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor selecciona un rango de tiempo')));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar disponibilidad"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Fecha: ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}"),
              Text("Hora de inicio: ${_startTime!.hour}:${_startTime!.minute}"),
              Text("Hora de fin: ${_endTime!.hour}:${_endTime!.minute}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                // Convertir la fecha y hora a UTC-6
                final selectedDateTimeUtc6 = DateTime(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                  _startTime!.hour,
                  _startTime!.minute,
                ).toUtc().subtract(Duration(hours: 6));

                final endTimeDateTimeUtc6 = DateTime(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                  _endTime!.hour,
                  _endTime!.minute,
                ).toUtc().subtract(Duration(hours: 6));

                try {
                  await _firestore.collection('agendaGpi').add({
                    'idUser': widget.idUser ??
                        'cUuHlqYREtWZecZI5mT2uyx0Fid2', // Usar el valor del widget si está disponible
                    'idPropiedad': widget.idPropiedad ??
                        '5QHFnZyyL2SmAGIq4CZE', // Usar el valor del widget si está disponible
                    'selectedDay': Timestamp.fromDate(selectedDateTimeUtc6),
                    'startTime': _startTime!.format(context),
                    'endTime': _endTime!.format(context),
                  });

                  // Resetear los valores de tiempo después de guardar
                  setState(() {
                    _startTime = null;
                    _endTime = null;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Disponibilidad guardada con éxito')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error al guardar la disponibilidad: $e')));
                }
                Navigator.of(context).pop();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAvailability(String docId) async {
    try {
      await _firestore.collection('agendaGpi').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Disponibilidad eliminada con éxito')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar la disponibilidad: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _selectedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _selectedDay = focusedDay;
            },
          ),
          SizedBox(height: 16),
          Text('Selecciona rango de tiempo'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _startTime = pickedTime;
                    });
                  }
                },
                child: Text(_startTime == null
                    ? 'Hora de inicio'
                    : _startTime!.format(context)),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _endTime = pickedTime;
                    });
                  }
                },
                child: Text(_endTime == null
                    ? 'Hora de fin'
                    : _endTime!.format(context)),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saveAvailability,
            child: Text('Guardar Disponibilidad'),
          ),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('agendaGpi')
                  .orderBy('selectedDay', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return Center(child: Text('No hay disponibilidades.'));
                }
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(
                            'Fecha: ${data['selectedDay'].toDate().day}/${data['selectedDay'].toDate().month}/${data['selectedDay'].toDate().year}, '
                            'Inicio: ${data['startTime']}, Fin: ${data['endTime']}'),
                        subtitle: Text(
                            'ID Usuario: ${data['idUser']}, ID Propiedad: ${data['idPropiedad']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteAvailability(doc.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
