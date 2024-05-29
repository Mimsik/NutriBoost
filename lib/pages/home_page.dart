import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'account_page.dart';
import 'login_page.dart'; // Importă pagina de login

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
    // Încarcă evenimentele aici
    final workoutDates = [
      DateTime.utc(2024, 5, 1),
      DateTime.utc(2024, 5, 2),
      DateTime.utc(2024, 5, 3),
    ];

    // Initializează evenimentele
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
        child: Container(
          width: screenWidth * 0.6, // 60% din lățimea ecranului
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Buton pentru închidere meniu
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildMenuButton('Search macronutrients', screenWidth),
              SizedBox(height: screenHeight * 0.01),
              _buildMenuButton('Account', screenWidth),
              SizedBox(height: screenHeight * 0.01),
              _buildMenuButton('Settings', screenWidth),
              Spacer(),
              _buildMenuButton('Logout', screenWidth),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
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
          // Meniu buton
          Positioned(
            top: 16,
            left: 16,
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 20, height: 2, color: Colors.black),
                        SizedBox(height: 4),
                        Container(width: 20, height: 2, color: Colors.black),
                        SizedBox(height: 4),
                        Container(width: 20, height: 2, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Positioned text messages
          Positioned(
            left: 93 / 411 * screenWidth,
            top: (182 - 80) / 731 * screenHeight, // ridicat mai sus
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
            top: (205 - 80) / 731 * screenHeight, // ridicat mai sus
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
            top: (280 - 80) / 731 * screenHeight, // ridicat mai sus
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white, // Fundal alb
                borderRadius: BorderRadius.circular(15.0), // Colțuri rotunjite
              ),
              child: Column(
                children: [
                  Text(
                    'Workout strike:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JosefinSans',
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$_checkedDaysCount/$_daysInMonth',
                    style: TextStyle(
                      fontSize: 20,
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
          // Positioned calendar
          Positioned(
            left: 13 / 411 * screenWidth,
            top: 320 / 731 * screenHeight,
            width: 380 / 411 * screenWidth, // lățit calendarul
            height: 400 / 731 * screenHeight, // lățit calendarul
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Color(0xFF6E944F), // Fundalul calendarului
                borderRadius: BorderRadius.circular(screenWidth * 0.07), // Colțurile rotunjite ale calendarului
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
                    defaultTextStyle: TextStyle(color: Colors.black, fontFamily: 'JosefinSans'),
                    weekendTextStyle: TextStyle(color: Colors.black, fontFamily: 'JosefinSans'),
                    holidayTextStyle: TextStyle(color: Colors.black, fontFamily: 'JosefinSans'),
                    outsideTextStyle: TextStyle(color: Colors.grey, fontFamily: 'JosefinSans'),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontFamily: 'JosefinSans',
                      color: Colors.white,
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

  Widget _buildMenuButton(String text, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01), // Distanța dintre butoane
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
            ),
            minimumSize: Size(screenWidth * 0.7, 40), // Setarea dimensiunii butoanelor la 70% din lățimea drawerului
          ),
          onPressed: () {
            if (text == 'Account') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            } else if (text == 'Settings') {
              // Navigare la pagina de Settings
            } else if (text == 'Search macronutrients') {
              // Navigare la pagina de Search macronutrients
            } else if (text == 'Logout') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogInPage()),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
            child: Text(
              text,
              style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'JosefinSans'),
            ),
          ),
        ),
      ),
    );
  }
}

class DateUtils {
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
