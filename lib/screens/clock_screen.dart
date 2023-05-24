import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_practice/widgets/clock_view.dart";
import "package:moment_dart/moment_dart.dart";

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  Timer? _timer;
  late Moment _now = Moment.now();
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = Moment.now();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    var formattedTime = _now.format('HH:mm:ss');
    var formattedDate = _now.format('dddd, DD MMMM');
    var timezoneString = _now.format('Z');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2d2f41),
        title: const Text('Clock Screen'),
      ),
      backgroundColor: const Color(0xff2d2f41),
      body: Container(
        alignment: Alignment.center,
        child: Container(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  formattedTime,
                  style: const TextStyle(color: Colors.white, fontSize: 64),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                const ClockView(),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Timezone",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'UTC$timezoneString',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
