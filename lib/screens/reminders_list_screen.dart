import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models.dart';
import 'package:first_project/app_theme.dart';

class RemindersListScreen extends StatelessWidget {
  const RemindersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders", style: TextStyle(color: kDarkTextColor)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return ListTile(
            leading: const Icon(Icons.alarm),
            title: Text(reminder['title']!),
            subtitle: Text(
                "${reminder['contact_name']} - ${reminder['date']} at ${reminder['time']}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/home/reminder/new'),
        backgroundColor: kDarkTextColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}