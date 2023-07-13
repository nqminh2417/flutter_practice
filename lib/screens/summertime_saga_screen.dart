import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/progress_bar.dart';

import '../models/progress_summertime_saga.dart';
import '../services/api_service.dart';

class SummertimeSagaScreen extends StatefulWidget {
  const SummertimeSagaScreen({super.key});

  @override
  State<SummertimeSagaScreen> createState() => _SummertimeSagaScreenState();
}

class _SummertimeSagaScreenState extends State<SummertimeSagaScreen> {
  ProgressSummertimeSaga? progressData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
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
        title: const Text('Summertime Saga'),
      ),
      body: Container(
        width: double.infinity, //MediaQuery.of(context).size.width
        height: double.infinity,
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
        child: progressData != null
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                        "https://summertimesaga.com/assets/img/logo.png"),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 0, right: 0, bottom: 3.0, left: 0),
                      padding: const EdgeInsets.only(
                          top: 0.0, right: 1.0, bottom: 0.0, left: 1.0),
                      child: Row(
                        children: [
                          Text(
                            '${progressData!.version} - ${progressData!.totals.percent.completed}%',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            '${progressData!.totals.total} Tasks',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Add some spacing between rows
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF505673)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: ProgressBar(
                                height: 21,
                                title: 'Art',
                                complete: progressData!.depts.art.closed,
                                working: progressData!.depts.art.working,
                                total: progressData!.depts.art.total,
                                percent: progressData!.depts.art.percent,
                                completeColor: const Color(0xff7e8534),
                                workingColor: const Color(0xff7e8534),
                                totalColor: const Color(0xff7e8534),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: ProgressBar(
                                height: 21,
                                title: 'Posing',
                                complete: progressData!.depts.posing.closed,
                                working: progressData!.depts.posing.working,
                                total: progressData!.depts.posing.total,
                                percent: progressData!.depts.posing.percent,
                                completeColor: const Color(0xfff1562e),
                                workingColor: const Color(0xffbd492f),
                                totalColor: const Color(0xff893c30),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: ProgressBar(
                                height: 21,
                                title: 'Dialogue',
                                complete: progressData!.depts.dialogue.closed,
                                working: progressData!.depts.dialogue.working,
                                total: progressData!.depts.dialogue.total,
                                percent: progressData!.depts.dialogue.percent,
                                completeColor: const Color(0xfff1e12e),
                                workingColor: const Color(0xff7e8534),
                                totalColor: const Color(0xff7e8534),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: ProgressBar(
                                height: 21,
                                title: 'Code',
                                complete: progressData!.depts.code.closed,
                                working: progressData!.depts.code.working,
                                total: progressData!.depts.code.total,
                                percent: progressData!.depts.code.percent,
                                completeColor: const Color(0xff5ca1bb),
                                workingColor: const Color(0xff4c8299),
                                totalColor: const Color(0xff3e6277),
                              ),
                            ),
                            ProgressBar(
                              height: 21,
                              title: 'Audio',
                              complete: progressData!.depts.audio.closed,
                              working: progressData!.depts.audio.working,
                              total: progressData!.depts.audio.total,
                              percent: progressData!.depts.audio.percent,
                              completeColor: const Color(0xff48506d),
                              workingColor: const Color(0xff48506d),
                              totalColor: const Color(0xff48506d),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 0, right: 0, bottom: 30.0, left: 0),
                      padding: const EdgeInsets.only(
                          top: 0.0, right: 1.0, bottom: 0.0, left: 1.0),
                      child: Row(
                        children: [
                          Text(
                            '${progressData!.issues.total} Changes in last 24hrs',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
