import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../hive.dart';
import '../app_theme.dart';
import '../utils/validators.dart';

class NewContactScreen extends StatefulWidget {
  final Map<String, dynamic>? editData;
  final dynamic hiveKey;

  const NewContactScreen({super.key, this.editData, this.hiveKey});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.editData?['name'] ?? '');
    _phoneController = TextEditingController(text: widget.editData?['phone'] ?? '');
    _emailController = TextEditingController(text: widget.editData?['email'] ?? '');
    _categoryController = TextEditingController(text: widget.editData?['category'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.hiveKey != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? "Edit Contact" : "New Contact",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kDarkTextColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Name :', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                validator: AppValidators.validateName,
              ),
              const SizedBox(height: 16),
              const Text('Phone Number :', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                validator: AppValidators.validatePhone,
              ),
              const SizedBox(height: 16),
              const Text('Email :', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                validator: AppValidators.validateEmail,
              ),
              const SizedBox(height: 16),
              const Text('Category :', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  hintText: 'Category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                validator: AppValidators.validateCategory,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final contactData = {
                      'id': widget.editData?['id'] ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      'name': _nameController.text.trim(),
                      'phone': _phoneController.text.trim(),
                      'email': _emailController.text.trim(),
                      'category': _categoryController.text.trim(),
                      'picture': widget.editData?['picture'] ??
                          'https://images.unsplash.com/photo-1511367461989-f85a21fda167?w=400',
                    };

                    if (isEditing) {
                      HiveService.updateContact(widget.hiveKey, contactData);
                    } else {
                      HiveService.addContact(contactData);
                    }

                    context.pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkTextColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(isEditing ? "UPDATE" : "Save", style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}