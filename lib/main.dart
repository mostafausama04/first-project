import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'package:first_project/app_theme.dart';

void main() {
  runApp(const ContactReminderApp());
}

class ContactReminderApp extends StatelessWidget {
  const ContactReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Basic Contact & Reminder App',
      theme: appTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}