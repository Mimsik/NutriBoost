import 'package:flutter/material.dart';
// Asumăm că ai deja un pachet pentru calendar, de exemplu table_calendar sau altul similar.
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _events = {}; // Evenimentele tale, probabil că vor veni dintr-o sursă dinamică sau din state management
  int _workoutStrike = 0; // Aici poți să ții evidența seriei de antrenamente

  // Aici poți să construiești o metodă care actualizează _workoutStreak și _events

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Days Check'),
      ),
      drawer: Drawer(
        // ... Meniul tău Drawer aici ...
      ),
      body: Column(
        children: <Widget>[
          // Adăugați mesajul motivational și workout streak aici
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hard work pays off',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Workout strike: $_workoutStrike/31',
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Adaugă calendarul aici
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                // Aici ai putea să actualizezi și workout streak
              });
            },
            // ... alte proprietăți ale calendarului ...
          ),
        ],
      ),
    );
  }
}
