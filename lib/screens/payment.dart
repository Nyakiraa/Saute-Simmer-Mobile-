import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/booking_service.dart';
import 'receipt.dart';
import 'profile.dart';

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This page is for the payment method. Choosing what payment method should the customer pick.
 */

class BookingPagePayment extends StatefulWidget {
  const BookingPagePayment({Key? key}) : super(key: key);

  @override
  State<BookingPagePayment> createState() => _BookingPagePaymentState();
}

class _BookingPagePaymentState extends State<BookingPagePayment> {
  final BookingService _bookingService = BookingService();
  String? _selectedPaymentMethod;

  
  void _selectPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });

    try {
      
      _bookingService.updateBookingDetails({
        'paymentMethod': method,
      });

      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen.fromService(),
        ),
      );
    } catch (e) {
      print('Error selecting payment method: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting payment method: $e')),
      );
    }
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPaymentMethodTitle(),
            _buildPaymentOptions(),
            // Add extra padding at the bottom to account for the navigation bar
            const SizedBox(height: 70),
          ],
        ),
      ),
      // Remove the bottom navigation bar from here
      // bottomNavigationBar: const CustomBottomNavigationBar(currentRoute: '/book'),
    );
  }

  Widget _buildPaymentMethodTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'PAYMENT METHOD',
          style: AppTextStyles.paymentMethodTitle,
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDivider(),
          InkWell(
            onTap: () => _selectPaymentMethod('Contact Us'),
            child: _buildPaymentOption(
              'assets/images/contact_icon.png',
              'Contact Us',
              '+63 917 500 6429',
              topMargin: 37,
              isSelected: _selectedPaymentMethod == 'Contact Us',
            ),
          ),
          _buildDivider(topMargin: 14),
          InkWell(
            onTap: () => _selectPaymentMethod('GCash'),
            child: _buildPaymentOption(
              'assets/images/gcash_icon.png',
              'GCash',
              '+63 917 500 6429',
              topMargin: 22,
              isSelected: _selectedPaymentMethod == 'GCash',
            ),
          ),
          _buildDivider(topMargin: 14),
          InkWell(
            onTap: () => _selectPaymentMethod('Facebook'),
            child: _buildPaymentOption(
              'assets/images/facebook_icon.png',
              'Facebook',
              'Saute & Simmer Catering Services',
              topMargin: 22,
              subtitleTopMargin: 8,
              contentTopMargin: 6,
              isSelected: _selectedPaymentMethod == 'Facebook',
            ),
          ),
          _buildDivider(topMargin: 14),
        ],
      ),
    );
  }

  Widget _buildDivider({double topMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      width: double.infinity,
      child: const Divider(
        color: AppColors.dividerColor,
        thickness: 1,
      ),
    );
  }

  Widget _buildPaymentOption(
    String imagePath,
    String title,
    String subtitle, {
    double topMargin = 0,
    double subtitleTopMargin = 12,
    double contentTopMargin = 0,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: contentTopMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.paymentOptionTitle,
                  ),
                  SizedBox(height: subtitleTopMargin),
                  Text(
                    subtitle,
                    style: AppTextStyles.paymentOptionSubtitle,
                  ),
                ],
              ),
            ),
          ),
          if (isSelected)
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: AppColors.primaryRed,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}