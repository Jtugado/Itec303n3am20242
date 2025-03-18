import 'package:flutter/material.dart';

class RequestItemScreen extends StatefulWidget {
  static const routeName = '/request-item';

  const RequestItemScreen({Key? key}) : super(key: key);

  @override
  State<RequestItemScreen> createState() => _RequestItemScreenState();
}

class _RequestItemScreenState extends State<RequestItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _neededItem = '';
  String _location = '';
  String _details = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Handle submission logic
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request posted successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request an Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Item Needed"),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please specify the item needed.";
                  }
                  return null;
                },
                onSaved: (val) => _neededItem = val ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Location"),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a location.";
                  }
                  return null;
                },
                onSaved: (val) => _location = val ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Additional Details"),
                maxLines: 3,
                onSaved: (val) => _details = val ?? '',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Submit Request"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
