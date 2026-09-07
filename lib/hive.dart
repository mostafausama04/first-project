import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final Box contactsBox = Hive.box('contactsBox');
  static final Box remindersBox = Hive.box('remindersBox');

  static void initDefaults() {
    if (contactsBox.isEmpty) {
      contactsBox.addAll([
        {
          'id': '1',
          'name': 'ليلى إبراهيم',
          'picture': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
          'phone': '+20 100 123 4567',
          'email': 'layla.ibrahim@email.com',
        },
        {
          'id': '2',
          'name': 'يوسف خالد',
          'picture': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400',
          'phone': '+20 101 234 5678',
          'email': 'youssef.khaled@email.com',
        },
      ]);
    }

    if (remindersBox.isEmpty) {
      remindersBox.addAll([
        {
          'title': 'Meeting with Team',
          'contact_name': 'ليلى إبراهيم',
          'date': 'Oct 26, 2026',
          'time': '10:00 AM'
        }
      ]);
    }
  }
  static List<Map<String, dynamic>> getContacts() {
    return contactsBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static void addContact(Map<String, dynamic> contact) {
    contactsBox.add(contact);
  }

  static void updateContact(int index, Map<String, dynamic> contact) {
    contactsBox.putAt(index, contact);
  }

  static void deleteContact(int index) {
    contactsBox.deleteAt(index);
  }
  static List<Map<String, dynamic>> getReminders() {
    return remindersBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static void addReminder(Map<String, dynamic> reminder) {
    remindersBox.add(reminder);
  }

  static void deleteReminder(int index) {
    remindersBox.deleteAt(index);
  }
}