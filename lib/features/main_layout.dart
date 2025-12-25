import 'package:flutter/material.dart';
import 'package:nti_final_project/core/widgets/custom_bottom_navbar.dart';
import 'package:nti_final_project/core/widgets/custom_top_appbar.dart';
import 'package:nti_final_project/features/chats/chats_screen.dart';
import 'package:nti_final_project/features/profile/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ChatsScreen(),
    SizedBox(), // Groups (later)
    ProfileScreen(),
    SizedBox(), // More (later)
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}
