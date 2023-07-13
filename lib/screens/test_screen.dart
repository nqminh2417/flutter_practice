import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/qm_button.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Positioned(
                      left: 0,
                      child: Icon(
                        Icons.home,
                        size: 24,
                      ),
                    ),
                    // SizedBox(width: 8),
                    Expanded(child: Center(child: Text("Block"))),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
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
            ),
            const SizedBox(
              height: 24,
            ),
            const ListTile(
              title: Text("Unsubscribe"),
              leading: Icon(Icons.quiz_outlined),
              trailing: Icon(Icons.qr_code),
              contentPadding: EdgeInsets.only(left: 16, right: 24),
            )
          ],
        ),
      ),
    );
  }
}
