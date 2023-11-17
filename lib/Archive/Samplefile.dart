import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key}) ;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Application'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeTab(),
          SearchTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.search),
            label: 'Search',
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

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Tab'),
      ),
      body: Center(
        child: const Text('Home Tab Content'),
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tab'),
      ),
      body: Center(
        child: const Text('Search Tab Content'),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Tab'),
      ),
      body: Center(
        child: const Text('Profile Tab Content'),
      ),
    );
  }
}