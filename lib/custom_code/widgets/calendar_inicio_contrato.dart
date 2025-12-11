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

import 'package:table_calendar/table_calendar.dart';

class CalendarInicioContrato extends StatefulWidget {
  const CalendarInicioContrato({
    super.key,
    this.width,
    this.height,
    this.fCalendarInicio,
  });

  final double? width;
  final double? height;
  final DateTime? fCalendarInicio;

  @override
  State<CalendarInicioContrato> createState() => _CalendarInicioContratoState();
}

class _CalendarInicioContratoState extends State<CalendarInicioContrato> {
  DateTime? selectedDate;

  // Function to convert to UTC-6
  DateTime toUtcMinus6(DateTime dateTime) {
    return dateTime.toUtc().subtract(Duration(hours: 6));
  }

  DateTime get minSelectableDate {
    DateTime startDate = widget.fCalendarInicio != null
        ? widget.fCalendarInicio!
        : DateTime.now();
    return toUtcMinus6(
        startDate.add(Duration(days: 0))); //agregar dias despues de x fecha
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: minSelectableDate,
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          DateTime utcMinus6SelectedDay =
              toUtcMinus6(selectedDay).add(Duration(days: 1));
          if (utcMinus6SelectedDay
              .isAfter(minSelectableDate.subtract(Duration(days: 0)))) {
            //resta dias al seleccionada
            setState(() {
              selectedDate = selectedDay;
              FFAppState().fInicioContrato = utcMinus6SelectedDay;
            });
          }
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            DateTime utcMinus6Day = toUtcMinus6(day);
            if (utcMinus6Day.isBefore(minSelectableDate)) {
              return Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                      color: Colors.grey), // Custom style for disabled dates
                ),
              );
            }
            return null;
          },
        ),
        calendarStyle: CalendarStyle(
          disabledTextStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
