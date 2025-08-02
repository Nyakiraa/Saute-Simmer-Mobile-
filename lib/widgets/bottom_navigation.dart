import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String currentRoute;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              icon: Icons.home,
              label: 'Home',
              route: '/home',
              isActive: currentRoute == '/home',
            ),
            _buildNavItem(
              context,
              icon: Icons.restaurant_menu,
              label: 'Menu',
              route: '/menu',
              isActive: currentRoute == '/menu',
            ),
            _buildNavItem(
              context,
              icon: Icons.book_online,
              label: 'Book',
              route: '/book',
              isActive: currentRoute == '/book',
            ),
            _buildNavItem(
              context,
              icon: Icons.card_giftcard,
              label: 'Packages',
              route: '/packages',
              isActive: currentRoute == '/packages',
            ),
            _buildNavItem(
              context,
              icon: Icons.shopping_cart,
              label: 'Rentals',
              route: '/rentals',
              isActive: currentRoute == '/rentals',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isActive,
  }) {
    final color = isActive ? const Color(0xFF8B0000) : Colors.grey;

    return InkWell(
      onTap: () {
        if (route != currentRoute) {
          // Navigate to the selected route
          switch (route) {
            case '/home':
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case '/menu':
              Navigator.pushReplacementNamed(context, '/menu');
              break;
            case '/book':
              Navigator.pushReplacementNamed(context, '/book');
              break;
            case '/packages':
              Navigator.pushReplacementNamed(context, '/packages');
              break;
            case '/rentals':
              Navigator.pushReplacementNamed(context, '/rentals');
              break;
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}