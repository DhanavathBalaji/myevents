
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class calender extends StatelessWidget {
  const calender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        firstDay: DateTime.utc(2001, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),

    );
  }
}
