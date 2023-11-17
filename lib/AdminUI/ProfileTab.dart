import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 60, 91, 1.0),
      // appBar: AppBar(
      //   title: const Text(''),
      // ),
      body: Center(
        child: const Text('Profile Tab Content'),
      ),
    );
  }
}

