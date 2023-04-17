import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LichCupDienScreen extends StatefulWidget {
  const LichCupDienScreen({super.key});

  @override
  State<LichCupDienScreen> createState() => _LichCupDienScreenState();
}

class _LichCupDienScreenState extends State<LichCupDienScreen> {

  final CollectionReference _menu = FirebaseFirestore.instance.collection('side_menu_items');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch cúp điện'),
      ),
      body: Center(
        
      ),
    );
  }
}
