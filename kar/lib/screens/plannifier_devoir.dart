import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart' show TableCalendar, isSameDay;

class PlannifierDevoir extends StatefulWidget {
  const PlannifierDevoir({super.key});

  @override
  State<PlannifierDevoir> createState() => _PlannifierDevoirState();
}

class _PlannifierDevoirState extends State<PlannifierDevoir> {

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Devoir"),
      ),

      body: TableCalendar(
        locale: 'fr_FR',
        focusedDay: focusedDay,
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
        },
      ),
    ));
  }
}
