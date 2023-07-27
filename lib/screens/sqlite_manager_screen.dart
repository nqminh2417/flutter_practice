// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/videos_management_screen.dart';

import '../services/sqlite_service.dart';

class SQLiteManagerScreen extends StatefulWidget {
  const SQLiteManagerScreen({super.key});

  @override
  State<SQLiteManagerScreen> createState() => _SQLiteManagerScreenState();
}

class _SQLiteManagerScreenState extends State<SQLiteManagerScreen> {
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
        title: const Text(
          'SQLite Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Neonsign'),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.dataset),
              title: const Text("Add new video"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VidMgmtScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.dataset),
              title: const Text("Check if the database has been initialized"),
              onTap: () async {
                final isCreated = await isDatabaseCreated();
                _showDatabaseStatus(isCreated, context);
              },
            ),
          ),
          Card(
            child: ListTile(
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
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.data_exploration),
              title: const Text("Delete Database"),
              onTap: () async {
                final isCreated = await isDatabaseCreated();
                if (isCreated) {
                  await SQLiteService().delDatabase();
                  _showSnackbar(context, 'Database delete successful');
                } else {
                  _showSnackbar(context, 'Database does not exist');
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
