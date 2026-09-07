import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final Box contactsBox = Hive.box('contactsBox');
  static final Box remindersBox = Hive.box('remindersBox');

  static void initDefaults() {
    if (contactsBox.isEmpty) {
      contactsBox.add({
        'id': '1',
        'name': 'ليلى إبراهيم',
        'picture': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
        'phone': '+20 100 123 4567',
        'email': 'layla.ibrahim@email.com',
      });
      contactsBox.add({
        'id': '2',
        'name': 'يوسف خالد',
        'picture': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400',
        'phone': '+20 101 234 5678',
        'email': 'youssef.khaled@email.com',
      });
    }

    if (remindersBox.isEmpty) {
      remindersBox.add({
        'title': 'Meeting with Team',
        'contact_name': 'ليلى إبراهيم',
        'date': 'Oct 26, 2026',
        'time': '10:00 AM'
      });
    }
  }
  static List<Map<String, dynamic>> getContacts() {
    return contactsBox.keys.map((key) {
      final item = Map<String, dynamic>.from(contactsBox.get(key));
      item['hiveKey'] = key; 
      return item;
    }).toList();
  }
  static Map<String, dynamic>? getContact(dynamic hiveKey) {
    final data = contactsBox.get(hiveKey);
    if (data != null) {
      final item = Map<String, dynamic>.from(data);
      item['hiveKey'] = hiveKey;
      return item;
    }
    return null;
  }

  static void addContact(Map<String, dynamic> contact) {
    contactsBox.add(contact);
  }

  static void updateContact(dynamic hiveKey, Map<String, dynamic> contact) {
    contactsBox.put(hiveKey, contact);
  }

  static void deleteContact(dynamic hiveKey) {
    contactsBox.delete(hiveKey);
  }

  static List<Map<String, dynamic>> getReminders() {
    return remindersBox.keys.map((key) {
      final item = Map<String, dynamic>.from(remindersBox.get(key));
      item['hiveKey'] = key;
      return item;
    }).toList();
  }

  static void addReminder(Map<String, dynamic> reminder) {
    remindersBox.add(reminder);
  }

  static void deleteReminder(dynamic hiveKey) {
    remindersBox.delete(hiveKey);
  }
}