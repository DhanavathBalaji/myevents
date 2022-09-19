// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:evnts/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../utils.dart';

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  String user="  ";
  void fire()
  {
    FirebaseFirestore.instance
        .collection("event").doc("event").get().then((DocumentSnapshot file) {


          file["event"].forEach((key,value) {
            DateTime f=DateTime.parse(key);
            List<dynamic> l=value;
            List<Event> m=[];
            l.forEach((element) {m.add(Event(element)); });
            kEvents.addAll({
              f: m,
            });


          });

    });
  }

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }


  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)?.settings.arguments as String;
    fire();
    print(user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar - Events'),
        backgroundColor: Colors.deepPurpleAccent,


      ),

      // drawer: Drawer(
      //
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //
      //     children:  <Widget>[
      //
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text(
      //           'Drawer Header',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),


      drawer: Drawer
        (

        child: ListView
          (
          padding: EdgeInsets.zero,
          children: <Widget>
          [

            SizedBox(

                height: 100,
                child: DrawerHeader
                  (
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("MENU",
                      style: TextStyle(
                        color:Colors.white,
                      ),),
                  ),
                  decoration: BoxDecoration
                    (
                      color: Colors.deepPurpleAccent,
                  ),
                )
            ),
            // ListTile(
            //   leading: Icon(Icons.message),
            //   title: Text('Home'),
            //
            // ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('ToDo list'),
              onTap: (){
                Navigator.pushNamed(context, 'todoL',arguments: user);
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Manage event'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Row(
                          children: [
                            Text('${value[index]}'),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                              ),
                              onPressed: () {
                                // List<String> L=
                                try
                                {

                                  DateFormat formatter = DateFormat('yyyy-MM-dd');
                                  String s=formatter.format(_selectedDay!);
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user)
                                      .update({ "event.$s": FieldValue.arrayUnion(['${value[index]}']),});
                                }
                                catch(e){ print(e); }

                              },
                              child: Text('Add to TODO'),
                            )
                          ],
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