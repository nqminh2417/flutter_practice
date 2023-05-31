import 'package:flutter/material.dart';
import 'package:flutter_practice/models/progress_summertime_saga.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test Screen'),
        ),
        body: null,
        );
  }
}
