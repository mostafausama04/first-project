import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes/app_router.dart';
import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  await Hive.openBox('contactsBox');
  await Hive.openBox('remindersBox');

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