import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/test_screen.dart';
import 'package:flutter_practice/utils/color_utils.dart';
import '../widgets/side_menu.dart';
import 'bluetooth_screen.dart';
import 'calendar_screen.dart';
import 'clock_screen.dart';
import 'summertime_saga_screen.dart';
import 'youtube/youtube_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> screens = [
    {
      'route': const BluetoothScreen(),
      'title': 'bluetooth',
    },
    {
      'route': const YoutubeScreen(),
      'title': 'Youtube',
    },
    {
      'route': const ClockScreen(),
      'title': 'Đồng hồ',
    },
    {
      'route': const SummertimeSagaScreen(),
      'title': 'Summertime Saga',
    },
    {
      'route': const CalendarScreen(),
      'title': 'Calendar Screen',
    },
    {
      'route': const TestScreen(),
      'title': 'Test Screen',
    },
    // Add more screens here...
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home Screen',
          ),
        ),
        drawer: const SideMenu(),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(20),
          primary: false,
          children: List.generate(screens.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => screens[index]['route'],
                  ),
                );
              },
              child: GridTile(
                child: Card(
                  color: ColorUtils.getRandomColor(),
                  child: Center(
                    child: Text(
                      screens[index]['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Pop Screen Disabled. You cannot go to previous screen.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
    );
  }
}
