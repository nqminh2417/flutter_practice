import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import '../providers/menu_provider.dart';
import '../screens/profile_screen.dart';
import '../screens/switch_account_screen.dart';

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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SwitchAccountScreen()),
              );
            },
            splashColor: Colors.amberAccent,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://vcdn1-giaitri.vnecdn.net/2022/09/23/-2181-1663929656.jpg?w=680&h=0&q=100&dpr=1&fit=crop&s=apYgDs9tYQiwn7pcDOGbNg'),
                  ),
                  const SizedBox(width: 16.0),
                  const Text(
                    'Minh Nguyen',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.expand_more),
                  const Spacer(),
                  // SizedBox(width: 8.0),
                  // Icon(Icons.settings),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      // Navigate to the ProfileScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final menuItem = menuItems[index];
              final isSelected = menuItem.route == selectedRoute;
              return ListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                leading: SizedBox(
                  width: 42,
                  height: 42,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xffe7e7e7),
                    ),
                    child: Icon(menuItem.icon),
                  ),
                ),
                title: Text(menuItem.title),
                onTap: () {
                  menuProvider.setSelectedRoute(menuItem.route);
                  Navigator.pushNamed(context, menuItem.route);
                },
                selected: isSelected,
                tileColor: isSelected ? Colors.grey : null,
                selectedTileColor: const Color(0xfff0f0f0),
                selectedColor: const Color(0xffb74093),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              );
            },
          ),
        ],
      ),
    );
  }
}
