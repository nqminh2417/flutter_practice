import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late PageController _pageController;
  int _currentMonthIndex = 0;
  final List<String> dayHeaders = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  final DateTime curDate = DateTime.now();

  final String curMonth = DateFormat('MMMM').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentMonthIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _incrementMonth() {
    setState(() {
      _currentMonthIndex++;
    });
  }

  void _decrementMonth() {
    setState(() {
      _currentMonthIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(curDate.year, curDate.month + 1, 0).day;
    final firstDayOfWeek = DateTime(curDate.year, curDate.month, 1).weekday;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("$curMonth$_currentMonthIndex"),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // Swiped left
            _incrementMonth();
          } else if (details.primaryVelocity! > 0) {
            // Swiped right
            _decrementMonth();
          }
        },
        child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentMonthIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: List.generate(
                      7,
                      (index) => Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              dayHeaders[index],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: daysInMonth +
                          firstDayOfWeek, // Number of days in the month
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7, // Number of columns (7 for a week)
                      ),
                      itemBuilder: (context, index) {
                        if (index < firstDayOfWeek) {
                          // Display empty cells for days before the first day of the month
                          return Container();
                        } else {
                          final dayOfMonth = index - firstDayOfWeek + 1;
                          final date =
                              DateTime(curDate.year, curDate.month, dayOfMonth);

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: isSameDate(date, curDate)
                                  ? Colors.blue
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   DateFormat('E')
                                //       .format(date), // Display the day of the week
                                //   style: const TextStyle(fontSize: 14),
                                // ),
                                // const SizedBox(height: 4),
                                Text(
                                  dayOfMonth
                                      .toString(), // Display the day of the month
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSameDate(date, curDate)
                                        ? Colors.white
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  bool isSameDate(DateTime date, DateTime curDate) {
    return DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(curDate);
  }
}
