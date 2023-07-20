import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/qm_button.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              QMButton(
                text: 'Scan',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
