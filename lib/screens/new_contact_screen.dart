import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models.dart';
import '../app_theme.dart';
import '../utils/validators.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact", style: TextStyle(color: kDarkTextColor)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: kDarkTextColor),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person_add, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) => AppValidators.validateRequired(value, 'Full Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) => AppValidators.validatePhone(value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) => AppValidators.validateEmail(value),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    contacts.add({
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'name': _nameController.text.trim(),
                      'picture': 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?w=400',
                      'phone': _phoneController.text.trim(),
                      'email': _emailController.text.trim(),
                    });
                    
                    context.pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkTextColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                ),
                child: const Text("SAVE CONTACT"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}