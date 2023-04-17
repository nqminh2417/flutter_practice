import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';


// Future<List<DocumentSnapshot>> getMenuItems() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('drawer').get();
//     return querySnapshot.docs;
//   }

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
            builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> drawerList = snapshot.data!;
                return Column(
                  children: drawerList.map((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['title']),
                      onTap: () {},
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

  // @override
  // Widget build(BuildContext context) {
  //   return Drawer(
  //     child: ListView(
  //       children: [
  //         const UserAccountsDrawerHeader(
  //           accountName: Text('John Doe'),
  //           accountEmail: Text('johndoe@example.com'),
  //           currentAccountPicture: CircleAvatar(
  //             child: Text('JD'),
  //           ),
  //         ),
  //         ListTile(
  //           leading: const Icon(Icons.home),
  //           title: const Text('Home'),
  //           onTap: () {
  //             Navigator.pop(context);
  //             // Navigate to the home screen
  //           },
  //         ),
  //         ListTile(
  //           leading: const Icon(Icons.settings),
  //           title: const Text('Settings'),
  //           onTap: () {
  //             Navigator.pop(context);
  //             // Navigate to the settings screen
  //           },
  //         ),
  //         ListTile(
  //           leading: const Icon(Icons.exit_to_app),
  //           title: const Text('Logout'),
  //           onTap: () {
  //             FirebaseAuth.instance.signOut();
  //             Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(builder: (context) => const LoginScreen()),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  }
}
