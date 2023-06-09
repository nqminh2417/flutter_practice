import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<String> dayHeaders = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  late DateTime cal = DateTime.now();
  final DateTime curDate = DateTime.now();
  late DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(cal.year, cal.month + 1, 0).day;
    final firstDayOfWeek = DateTime(cal.year, cal.month, 1).weekday;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Screen'),
        actions: [
          IconButton(
            onPressed: () {
              // Handle first icon button click
            },
            icon: const Icon(Icons.search),
            tooltip: "Search",
          ),
          IconButton(
            onPressed: () {
              // Handle Today icon button click
              setState(() {
                cal = curDate;
                selectedDate = curDate;
              });
            },
            icon: const Icon(Icons.today),
            tooltip: "Today",
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                elevation: 4,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.075,
                          ),
                          IconButton(
                            color: Colors.amber,
                            onPressed: () {
                              setState(() {
                                cal = DateTime(
                                  cal.year,
                                  cal.month - 1,
                                  cal.day,
                                );
                              });
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                _showDatePickerDialog();
                              },
                              child: Text(
                                DateFormat('MMMM yyyy').format(cal),
                                style: const TextStyle(
                                    color: Colors.amber, fontSize: 18),
                              ),
                            ),
                          ),
                          IconButton(
                            color: Colors.amber,
                            onPressed: () {
                              setState(() {
                                cal = DateTime(
                                  cal.year,
                                  cal.month + 1,
                                  cal.day,
                                );
                              });
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.075,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(
                        7,
                        (index) => Expanded(
                          child: SizedBox(
                            height: 35,
                            // color: Colors.white,
                            child: Center(
                              child: Text(
                                dayHeaders[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: daysInMonth + firstDayOfWeek,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                      ),
                      itemBuilder: (context, index) {
                        if (index < firstDayOfWeek) {
                          return Container();
                        } else {
                          final dayOfMonth = index - firstDayOfWeek + 1;
                          final date = DateTime(
                            cal.year,
                            cal.month,
                            dayOfMonth,
                          );

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSameDate(date, curDate)
                                    ? Colors.blue
                                    : (isSameDate(date, selectedDate)
                                        ? Colors.red
                                        : null),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dayOfMonth.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSameDate(date, curDate) ||
                                              isSameDate(date, selectedDate)
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    DateFormat('MMMM d, yyyy').format(selectedDate),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1964),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Customize the appearance of the date picker
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        cal = pickedDate;
      });
    }
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return DateFormat('yyyy-MM-dd').format(date1) ==
        DateFormat('yyyy-MM-dd').format(date2);
  }
}
