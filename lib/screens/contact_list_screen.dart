import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../hive.dart';
import '../app_theme.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  void initState() {
    super.initState();
    HiveService.initDefaults();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = HiveService.getContacts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts", style: TextStyle(color: kDarkTextColor)),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Dismissible(
            key: Key(contact['id'] ?? index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              HiveService.deleteContact(index);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact deleted')),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(contact['picture'] ?? ''),
              ),
              title: Text(contact['name'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(contact['phone'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () async {
                  // Navigate to Edit screen passing index
                  final result = await context.push('/home/new_contact', extra: {'index': index, 'contact': contact});
                  if (result == true) setState(() {});
                },
              ),
              onTap: () {
                context.go('/home/contact/$index');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/home/new_contact');
          if (result == true) {
            setState(() {});
          }
        },
        backgroundColor: kDarkTextColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}