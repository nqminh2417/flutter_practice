import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import '../providers/menu_provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final menuItems = menuProvider.menuItems;
    final selectedRoute = menuProvider.selectedRoute;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://vcdn1-giaitri.vnecdn.net/2022/09/23/-2181-1663929656.jpg?w=680&h=0&q=100&dpr=1&fit=crop&s=apYgDs9tYQiwn7pcDOGbNg'),
                ),
                SizedBox(height: 8),
                Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final menuItem = menuItems[index];
              final isSelected = menuItem.route == selectedRoute;
              return ListTile(
                leading: Icon(menuItem.icon),
                title: Text(menuItem.title),
                onTap: () {
                  menuProvider.setSelectedRoute(menuItem.route);
                  Navigator.pushNamed(context, menuItem.route);
                },
                selected: isSelected,
                tileColor: isSelected ? Colors.grey : null,
              );
            },
          ),
        ],
      ),
    );

    // return Drawer(
    //   child: ListView.builder(
    //     itemCount: menuItems.length,
    //     itemBuilder: (context, index) {
    //       final menuItem = menuItems[index];

    //       return ListTile(
    //         leading: Icon(menuItem.icon),
    //         title: Text(menuItem.title),
    //         onTap: () {
    //           Navigator.of(context).pushNamed(menuItem.route);
    //         },
    //       );
    //     },
    //   ),
    // );

    // return Drawer(
    //   child: ListView(
    //     children: [
    //       const DrawerHeader(
    //         decoration: BoxDecoration(
    //           color: Colors.blue,
    //         ),
    //         child: Text('Drawer Header'),
    //       ),

    //       ListTile(
    //         leading: const Icon(Icons.logout),
    //         title: const Text('Logout'),
    //         onTap: () {
    //           FirebaseAuth.instance.signOut();
    //           Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(builder: (context) => const LoginScreen()),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
