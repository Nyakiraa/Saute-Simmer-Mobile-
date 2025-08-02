import 'package:flutter/material.dart';
import 'home_page.dart';
import 'packages_page.dart';
import 'menu_page.dart';
import 'rentals_page.dart';
import 'book_now_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;
  
  // List of pages to display
  final List<Widget> _pages = [
    HomePage(
      onNavigate: (index) {
        // This will be handled in the build method
      },
    ),
    const PackagesPage(),
    const MenuPage(),
    const RentalsPage(),
    const BookNowScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update the HomePage's onNavigate callback
    if (_pages[0] is HomePage) {
      final homePage = _pages[0] as HomePage;
      _pages[0] = HomePage(
        onNavigate: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      );
    }

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF9F0100),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Packages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chair),
            label: 'Rentals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Book Now',
          ),
        ],
      ),
    );
  }
}