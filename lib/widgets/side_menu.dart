import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/menu_item.dart';
import '../providers/menu_provider.dart';
import '../providers/theme_provider.dart';
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

  @override
  void initState() {
    super.initState();
    menuProvider = Provider.of<MenuProvider>(context, listen: false);
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = menuProvider.menuItems;
    final parentItems = menuItems.where((item) => item.isParent).toList()..sort((a, b) => a.orderId.compareTo(b.orderId));
    final childItems = menuItems.where((item) => !item.isParent).toList()..sort((a, b) => a.orderId.compareTo(b.orderId));

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
          _buildParentItems(parentItems, childItems),
        ],
      ),
    );
  }

  Widget _buildParentItems(
      List<MenuItem> parentItems, List<MenuItem> childItems) {
    final expansionPanelItems = parentItems.map<ExpansionPanel>((item) {
      final children = _buildChildListTiles(item.docId, childItems);
      return ExpansionPanel(
        headerBuilder: (context, isExpanded) {
          return ListTile(
            title: Text(item.title),
          );
        },
        body: Column(children: children),
        isExpanded: item.isExpanded,
      );
    }).toList();

    return ExpansionPanelList(
      elevation: 0,
      dividerColor: Colors.transparent,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          parentItems[index].isExpanded = !isExpanded;
        });
      },
      children: expansionPanelItems,
    );
  }

  List<Widget> _buildChildListTiles(
      String parentId, List<MenuItem> childItems) {
    final children = <Widget>[];

    for (final childItem in childItems) {
      if (!childItem.isParent && childItem.parentId == parentId) {
        children.add(
          ListTile(
            leading: Icon(childItem.icon),
            title: Text(childItem.title),
            onTap: () {
              // Handle the onTap action
              Navigator.popAndPushNamed(context, childItem.route);
            },
          ),
        );
      }
    }

    return children;
  }
}
