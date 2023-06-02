import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/menu_item.dart';
import '../providers/menu_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/login_screen.dart';
import '../screens/switch_account_screen.dart';
import '../utils/constants.dart';
import 'radio_button_right.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late MenuProvider menuProvider;
  late ThemeProvider themeProvider;
  Color drawerColor = Colors.white;

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
                  GestureDetector(
                    child: Icon(
                      themeProvider.selectedTheme == ThemeOption.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    onTap: () {
                      ThemeOption newTheme =
                          themeProvider.selectedTheme == ThemeOption.light
                              ? ThemeOption.dark
                              : ThemeOption.light;
                      themeProvider.setTheme(newTheme);
                    },
                    onLongPress: () {
                      Navigator.of(context).pop(); // Close the drawer
                      showModalBottomSheet(
                        // backgroundColor: Colors.amber,
                          enableDrag: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 16.0),
                                      child: Text(
                                        "Choose theme",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                                const Divider(
                                  color: Colors.blue,
                                  height: 16,
                                  thickness: 1,
                                ),
                                RadioButtonRight(
                                  themeOption: ThemeOption.light,
                                  selectedThemeOption:
                                      themeProvider.selectedTheme,
                                  onChanged: (value) {
                                    themeProvider.setTheme(value!);
                                  },
                                ),
                                RadioButtonRight(
                                  themeOption: ThemeOption.dark,
                                  selectedThemeOption:
                                      themeProvider.selectedTheme,
                                  onChanged: (value) {
                                    themeProvider.setTheme(value!);
                                  },
                                ),
                                RadioButtonRight(
                                  themeOption: ThemeOption.dimTwitter,
                                  selectedThemeOption:
                                      themeProvider.selectedTheme,
                                  onChanged: (value) {
                                    themeProvider.setTheme(value!);
                                  },
                                ),
                                RadioButtonRight(
                                  themeOption: ThemeOption.nightTelegram,
                                  selectedThemeOption:
                                      themeProvider.selectedTheme,
                                  onChanged: (value) {
                                    themeProvider.setTheme(value!);
                                  },
                                ),
                              ],
                            );
                          });
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
      leading: Icon(
        menuItem.icon,
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
