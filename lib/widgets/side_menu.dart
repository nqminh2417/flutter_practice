import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/menu_item.dart';
import '../providers/menu_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/login_screen.dart';
import '../screens/switch_account_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late MenuProvider menuProvider;
  late ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();
    menuProvider = Provider.of<MenuProvider>(context, listen: false);
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    final menuItems1 =
        menuProvider.menuItems.sublist(0, menuProvider.menuItems.length - 2);
    final menuItems2 =
        menuProvider.menuItems.sublist(menuProvider.menuItems.length - 2);

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
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.expand_more),
                  const Spacer(),
                  IconButton(
                    icon: Icon(themeProvider.isDarkModeOn
                            ? Icons.light_mode // dark
                            : Icons.dark_mode // light
                        ),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            itemCount: menuItems1.length,
            itemBuilder: (context, index) {
              final menuItem = menuItems1[index];
              return buildListTile(context, menuItem);
            },
          ),
          const Divider(
            color: Colors.green,
            height: 20,
            indent: 35,
            endIndent: 35,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            itemCount: menuItems2.length,
            itemBuilder: (context, index) {
              final menuItem = menuItems2[index];
              return buildListTile(context, menuItem);
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, MenuItem menuItem) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      leading: SizedBox(
        width: 42,
        height: 42,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: themeProvider.isDarkModeOn
                ? const Color(0xff4f4f4f) // dark
                : const Color(0xfff5f5f5), // light
          ),
          child: Icon(
            menuItem.icon,
            color: themeProvider.isDarkModeOn
                ? Colors.white // dark
                : Colors.black, // light
          ),
        ),
      ),
      title: Text(menuItem.title),
      onTap: () {
        if (menuItem.route == "logout") {
          // Handle logout here
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          Navigator.popAndPushNamed(context, menuItem.route);
        }
      },
    );
  }
}
