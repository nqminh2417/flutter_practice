import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/lichcupdien_screen.dart';

import '../services/firebase_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          FutureBuilder(
            future: FirebaseService.getMenuItems(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> drawerList = snapshot.data!;
                return Column(
                  children: drawerList.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['title']),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LichCupDienScreen()),
                        );
                      },
                    );
                  }).toList(),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
