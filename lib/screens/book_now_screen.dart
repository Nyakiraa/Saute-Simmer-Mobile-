import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import 'wedding.dart'; 
import 'birthday.dart';
import 'social_event.dart';
import 'corporate.dart';
import 'others.dart';
import 'profile.dart';

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This booking page allows users to select their desired event quickly and easily. 
            Simply click the tab and enter your details, select your 
            preferred date and time, and submit the form.
*/

class BookNowScreen extends StatelessWidget {
 const BookNowScreen({super.key}); 

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
     body: SingleChildScrollView(
       padding: const EdgeInsets.all(20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const Text(
             'BOOK NOW',
             style: TextStyle(
               fontSize: 24,
               fontWeight: FontWeight.w600,
               color: Color(0xFF666666),
               fontFamily: 'Archivo',
             ),
           ),
           const SizedBox(height: 5),
           const Divider(
             color: Color(0xFFCCCCCC),
             thickness: 1.0,
             height: 20,
           ),
           const Text(
             'Events',
             style: TextStyle(
               fontSize: 24,
               color: Color(0xFF666666),
               fontFamily: 'Archivo',
             ),
           ),
           const SizedBox(height: 20),
           _buildEventCards(context),
           const SizedBox(height: 80), // Extra padding for the navigation bar
         ],
       ),
     ),
     // We don't need to add the bottom navigation bar here since it's already in the main layout
   );
 }

 Widget _buildEventCards(BuildContext context) {
   final List<Map<String, String>> events = [
     {'image': 'assets/images/Wedding.jpg', 'name': 'WEDDING'},
     {'image': 'assets/images/Birthday.jpg', 'name': 'BIRTHDAY'},
     {'image': 'assets/images/Social.jpg', 'name': 'SOCIAL EVENTS'},
     {'image': 'assets/images/Corporate.jpg', 'name': 'CORPORATE'},
     {'image': 'assets/images/Others.jpg', 'name': 'OTHERS'},
   ];

   return Column(
     children: events.map((event) {
       return Padding(
         padding: const EdgeInsets.only(bottom: 20),
         child: EventCard(
           imageUrl: event['image']!,
           eventName: event['name']!,
           onTap: () {
             print('Tapped on ${event['name']}'); 
             
             if (event['name'] == 'WEDDING') {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const WeddingRegistrationScreen(
                     weddingInfo: {
                       'name': '',
                       'address': '',
                       'city': '',
                       'province': '',
                       'phone': '+63',
                       'date': '2025-01-01',
                       'time': '12:00',
                       'specialRequest': '',
                     },
                   ),
                 ),
               );
             } else if (event['name'] == 'BIRTHDAY') { 
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const BirthdayRegistrationScreen(
                     birthdayInfo: {
                       'name': '',
                       'address': '',
                       'city': '',
                       'province': '',
                       'phone': '+63',
                       'date': '2025-01-01',
                       'time': '12:00',
                       'specialRequest': '',
                     },
                   ),
                 ),
               );
             } else if (event['name'] == 'SOCIAL EVENTS') { 
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const SocialRegistrationScreen(
                     socialInfo: {
                       'name': '',
                       'address': '',
                       'city': '',
                       'province': '',
                       'phone':'+63',
                       'date': '2025-01-01',
                       'time': '12:00',
                       'specialRequest': '',
                     },
                   ),
                 ),
               );
             } else if (event['name'] == 'CORPORATE') { 
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const CorporateRegistrationScreen(
                     corporateInfo: {
                       'name': '',
                       'address': '',
                       'city': '',
                       'province': '',
                       'phone':'+63',
                       'date': '2025-01-01',
                       'time': '12:00',
                       'specialRequest': '',
                     },
                   ),
                 ),
               );
             } else if (event['name'] == 'OTHERS') { 
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const OtherEventRegistrationScreen(
                     otherInfo: {
                       'name': '',
                       'address': '',
                       'city': '',
                       'province': '',
                       'phone':'+63',
                       'date': '2025-01-01',
                       'time': '12:00',
                       'specialRequest': '',
                     },
                   ),
                 ),
               );
             }
           },
         ),
       );
     }).toList(),
   );
 }
}