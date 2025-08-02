import 'package:flutter/material.dart';
import 'profile.dart';

/*Authored by: Charlene Nepomuceno
  Company: CREation Studios
  Project: Saute & Simmer
  Feature: [SNS-003] Offerings: Rentals
  Description: This is the rentals page of our app: Saute & Simmer.
  This page displays the list of all available equipments
  needed for a catering event.
  */

class RentalsPage extends StatelessWidget {
  const RentalsPage({Key? key}) : super(key: key);

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFF1F1),
    appBar: AppBar(
      backgroundColor: const Color(0xFF8B0000),
      title: Image.asset(
        'assets/images/logo.png',
        height: 60,
        fit: BoxFit.contain,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.person, color: Colors.white, size: 28),
          onPressed: () {
            // Navigate to the profile page when profile icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
      ],
    ),
      // Remove the bottom navigation bar from here
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete your event with our premium rental inventory. We provide everything you need, from elegant tables and chairs to stylish decorations and essential equipment.',
              style: const TextStyle(
                fontFamily: 'Archivo',
                color: Color(0xFF96590A),
                fontSize: 20,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildRentalItem(
                    'Round Tables', 'assets/images/roundTable.jpg'),
                _buildRentalItem(
                    'Rectangular Tables', 'assets/images/rectangularTable.jpg'),
                _buildRentalItem('Tiffany Chairs', 'assets/images/tifanny.png'),
                _buildRentalItem(
                    'Chair Covers', 'assets/images/chairCovers.jpg'),
                _buildRentalItem('Ceramic Plates', 'assets/images/plates.jpg'),
                _buildRentalItem('Glasses', 'assets/images/glasses.jpg'),
                _buildRentalItem('Utensils', 'assets/images/utensils.jpg'),
                _buildRentalItem('Soup Bowls', 'assets/images/soupBowls.jpg'),
                _buildRentalItem(
                    'Chafing Dishes', 'assets/images/chafingDishes.jpg'),
                _buildRentalItem('Crates', 'assets/images/crates.jpg'),
                _buildRentalItem('Lamps', 'assets/images/lamp.jpg'),
                _buildRentalItem(
                    'Flowers & Backdrop', 'assets/images/backdrop.jpg'),
              ],
            ),
            const SizedBox(height: 70), // Add extra padding for the navigation bar
          ],
        ),
      ),
    );
  }

  Widget _buildRentalItem(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Archivo',
                color: Color(0xFF346B3E),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}