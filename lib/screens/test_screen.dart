import 'package:flutter/material.dart';

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
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 242.874,
            child: Image.network(
              'https://yt3.googleusercontent.com/BJrlZFKtmulrHcYIdhOWQ9B6N586GP2G8llwEhx2A72puyjoqUl4Z1uDN9MHuxtjY1VQNptv',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
