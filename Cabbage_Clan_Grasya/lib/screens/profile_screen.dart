import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int totalDonations = 420;
    final List<String> badges = ['Giver', 'Helper', 'Volunteer'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'THE ZUCK',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Total Donations: $totalDonations',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                'Achievements',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: badges.map((badge) {
                  return Chip(
                    label: Text(badge),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
