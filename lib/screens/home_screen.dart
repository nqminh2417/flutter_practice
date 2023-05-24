import 'package:flutter/material.dart';
import '../widgets/side_menu.dart';
import 'clock_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          // backgroundColor: Colors.black,
          title: const Text('Home Screen'),
        ),
        // body: const Center(
        //   child: Text('Welcome to the home screen!',
        //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
        // ),
        drawer: const SideMenu(),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ClockScreen()),
                  );
                },
                child: const Text("Profile Screen nè")),
          ],
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
