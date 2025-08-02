import 'package:flutter/material.dart';
import 'profile.dart';

/*Authored by: Charlene Nepomuceno
  Company: CREation Studios
  Project: Saute & Simmer
  Feature: [SNS-003] Offerings: Packages
  Description: This is the Packages page of our app: Saute & Simmer.
  This is where the user will land after he/she clicks either of the
  two: View Packages Button on the homepage or; the Packages Icon on 
  the bottom navigation bar.
  This is where the user can view the current Packages offered by
  Saute & Simmer Catering Services. It also lists all the Inclusions
  and Freebies of each packages.
  */

class PackagesPage extends StatelessWidget {
  const PackagesPage({Key? key}) : super(key: key);

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
      body: const PackagesListView(),
    );
  }
}

class PackagesListView extends StatelessWidget {
  const PackagesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Simplify your event planning with our all-inclusive packages. From elegant weddings to lively birthdays and professional seminars, we handle every detail.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Archivo',
                color: Color(0xFF346B3E),
                fontSize: 20,
                height: 1.4,
              ),
            ),
          ),

          // Wedding Package Card
          const PackageCard(
            title: 'Wedding Package',
            imageUrl: 'assets/images/weddingpackage.jpg',
            inclusions: [
              'Catering with Full Buffet Setup',
              'Venue Decor and Setup',
              'Elegant Gowns and Suits',
            ],
            freebies: [
              '2-tier Wedding Cake',
              'Cupcakes',
              'Red Wine',
            ],
          ),

          // Birthday Package Card
          const PackageCard(
            title: 'Birthday Package',
            imageUrl: 'assets/images/birthdaypackage.jpg',
            inclusions: [
              'Catering with Full Buffet Setup',
              'Venue Decor and Setup',
              'Menu for Adults and Kids',
              'Backdrop Styling',
              'Ceiling Decoration',
              'Lights and Sound System',
            ],
            freebies: [
              '2-tier Birthday Cake',
              'Magician Host',
              'Game Prizes',
            ],
          ),

          // Seminar Package Card
          const PackageCard(
            title: 'Seminar Package',
            imageUrl: 'assets/images/seminarpackage.jpg',
            inclusions: [
              'Food Buffet / Food Packs',
              'Venue Decor and Setup',
              'Lights and Sounds',
              'Waiters',
            ],
            freebies: [
              'Flowing Coffee',
              'Pica-pica',
            ],
          ),

          const SizedBox(height: 70), // Add extra padding for the navigation bar
        ],
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final List<String> inclusions;
  final List<String> freebies;

  const PackageCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.inclusions,
    required this.freebies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Package image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: const Color(0xFFE0E0E0),
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 5),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Archivo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ),

          // Inclusions section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'Inclusions:',
              style: TextStyle(
                fontFamily: 'Archivo',
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ),

          // Inclusions list
          Column(
            children: inclusions
                .map((inclusion) => _buildListItem(inclusion))
                .toList(),
          ),

          // Freebies section
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 5),
            child: Text(
              'Freebies:',
              style: TextStyle(
                fontFamily: 'Archivo',
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ),

          // Freebies list
          Column(
            children: freebies.map((freebie) => _buildListItem(freebie)).toList(),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Archivo',
          fontSize: 18,
          color: Color(0xFF9F0100),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}