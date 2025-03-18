import 'package:flutter/material.dart';

class DonateItemScreen extends StatefulWidget {
  static const routeName = '/donate-item';

  const DonateItemScreen({Key? key}) : super(key: key);

  @override
  State<DonateItemScreen> createState() => _DonateItemScreenState();
}

class _DonateItemScreenState extends State<DonateItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _itemName = '';
  String _condition = '';
  String _location = '';
  String _description = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Handle submission logic, e.g., send to backend
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Donation posted successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate an Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Item Name"),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter an item name.";
                  }
                  return null;
                },
                onSaved: (val) => _itemName = val ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Condition (e.g., Good, Like New)"),
                onSaved: (val) => _condition = val ?? '',
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
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                onSaved: (val) => _description = val ?? '',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Submit Donation"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
