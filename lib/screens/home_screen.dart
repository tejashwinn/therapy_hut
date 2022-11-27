import 'package:flutter/material.dart';
import 'package:therapy_hut/resources/auth_methods.dart';
import 'package:therapy_hut/screens/history_meeting_screen.dart';
import 'package:therapy_hut/screens/meeting_screen.dart';
import 'package:therapy_hut/utils/colors.dart';
import 'package:therapy_hut/widgets/custom_button.dart';
import 'package:therapy_hut/widgets/home_meeting_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthMethods _authMethods = AuthMethods();

  int _page = 0;
  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    const HistoryMeetingScreen(),
    const Text("contacts"),
    CustomButton(text: 'Log Out', onPressed: () {})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Meet & Chat"),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _page,
          onTap: onPageChange,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14.0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.comment_bank,
                ),
                label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_clock,
                ),
                label: "History"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: "Contacts"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: "Settings"),
          ]),
    );
  }
}
