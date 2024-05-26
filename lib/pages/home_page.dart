import 'package:flutter/material.dart';
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
  Map<DateTime, List<String>> _events = {}; // Evenimentele tale
  int _workoutStreak = 0;
  int _checkedDaysCount = 0;
  int _daysInMonth = DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    // Incarca evenimentele aici
    final workoutDates = [
      DateTime.utc(2024, 5, 1),
      DateTime.utc(2024, 5, 2),
      DateTime.utc(2024, 5, 3),
    ];

    // Initializeaza evenimentele
    for (var date in workoutDates) {
      _events[date] = ['Workout'];
    }

    _updateWorkoutStreak();
    _updateCheckedDaysCount();
  }

  void _updateWorkoutStreak() {
    DateTime today = DateTime.now();
    int streak = 0;
    DateTime date = today;

    while (_events.containsKey(date)) {
      streak++;
      date = date.subtract(Duration(days: 1));
    }

    setState(() {
      _workoutStreak = streak;
    });
  }

  void _updateCheckedDaysCount() {
    setState(() {
      _checkedDaysCount = _events.keys.where((date) {
        return date.year == _focusedDay.year && date.month == _focusedDay.month;
      }).length;
    });
  }

  void _toggleDaySelection(DateTime day) {
    setState(() {
      if (_events.containsKey(day)) {
        _events.remove(day);
      } else {
        _events[day] = ['Workout'];
      }
      _updateCheckedDaysCount();
      _updateWorkoutStreak();
    });
  }

  Shader linearGradient = LinearGradient(
    colors: [
      Color(0xFF6E944F), // 0%
      Color(0xFFFFFFFF), // 27%
      Color(0xFFE49B47), // 67%
      Color(0xFF6E944F), // 100%
    ],
    stops: [0.0, 0.27, 0.67, 1.0],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
        // Meniul tău Drawer aici
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/images/home_page.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Positioned text messages
          Positioned(
            left: 93 / 411 * screenWidth,
            top: 182 / 731 * screenHeight,
            child: Text(
              'Workout Days Check',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                color: Colors.white, // Culoare text albă
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            left: 70 / 411 * screenWidth,
            top: 205 / 731 * screenHeight,
            child: Stack(
              children: [
                // Text cu contur negru
                Text(
                  'Hard work pays off',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.black, // Contur negru
                  ),
                  textAlign: TextAlign.center,
                ),
                // Text gradient
                Text(
                  'Hard work pays off',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    foreground: Paint()..shader = linearGradient,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
  left: 148 / 411 * screenWidth,
  top: 280 / 731 * screenHeight,
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white, // Fundal alb
      borderRadius: BorderRadius.circular(8.0), // Colțuri rotunjite
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Workout Strike:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'JosefinSans',
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4), // Spațiu între text și număr
        Text(
          '$_checkedDaysCount/$_daysInMonth',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'JosefinSans',
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
),
          Positioned(
            left: 178 / 411 * screenWidth,
            top: 296 / 731 * screenHeight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white, // Fundal alb
                borderRadius: BorderRadius.circular(8.0), // Colțuri rotunjite
              ),
              child: Text(
                '$_checkedDaysCount/$_daysInMonth',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'JosefinSans',
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Positioned calendar
          Positioned(
            left: 13 / 411 * screenWidth,
            top: 386 / 731 * screenHeight,
            width: 371 / 411 * screenWidth,
            height: 377 / 731 * screenHeight,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Color(0xFF6E944F), // Fundalul calendarului
                borderRadius: BorderRadius.circular(screenWidth * 0.03), // Colțurile rotunjite ale calendarului
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: screenWidth * 0.03,
                    offset: Offset(0, screenWidth * 0.01),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.03), // Colțurile rotunjite pentru a aplica și la copii
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _toggleDaySelection(selectedDay);
                    });
                  },
                  eventLoader: (day) {
                    return _events[day] ?? [];
                  },
                  calendarStyle: CalendarStyle(
                    // Customizează stilul calendarului aici
                    todayDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                    defaultDecoration: BoxDecoration(
                      color: Colors.white, // Zilele neselectate albe
                      shape: BoxShape.circle, // Colțurile rotunjite pentru zile
                    ),
                    weekendDecoration: BoxDecoration(
                      color: Colors.white, // Zilele de weekend albe
                      shape: BoxShape.circle, // Colțurile rotunjite pentru zilele de weekend
                    ),
                    holidayDecoration: BoxDecoration(
                      color: Colors.white, // Zilele de sărbătoare albe
                      shape: BoxShape.circle, // Colțurile rotunjite pentru zilele de sărbătoare
                    ),
                    defaultTextStyle: TextStyle(color: Colors.black),
                    weekendTextStyle: TextStyle(color: Colors.black),
                    holidayTextStyle: TextStyle(color: Colors.black),
                    outsideTextStyle: TextStyle(color: Colors.grey),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      fontSize: screenWidth * 0.06, 
                      color: Colors.white
                    ), // Mărește textul lunii curente
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                    decoration: BoxDecoration(
                      color: Color(0xFF6E944F),
                    ),
                  ),
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _daysInMonth = DateUtils.getDaysInMonth(focusedDay.year, focusedDay.month);
                      _updateCheckedDaysCount();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateUtils {
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
