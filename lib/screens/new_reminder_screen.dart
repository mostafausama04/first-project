import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models.dart';
import 'package:first_project/app_theme.dart';

class NewReminderScreen extends StatefulWidget {
  const NewReminderScreen({super.key});

  @override
  State<NewReminderScreen> createState() => _NewReminderScreenState();
}

class _NewReminderScreenState extends State<NewReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  String? _selectedContact;

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Reminder", style: TextStyle(color: kDarkTextColor)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: kDarkTextColor),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Create a reminder", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Reminder Title',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedContact, 
                decoration: const InputDecoration(labelText: 'Related Contact (Optional)'),
                items: contacts.map<DropdownMenuItem<String>>((Map<String, String> contact) {
                  return DropdownMenuItem<String>(
                    value: contact['name'], 
                    child: Text(contact['name']!),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedContact = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                    labelText: 'Date', suffixIcon: Icon(Icons.calendar_today)),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                readOnly: true,
                onTap: () => _selectTime(context),
                decoration: const InputDecoration(
                    labelText: 'Time', suffixIcon: Icon(Icons.access_time)),
              ),
              const SizedBox(height: 48),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      reminders.insert(0, {
                        'title': _titleController.text,
                        'contact_name': _selectedContact ?? 'Self',
                        'date': _dateController.text,
                        'time': _timeController.text
                      });
                    });
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDarkTextColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                  ),
                  child: const Text("CREATE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}