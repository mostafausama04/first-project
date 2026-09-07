import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:first_project/app_theme.dart';

class ContactDetailScreen extends StatelessWidget {
  final Map<String, String> contact;
  const ContactDetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kDarkTextColor),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(contact['picture']!),
                      ),
                      const SizedBox(height: 16),
                      Text(contact['name']!,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.call, size: 28, color: kPrimaryColor),
                          Icon(Icons.message, size: 28, color: kPrimaryColor),
                          Icon(Icons.email, size: 28, color: kPrimaryColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact Details",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text("Phone Number"),
                      subtitle: Text(contact['phone']!),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text("Personal Email"),
                      subtitle: Text(contact['email']!),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}