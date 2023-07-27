// ignore_for_file: use_build_context_synchronously

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "../services/sqlite_service.dart";
import "../widgets/side_menu.dart";
import "login_screen.dart";

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

  Future<bool> isDatabaseCreated() async {
    final db = await SQLiteService().database;
    return db.isOpen;
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showDatabaseStatus(bool isCreated, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Database Status'),
          content:
              Text('Database is ${isCreated ? "created" : "not created"}.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      drawer: const SideMenu(),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.data_object),
            title: const Text("Check if the database has been initialized"),
            onTap: () async {
              final isCreated = await isDatabaseCreated();
              _showDatabaseStatus(isCreated, context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.data_exploration),
            title: const Text("Reset Database"),
            onTap: () async {
              final isCreated = await isDatabaseCreated();
              if (isCreated) {
                await SQLiteService().resetDatabase();
                _showSnackbar(context, 'Database reset successful');
              } else {
                _showSnackbar(context, 'Database does not exist');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log out"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Perform logout action
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          // Handle logout here
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
