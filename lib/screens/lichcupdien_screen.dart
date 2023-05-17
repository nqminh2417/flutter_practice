import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_practice/services/api_service.dart';
import 'package:flutter_practice/widgets/side_menu.dart';

class LichCupDienScreen extends StatefulWidget {
  const LichCupDienScreen({super.key});

  @override
  State<LichCupDienScreen> createState() => _LichCupDienScreenState();
}

class _LichCupDienScreenState extends State<LichCupDienScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lịch cúp điện'),
        ),
        drawer: const SideMenu(),
        body: Center(
          child: FutureBuilder<String>(
            future: ApiService.getLichCupDien(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Html(data: snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
