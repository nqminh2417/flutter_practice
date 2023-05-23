import "package:flutter/material.dart";

import "../widgets/side_menu.dart";

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      drawer: const SideMenu(),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Dark Mode"),
            subtitle: Text("dark or light"),
          ),
          ListTile(
            leading: Icon(Icons.nightlife),
            title: Text("test"),
          )
        ],
      ),
    );
  }
}
