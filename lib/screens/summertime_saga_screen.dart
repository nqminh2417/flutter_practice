import 'dart:convert';
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
  var json = [];
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
        json =
            jsonDecode(jsonEncode(progressData?.depts.toMap())).keys.toList();
      });
    } catch (error) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    // var json = jsonEncode(progressData?.depts.toMap());
    //   var json = '{"art":{"new":0,"closed":164,"working":0,"total":164,"percent":{"completed":"100.00","working": "0.00"}},"posing":{"new":7,"closed":74,"working":12,"total":93,"percent":{"completed":"79.57","working ":"12.90"}},"dialogue":{"new":0,"closed":64,"working":0,"total":64,"percent":{"completed":"100.00", "working":"0.00"}},"code":{"new":80,"closed":149,"working":3,"total":232,"percent":{"completed":"64.22 ","working":"1.29"}},"audio":{"new":0,"closed":0,"working":0,"total":0,"percent":{"completed": "0.00","working":"0.00"}}}';

    // var jsonData = jsonDecode(json);
    // var key = jsonData.keys.toList().firstWhere((key) => key == 'art', orElse: () => '');

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
                    Row(
                      children: [
                        Text(
                          progressData!.version,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
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
                          children: [
                            ProgressBar(
                                height: 21,
                                title: json.firstWhere((key) => key == 'art',
                                    orElse: () => ''),
                                complete: progressData!.depts.art.closed,
                                working: progressData!.depts.art.working,
                                total: progressData!.depts.art.total),
                            ProgressBar(
                                height: 21,
                                title: json.firstWhere((key) => key == 'posing',
                                    orElse: () => ''),
                                complete: progressData!.depts.posing.closed,
                                working: progressData!.depts.posing.working,
                                total: progressData!.depts.posing.total),
                            ProgressBar(
                                height: 21,
                                title: json.firstWhere(
                                    (key) => key == 'dialogue',
                                    orElse: () => ''),
                                complete: progressData!.depts.dialogue.closed,
                                working: progressData!.depts.dialogue.working,
                                total: progressData!.depts.dialogue.total),
                            ProgressBar(
                                height: 21,
                                title: json.firstWhere((key) => key == 'code',
                                    orElse: () => ''),
                                complete: progressData!.depts.code.closed,
                                working: progressData!.depts.code.working,
                                total: progressData!.depts.code.total),
                            ProgressBar(
                                height: 21,
                                title: json.firstWhere((key) => key == 'audio',
                                    orElse: () => ''),
                                complete: progressData!.depts.audio.closed,
                                working: progressData!.depts.audio.working,
                                total: progressData!.depts.audio.total),
                          ],
                        ),
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
