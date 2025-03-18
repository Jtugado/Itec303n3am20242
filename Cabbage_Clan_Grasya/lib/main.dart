import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/drive_detail_screen.dart';
import 'screens/donate_item_screen.dart';
import 'screens/request_item_screen.dart';

void main() {
  runApp(const PassItForwardApp());
}

class PassItForwardApp extends StatelessWidget {
  const PassItForwardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Define three constant colors:
    const Color angatPink = Color.fromARGB(255, 240, 70, 127); // Pink
    const Color angatTeal = Color.fromARGB(255, 89, 211, 235); // Teal
    const Color lightBlue = Color(0xFFBBDEFB);                 // Light Blue for background

    // 2. Create a custom color scheme using those colors:
    const customColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: angatPink,
      onPrimary: Colors.white,
      secondary: angatPink,
      onSecondary: Colors.white,
      background: lightBlue,          // Use the pleasing light blue
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
    );

    // 3. Build the MaterialApp using these colors:
    return MaterialApp(
      title: 'Pass It Forward',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: customColorScheme).copyWith(
        // Make the entire Scaffold background light blue
        scaffoldBackgroundColor: lightBlue,

        // AppBar uses pink background, white text
        appBarTheme: const AppBarTheme(
          backgroundColor: angatPink,
          foregroundColor: Colors.white,
        ),

        // Elevated buttons can be pink or any custom color you prefer
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: angatPink,
            foregroundColor: Colors.white,
          ),
        ),

        // BottomNavigationBar theme: teal background, pink selected, white unselected
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: angatTeal,
          selectedItemColor: angatPink,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const MainScreen(),
      routes: {
        ChatDetailScreen.routeName: (ctx) => const ChatDetailScreen(),
        DriveDetailScreen.routeName: (ctx) => const DriveDetailScreen(),
        DonateItemScreen.routeName: (ctx) => const DonateItemScreen(),
        RequestItemScreen.routeName: (ctx) => const RequestItemScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ExploreScreen(),
    SizedBox.shrink(), // placeholder for the center + button
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showAddOptions(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 12,
          children: [
            ListTile(
              leading: const Icon(Icons.volunteer_activism),
              title: const Text("Donate Items"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(DonateItemScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.request_quote),
              title: const Text("Request Items"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RequestItemScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
