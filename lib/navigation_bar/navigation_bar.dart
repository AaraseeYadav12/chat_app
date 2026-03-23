import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

// Import your screens
import '../chat/chat_list_Screen.dart';
import '../navigation screen/call_history_screen.dart';
import '../navigation screen/profile_screen.dart';
import '../navigation screen/status_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    UserListScreen(),
    CallHistoryScreen(),
    StatusScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      // Convex Bubble Navigation
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react, // bubble / convex style
        backgroundColor: Colors.white,
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        activeColor: Colors.white,
        color: Colors.white70,
        height: 60,
        curveSize: 100, // bubble size
        items: const [
          TabItem(icon: Icons.people, title: "Users"),
          TabItem(icon: Icons.call, title: "Calls"),
          TabItem(icon: Icons.circle_outlined, title: "Status"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
