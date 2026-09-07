import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../hive.dart';
import '../app_theme.dart';
import '../utils/validators.dart';

class NewContactScreen extends StatefulWidget {
  final Map<String, dynamic>? editData;
  final int? editIndex;

  const NewContactScreen({super.key, this.editData, this.editIndex});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.editData?['name'] ?? '');
    _phoneController = TextEditingController(text: widget.editData?['phone'] ?? '');
    _emailController = TextEditingController(text: widget.editData?['email'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editIndex != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Contact" : "New Contact", style: const TextStyle(color: kDarkTextColor)),
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
                backgroundImage: widget.editData != null ? NetworkImage(widget.editData!['picture']) : null,
                child: widget.editData == null ? const Icon(Icons.person_add, size: 40, color: Colors.grey) : null,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name *', border: UnderlineInputBorder()),
                validator: (value) => AppValidators.validateRequired(value, 'Full Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number *', border: UnderlineInputBorder()),
                validator: (value) => AppValidators.validatePhone(value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email Address *', border: UnderlineInputBorder()),
                validator: (value) => AppValidators.validateEmail(value),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final contactData = {
                      'id': widget.editData?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                      'name': _nameController.text.trim(),
                      'picture': widget.editData?['picture'] ?? 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?w=400',
                      'phone': _phoneController.text.trim(),
                      'email': _emailController.text.trim(),
                    };

                    if (isEditing) {
                      HiveService.updateContact(widget.editIndex!, contactData);
                    } else {
                      HiveService.addContact(contactData);
                    }

                    context.pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkTextColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                ),
                child: Text(isEditing ? "UPDATE CONTACT" : "SAVE CONTACT"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}