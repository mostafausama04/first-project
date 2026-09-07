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
      body: contacts.isEmpty
          ? const Center(child: Text("No contacts found. Add one!"))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                final hiveKey = contact['hiveKey'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact['picture'] ?? ''),
                  ),
                  title: Text(
                    contact['name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(contact['phone'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                        onPressed: () async {
                          final result = await context.push(
                            '/home/new_contact',
                            extra: {'hiveKey': hiveKey, 'contact': contact},
                          );
                          if (result == true) setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Contact'),
                              content: Text('Are you sure you want to delete ${contact['name']}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    HiveService.deleteContact(hiveKey);
                                    setState(() {});
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Contact deleted')),
                                    );
                                  },
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    context.go('/home/contact/$hiveKey');
                  },
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