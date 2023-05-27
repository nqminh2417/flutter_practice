import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/models/progress_summertime_saga.dart';

import '../services/api_service.dart';
import '../widgets/progress_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ProgressSummertimeSaga? progressData;

  @override
  void initState() {
    super.initState();
    fetchProgressSummertimeSagaData();
  }

  Future<void> fetchProgressSummertimeSagaData() async {
    try {
      final data = await ApiService.getProgressSummertimeSagaData();
      setState(() {
        progressData = data;
      });
    } catch (error) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: progressData != null
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF090A0F),
                    Color(0xFF3F4562),
                  ],
                  stops: [0.0, 1.0],
                  transform: GradientRotation(135 * pi / 180),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        // Widgets for the first row in the main Column
                        // Add your desired widgets here
                        Text(
                          progressData!.version,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add some spacing between rows
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF505673)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:  [
                            ProgressBar(
                                height: 21,
                                title: '',
                                complete: progressData!.depts.posing.closed,
                                working: progressData!.depts.posing.working,
                                total: progressData!.depts.posing.total),
                            const ProgressBar(
                                height: 21,
                                title: "title",
                                complete: 149,
                                working: 3,
                                total: 232),
                            const ProgressBar(
                                height: 21,
                                title: "title",
                                complete: 149,
                                working: 3,
                                total: 232),
                            const ProgressBar(
                                height: 21,
                                title: "title",
                                complete: 149,
                                working: 3,
                                total: 232),
                            const ProgressBar(
                                height: 21,
                                title: "title",
                                complete: 149,
                                working: 3,
                                total: 232),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
