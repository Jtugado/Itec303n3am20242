import 'package:flutter/material.dart';
import 'drive_detail_screen.dart';

enum UserMode { donor, requestor }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserMode _userMode = UserMode.donor;
  String _searchQuery = '';

  // Example: People needing items (if user is donor)
  final List<Map<String, String>> _peopleNeedingItems = [
    {'name': 'Alice Guo', 'distance': '1.2 km', 'need': 'Passport'},
    {'name': 'Jhunnard', 'distance': '2.5 km', 'need': 'Reviewer'},
    {'name': 'Ali', 'distance': '3.0 km', 'need': 'Englishera'},
  ];

  // Example: Items near user (if user is requestor)
  final List<Map<String, String>> _itemsNearUser = [
    {'item': 'Rtx 5090 Laptop', 'distance': '1.8 km'},
    {'item': 'Massage Chair', 'distance': '2.0 km'},
    {'item': 'Byd Shark 6', 'distance': '2.2 km'},
  ];

  // Donation drives
  final List<Map<String, String>> _donationDrives = [
    {
      'title': 'Angat Buhay',
      'img': 'assets/drive1.png',
      'subtitle': 'In need of school equipment and clothes',
    },
    {
      'title': 'Tabangon Bicol',
      'img': 'assets/drive2.png',
      'subtitle': 'Accepting clothes and shoes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Decide which list to show based on _userMode
    final listData = _userMode == UserMode.donor ? _peopleNeedingItems : _itemsNearUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pass It Forward"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggles
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _userMode == UserMode.donor
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                      foregroundColor: _userMode == UserMode.donor
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _userMode = UserMode.donor;
                      });
                    },
                    child: const Text("Donate Items"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _userMode == UserMode.requestor
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                      foregroundColor: _userMode == UserMode.requestor
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _userMode = UserMode.requestor;
                      });
                    },
                    child: const Text("Request Items"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search bar
            TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              decoration: InputDecoration(
                hintText: _userMode == UserMode.donor
                    ? "Search people needing items..."
                    : "Search items near you...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // List of either people who need items (if donor) or items near user (if requestor)
            Text(
              _userMode == UserMode.donor
                  ? "People Needing Items"
                  : "Items Near You",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...listData.map((data) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(_userMode == UserMode.donor
                      ? data['name'] ?? ''
                      : data['item'] ?? ''),
                  subtitle: Text(_userMode == UserMode.donor
                      ? "Needs: ${data['need']} • ${data['distance']} away"
                      : "Distance: ${data['distance']}"),
                ),
              );
            }).toList(),

            const SizedBox(height: 16),

            // Donation Drives at the bottom, horizontally scrollable
            Text(
              "Donation Drives",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _donationDrives.length,
                itemBuilder: (ctx, index) {
                  final drive = _donationDrives[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to drive detail
                      Navigator.of(context).pushNamed(
                        DriveDetailScreen.routeName,
                        arguments: drive,
                      );
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          // Drive image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: drive['img'] != null
                                ? Image.asset(
                                    drive['img']!,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 150,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          // Title / subtitle overlay
                          Positioned(
                            bottom: 8,
                            left: 8,
                            right: 8,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                "${drive['title']}\n${drive['subtitle']}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
