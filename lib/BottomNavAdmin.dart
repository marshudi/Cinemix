import 'package:cinemix/AdminUI/AdminPanel.dart';
import 'package:cinemix/AdminUI/HomeTab.dart';
import 'package:cinemix/AdminUI/ProfileTab.dart';


import 'package:flutter/material.dart';

class BottomNavAdmin extends StatefulWidget {


  final String userKey,email, firstName, lastName, password;
  const BottomNavAdmin({
    Key? key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.userKey,

  }) : super(key: key);

  @override
  State<BottomNavAdmin> createState() => _BottomNavAdminState();
}

class _BottomNavAdminState extends State<BottomNavAdmin> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeTab(),
          AdminPanel(),
          ProfileTab(
            email: widget.email,
            firstName: widget.firstName,
            lastName: widget.lastName,
            password: widget.password,
            userKey: widget.userKey,
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        unselectedItemColor: Color(0xffff6aaa),
        selectedItemColor: Color.fromRGBO(255, 255, 255, 1.0),
        onTap: (int tappedItemIndex) {
          setState(() {
            _currentIndex = tappedItemIndex;
          });

          // if (_currentIndex == 0) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text("Clicked Home"),
          //     ),
          //   );
          // }
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            label: 'Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
