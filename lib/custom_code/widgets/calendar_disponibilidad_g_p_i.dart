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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class CalendarDisponibilidadGPI extends StatefulWidget {
  const CalendarDisponibilidadGPI({
    super.key,
    this.width,
    this.height,
    this.idPropiedad,
    this.idCurrentUser,
  });

  final double? width;
  final double? height;
  final String? idPropiedad;
  final String? idCurrentUser;

  @override
  State<CalendarDisponibilidadGPI> createState() =>
      _CalendarDisponibilidadGPIState();
}

class _CalendarDisponibilidadGPIState extends State<CalendarDisponibilidadGPI> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Map<String, dynamic>> _availableSlots = [];
  List<Map<String, dynamic>> _bookedSlots = [];
  List<Map<String, dynamic>> _myBookedSlots = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchAvailability();
    _fetchBookedSlots();
  }

  Future<void> _fetchAvailability() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('agendaGpi')
          //.where('idPropiedad', isEqualTo: widget.idPropiedad). NO APLICA PARA VISITAS GPI TOURS SOLO PARA VER CASAS
          .get();

      List<Map<String, dynamic>> slots = [];
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime day = (data['selectedDay'] as Timestamp).toDate();
        TimeOfDay startTime = _parseTimeOfDay(data['startTime']);
        TimeOfDay endTime = _parseTimeOfDay(data['endTime']);

        slots.add({
          'day': day,
          'startTime': startTime,
          'endTime': endTime,
        });
      }

      setState(() {
        _availableSlots = slots;
      });
    } catch (e) {
      print('Error fetching availability: $e');
    }
  }

  Future<void> _fetchBookedSlots() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('agendarToursUsers')
          .where('idPropiedad', isEqualTo: widget.idPropiedad)
          .get();

      List<Map<String, dynamic>> slots = [];
      List<Map<String, dynamic>> mySlots = [];
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime startDateTime = (data['startDateTime'] as Timestamp).toDate();
        DateTime endDateTime = (data['endDateTime'] as Timestamp).toDate();
        String userId = data['idCurrentUser'];
        String idPropiedad = data['idPropiedad'];

        var slot = {
          'startDateTime': startDateTime,
          'endDateTime': endDateTime,
          'userId': userId,
          'idPropiedad': idPropiedad,
        };

        slots.add(slot);
        if (userId == widget.idCurrentUser) {
          mySlots.add(slot);
        }
      }

      setState(() {
        _bookedSlots = slots;
        _myBookedSlots = mySlots;
      });
    } catch (e) {
      print('Error fetching booked slots: $e');
    }
  }

  bool _isSlotBooked(DateTime date, TimeOfDay startTime, TimeOfDay endTime) {
    DateTime startDateTime = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    for (var slot in _bookedSlots) {
      if (startDateTime.isBefore(slot['endDateTime']) &&
          endDateTime.isAfter(slot['startDateTime'])) {
        return true;
      }
    }
    return false;
  }

  bool _hasExistingBooking() {
    for (var slot in _bookedSlots) {
      if (slot['userId'] == widget.idCurrentUser &&
          slot['idPropiedad'] == widget.idPropiedad) {
        return true;
      }
    }
    return false;
  }

  Future<void> _confirmAppointment(DateTime date, TimeOfDay startTime) async {
    if (_hasExistingBooking()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ya tienes una cita agendada para esta propiedad.')));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Cita'),
          content: Text(
              '¿Deseas agendar una cita el ${date.day}/${date.month}/${date.year} de ${startTime.format(context)} a ${startTime.replacing(hour: startTime.hour + 2).format(context)}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                _bookAppointment(date, startTime); // Reservar la cita
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _bookAppointment(DateTime date, TimeOfDay startTime) async {
    DateTime startDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      startTime.hour,
      startTime.minute,
    );

    DateTime endDateTime = startDateTime.add(Duration(hours: 2));

    try {
      await _firestore.collection('agendarToursUsers').add({
        'idCurrentUser': widget.idCurrentUser,
        'idPropiedad': widget.idPropiedad,
        'startDateTime': startDateTime,
        'endDateTime': endDateTime,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cita agendada con éxito')));
      _fetchBookedSlots(); // Refresh booked slots
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agendar la cita: $e')));
    }
  }

  Future<void> _cancelAppointment(Map<String, dynamic> slot) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('agendarToursUsers')
          .where('idCurrentUser', isEqualTo: widget.idCurrentUser)
          .where('idPropiedad', isEqualTo: widget.idPropiedad)
          .where('startDateTime', isEqualTo: slot['startDateTime'])
          .get();

      for (var doc in snapshot.docs) {
        await _firestore.collection('agendarToursUsers').doc(doc.id).delete();
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cita cancelada con éxito')));
      _fetchBookedSlots(); // Refresh booked slots
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cancelar la cita: $e')));
    }
  }

  Future<void> _addReminder(Map<String, dynamic> slot) async {
    DateTime startDateTime = slot['startDateTime'];
    DateTime reminderTime = startDateTime.subtract(Duration(days: 1));

    final Event event = Event(
      title: 'Visita Programada GPI-Homes',
      description: 'Levantamiento de Tour Virtual 360',
      location: 'Propiedad ID: ${widget.idPropiedad}',
      startDate: startDateTime,
      endDate: slot['endDateTime'],
      iosParams: IOSParams(
        reminder: Duration(days: 1),
      ),
      androidParams: AndroidParams(
        emailInvites: [],
      ),
    );

    Add2Calendar.addEvent2Cal(event);
  }

  TimeOfDay _parseTimeOfDay(String time) {
    try {
      final parts = time.split(' ');
      final timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      if (parts.length > 1) {
        if (parts[1] == 'PM' && hour != 12) hour += 12;
        if (parts[1] == 'AM' && hour == 12) hour = 0;
      }
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      throw FormatException('Invalid time format');
    }
  }

  List<TimeOfDay> _getTimeSlots(TimeOfDay start, TimeOfDay end) {
    List<TimeOfDay> slots = [];
    TimeOfDay current = start;
    while (_timeOfDayToMinutes(current) + 120 <= _timeOfDayToMinutes(end)) {
      slots.add(current);
      current = _addMinutes(current, 120);
    }
    return slots;
  }

  int _timeOfDayToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
    int totalMinutes = _timeOfDayToMinutes(time) + minutes;
    int hours = totalMinutes ~/ 60;
    int mins = totalMinutes % 60;
    return TimeOfDay(hour: hours, minute: mins);
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
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 16),
          Text('Horarios disponibles:'),
          Expanded(
            child: ListView.builder(
              itemCount: _availableSlots.length,
              itemBuilder: (context, index) {
                var slot = _availableSlots[index];
                DateTime day = slot['day'];
                TimeOfDay startTime = slot['startTime'];
                TimeOfDay endTime = slot['endTime'];

                if (!isSameDay(day, _selectedDay)) {
                  return Container();
                }

                List<TimeOfDay> timeSlots = _getTimeSlots(startTime, endTime);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: timeSlots.map((timeSlot) {
                    bool isBooked = _isSlotBooked(
                        day, timeSlot, _addMinutes(timeSlot, 120));
                    String? bookedUserId;
                    String? bookedidPropiedad;
                    if (isBooked) {
                      for (var bookedSlot in _bookedSlots) {
                        if (isSameDay(bookedSlot['startDateTime'], day) &&
                            bookedSlot['startDateTime'].hour == timeSlot.hour &&
                            bookedSlot['startDateTime'].minute ==
                                timeSlot.minute) {
                          bookedUserId = bookedSlot['userId'];
                          bookedidPropiedad = bookedSlot['idPropiedad'];
                          break;
                        }
                      }
                    }

                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            '${timeSlot.format(context)} - ${_addMinutes(timeSlot, 120).format(context)}',
                            style: TextStyle(
                              color: isBooked ? Colors.red : Colors.green,
                            ),
                          ),
                          if (isBooked && bookedUserId != null) ...[
                            SizedBox(width: 8),
                            Text(
                              'User: ' + '($bookedUserId)',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'idProp:' + '($bookedidPropiedad)',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ],
                      ),
                      trailing: isBooked && bookedUserId == widget.idCurrentUser
                          ? IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red),
                              onPressed: () => _cancelAppointment({
                                'startDateTime': DateTime(
                                  day.year,
                                  day.month,
                                  day.day,
                                  timeSlot.hour,
                                  timeSlot.minute,
                                ),
                              }),
                            )
                          : null,
                      onTap: isBooked
                          ? null
                          : () => _confirmAppointment(day, timeSlot),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // SizedBox(height: 16),
          // Text('Mis Horarios Programados:'),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _myBookedSlots.length,
          //     itemBuilder: (context, index) {
          //       var slot = _myBookedSlots[index];
          //       DateTime startDateTime = slot['startDateTime'];
          //       DateTime endDateTime = slot['endDateTime'];

          //       if (startDateTime.isBefore(DateTime.now())) {
          //         return Container();
          //       }

          //       return ListTile(
          //         title: Text(
          //           '${startDateTime.day}/${startDateTime.month}/${startDateTime.year} '
          //           '${TimeOfDay.fromDateTime(startDateTime).format(context)} - '
          //           '${TimeOfDay.fromDateTime(endDateTime).format(context)}',
          //         ),
          //         trailing: IconButton(
          //           icon: Icon(Icons.add_alert),
          //           onPressed: () => _addReminder(slot),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          SizedBox(height: 16),
          Text('Todos los Horarios Programados:'),
          Expanded(
            child: ListView.builder(
              itemCount: _bookedSlots.length,
              itemBuilder: (context, index) {
                var slot = _bookedSlots[index];
                DateTime startDateTime = slot['startDateTime'];
                DateTime endDateTime = slot['endDateTime'];

                if (startDateTime.isBefore(DateTime.now())) {
                  return Container();
                }

                return ListTile(
                  title: Text(
                    '${startDateTime.day}/${startDateTime.month}/${startDateTime.year} '
                    '${TimeOfDay.fromDateTime(startDateTime).format(context)} - '
                    '${TimeOfDay.fromDateTime(endDateTime).format(context)}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add_alert),
                    onPressed: () => _addReminder(slot),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
