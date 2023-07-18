import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/qm_button.dart';

import '../widgets/loading_indicators/dot_fade.dart';
import '../widgets/loading_indicators/dot_grow.dart';
import '../widgets/loading_indicators/fading_circle.dart';
import '../widgets/loading_indicators/three_bounce.dart';
import '../widgets/loading_indicators/wave_indicator.dart';
import '../widgets/loading_indicators/dot_bounce.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Neonsign'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const DotBounce()),
              Container(
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.white70),
                  child: const DotGrow()),
              Container(
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.white70),
                  child: const DotFade()),
              const SizedBox(
                height: 24,
              ),
              Container(
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.white70),
                  child: const ThreeBounce()),
              Container(
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.white70),
                  child: const WaveIndicator()),
              Container(
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.white70),
                  child: const FadingCircle()),
              SizedBox(
                // width: 200,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: Icon(
                          Icons.home,
                          size: 24,
                        ),
                      ),
                      // SizedBox(width: 8),
                      Expanded(child: Text("Unsubscribe")),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              QMButton(
                width: 160,
                height: 40,
                text: "Unsubscribe",
                // leadingIcon: Icons.key,
                trailingIcon: Icons.lock,
                // borderRadius: 4,
                onPressed: () {},
                isDisabled: true,
              ),
              const SizedBox(
                height: 24,
              ),
              const ListTile(
                title: Text("Unsubscribe"),
                leading: Icon(Icons.quiz_outlined),
                trailing: Icon(Icons.qr_code),
                contentPadding: EdgeInsets.only(left: 16, right: 24),
              ),
              const SizedBox(
                height: 24,
              ),
              const ElevatedButton(
                onPressed: null, // Disable the button
                child: Text('Disabled Button'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
