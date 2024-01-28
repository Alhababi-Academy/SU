import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';
import 'package:su_project/home/userHome.dart';
import 'package:su_project/home/userProfile.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustom();
}

class _BottomNavigationBarCustom extends State<BottomNavigationBarCustom> {
  final List<Widget> PagesDown = [
    const HomePage(),
    const HomePage(),
    const UserProfile(),
  ];

  int currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
// Defines the build method for the widget
  Widget build(BuildContext context) {
    // Returns a Scaffold widget
    return Scaffold(
      // Defines the bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        // Defines the items in the bottom navigation bar
        items: const <BottomNavigationBarItem>[
          // Defines the first item in the bottom navigation bar
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icon for the item is set to home
            label: 'Home', // Label for the item is set to 'Home'
          ),
          // Defines the second item in the bottom navigation bar
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner_rounded,
            ), // Icon for the item is set to shield
            label: 'Passwords', // Label for the item is set to 'Passwords'
          ),
          // Defines the third item in the bottom navigation bar
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Icon for the item is set to person
            label: 'Profile', // Label for the item is set to 'Profile'
          ),
        ],
        currentIndex:
            currentIndex, // Sets the current index of the bottom navigation bar
        selectedItemColor:
            SU.backGroundContainerColor, // Sets the selected item color
        onTap:
            _onItemTapped, // Sets the onTap function for handling item tap events
        backgroundColor: SU.primaryColor,
        unselectedItemColor: SU.backGroundContainerColor.withOpacity(0.4),
      ),
      // Defines the body of the Scaffold widget
      body: PagesDown.elementAt(
          currentIndex), // Sets the body to the widget at the current index
    );
  }
}
