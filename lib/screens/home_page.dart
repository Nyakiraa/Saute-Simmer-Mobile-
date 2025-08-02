import 'package:flutter/material.dart';
// Remove the bottom navigation import since it's causing duplication
// import '../widgets/bottom_navigation.dart';

/*Authored by: Charlene Nepomuceno
  Company: CREation Studios
  Project: Saute & Simmer
  Feature: [SNS-002] Homepage
  Description: This is the home page of our app: Saute & Simmer.
  This is where the user will land after he/she registers/login for the first time.
  The user can see summarized Featured Services and their description and can also
  navigate to each pages including the booking page.
  */

class HomePage extends StatelessWidget {
  final Function(int)? onNavigate;

  const HomePage({Key? key, this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9F0100),
      // Remove the bottom navigation bar from here
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              _buildFeaturedServices(),
              _buildMenuSection(),
              _buildRentalsSection(),
              _buildWhyChooseUs(),
              _buildCallToAction(),
              const SizedBox(height: 70), // Add extra padding at bottom for the navigation bar
            ],
          ),
        ),
      ),
    );
  }

Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 0.5), 
          ],
        ),
        const Positioned(
          bottom: 0,
          child: SizedBox(
            width: 400,
            child: Text(
              'Delicious catering, stunning event, setups, and more for every occasions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Archivo',
                color: Colors.white,
                fontSize: 20,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



  Widget _buildFeaturedServices() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text(
                'Our Featured Services',
                style: TextStyle(
                  fontFamily: 'Archivo',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Container(
                height: 1,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Image.asset(
                'assets/images/HOMEpackages.jpg',
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Simplify your event planning with our all-inclusive packages. From elegant weddings to lively birthdays and professional seminars, we handle every detail.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Archivo',
                        color: Color(0xFF346B3E),
                        fontSize: 18,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (onNavigate != null) {
                          onNavigate!(1);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCCCCC),
                        minimumSize: const Size(150, 40),
                      ),
                      child: const Text('View Packages'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Image.asset(
                'assets/images/HOMEmenu.jpg',
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Your perfect meal awaits. Our menu features convenient food packs for individual needs and generous food trays for group gatherings. Choose from our set menus for a seamless dining experience.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Archivo',
                        color: Color(0xFF346B3E),
                        fontSize: 18,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (onNavigate != null) {
                          onNavigate!(2);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCCCCC),
                        minimumSize: const Size(150, 40),
                      ),
                      child: const Text('Explore Menu'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRentalsSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Image.asset(
                'assets/images/HOMErentals.jpg',
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Complete your event with our premium rental inventory. We provide everything you need, from elegant tables and chairs to stylish decorations and essential equipment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Archivo',
                        color: Color(0xFF346B3E),
                        fontSize: 18,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (onNavigate != null) {
                          onNavigate!(3);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCCCCC),
                        minimumSize: const Size(150, 40),
                      ),
                      child: const Text('Browse Rentals'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWhyChooseUs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: [
          const Text(
            'Why Choose Sauté & Simmer?',
            style: TextStyle(
              fontFamily: 'Archivo',
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildBenefitBox(
                  'Exceptional Quality',
                  'We source the freshest ingredients and provide top-tier service, ensuring a premium experience.',
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildBenefitBox(
                  'Customizable Options',
                  'Tailor our packages, menus, and rentals to your specific needs, creating a personalized event.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildBenefitBox(
                  'Complete Solution',
                  'From planning to execution, we handle every detail of your event, making us your one-stop solution.',
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildBenefitBox(
                  'Professional Service',
                  'Our experienced team ensures a seamless and stress-free event, allowing you to relax and enjoy.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitBox(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Archivo',
              color: Color(0xFF9F0100),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Archivo',
              color: Color(0xFF747610),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Column(
        children: [
          const Text(
            'Ready To Plan Your Event?',
            style: TextStyle(
              fontFamily: 'Archivo',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () {
              if (onNavigate != null) {
                onNavigate!(4);
              }
            },
            icon: const Icon(Icons.menu_book, color: Colors.white, size: 20),
            label: const Text(
              'Book Now',
              style: TextStyle(
                fontFamily: 'Archivo',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}