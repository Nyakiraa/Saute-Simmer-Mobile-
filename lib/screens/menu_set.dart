import 'package:flutter/material.dart';
import 'profile.dart';
import '../services/booking_service.dart';
import 'payment.dart';

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This page is for the set menus, picking the set menus and the foods in the set menu
 */

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
 
  int? _selectedSet;
  String? _selectedMenuType;
  
  
  final _bookingService = BookingService();

  
  final Map<int, Map<String, List<String>>> _menuSets = {
    1: {
      'AM Snack': ['Macaroni Salad', 'Pizza Roll', 'Juice / Soda'],
      'Lunch': ['Fish Florentin', 'Steak Ala Pobre', 'Buttered Vegetables', 'Rice', 'Tropical Fruit Salad'],
      'PM Snack': ['Tuna Sandwich', 'Earth Salad', 'Juice / Soda']
    },
    2: {
      'AM Snack': ['Clubhaus Sandwich', 'Sweet Potato Fries', 'Juice / Soda'],
      'Lunch': ['Chicken Marsala', 'Breaded Tonkatsu', 'Stir Fried Togue W/ Tofu', 'Rice', 'Mango Tapioca'],
      'PM Snack': ['Classic Carbonara', 'Garlic Bread', 'Juice / Soda']
    },
    3: {
      'AM Snack': ['German Potato Salad', 'Grilled Chicken Sandwich', 'Juice / Soda'],
      'Lunch': ['Chicken Cordon Bleu', 'Grilled Liempo', 'Chopsuey', 'Rice', 'Buko Pandan'],
      'PM Snack': ['Sotanghon Guisado', 'Cheese Puto', 'Juice / Soda']
    },
    4: {
      'AM Snack': ['Cheese Burger', 'Nachos', 'Juice / Soda'],
      'Lunch': ['Fish Fillet', 'Pork Salpicao', 'Fried Lumpia', 'Rice', 'Fruit Salad'],
      'PM Snack': ['Baked Macaroni', 'Cheese Sticks', 'Juice / Soda']
    },
    5: {
      'AM Snack': ['Chicken Salad Sandwich', 'Potato Fries', 'Juice / Soda'],
      'Lunch': ['Embutido', 'Buttered Chicken', 'Seafood Vegetables', 'Rice', 'Leche Flan'],
      'PM Snack': ['Pansit Guisado', 'Toasted Bread', 'Juice / Soda']
    }
  };

  
  final Map<String, int> _menuSetPrices = {
    '635 MENU': 635,
    '379 MENU': 379,
  };

 
  void _selectMenuSet(int setNumber, String menuType) {
    setState(() {
      _selectedSet = setNumber;
      _selectedMenuType = menuType;
    });
    
    try {
      
      final menuPrice = _menuSetPrices[menuType] ?? 0;
      
      List<String> allItems = [];
      final menuItems = _menuSets[setNumber] ?? {};
      
      menuItems.forEach((mealType, items) {
        allItems.addAll(items);
      });
      
      _bookingService.setSelectedMenuSet(
        setNumber,
        menuType,
        menuPrice,
        allItems,
      );
      
    } catch (e) {
      print('Error selecting menu set: $e');
    }
  }

  void _submitMenuSet() {
    if (_selectedSet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a menu set')),
      );
      return;
    }

    try {

      final menuPrice = _menuSetPrices[_selectedMenuType ?? ''] ?? 0;
      

      List<String> allItems = [];
      final menuItems = _menuSets[_selectedSet ?? 0] ?? {};
      
 
      menuItems.forEach((mealType, items) {
        allItems.addAll(items);
      });
      
 
      _bookingService.setSelectedMenuSet(
        _selectedSet!,
        _selectedMenuType ?? '',
        menuPrice,
        allItems,
      );
      

      if (!_bookingService.bookingDetails.containsKey('paxCount')) {

        final paxMatch = RegExp(r'(\d+)').firstMatch(_selectedMenuType ?? '0');
        final paxCount = paxMatch != null ? int.parse(paxMatch.group(1)!) : 0;
        
        _bookingService.updateBookingDetails({
          'paxCount': paxCount,
        });
      }
      
 
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BookingPagePayment(),
        ),
      );
    } catch (e) {
      print('Error submitting menu set: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting menu set: $e')),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: const Text(
                      'ORDER FORM',
                      style: TextStyle(
                        color: Color(0xFF8B0000),
                        fontFamily: 'Archivo',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  
                  // 635 MENU Section
                  _buildMenuTypeHeader('635 MENU'),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  _buildMenuSet(1, '635 MENU', true),
                  _buildMenuSet(2, '635 MENU', true),
                  _buildMenuSet(3, '635 MENU', true),
                  _buildMenuSet(4, '635 MENU', true),
                  _buildMenuSet(5, '635 MENU', true),
                  
                  // 379 MENU Section
                  _buildMenuTypeHeader('379 MENU'),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  _buildMenuSet(1, '379 MENU', false),
                  _buildMenuSet(2, '379 MENU', false),
                  _buildMenuSet(3, '379 MENU', false),
                  _buildMenuSet(4, '379 MENU', false),
                  _buildMenuSet(5, '379 MENU', false),
                  
                  
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _submitMenuSet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B0000),
                        minimumSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70), // Added extra padding for the navigation bar
                ],
              ),
            ),
          ),
        ],
      ),
      // Remove the bottom navigation bar from here
    );
  }

  Widget _buildMenuTypeHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      color: const Color(0xFFF8F8F8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF666666),
          fontFamily: 'Archivo',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMenuSet(int setNumber, String menuType, bool hasFreebies) {
    final menuSet = _menuSets[setNumber] ?? {};
    final isSelected = _selectedSet == setNumber && _selectedMenuType == menuType;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          color: const Color(0xFFF8F8F8),
          child: Text(
            'SET $setNumber',
            style: const TextStyle(
              color: Color(0xFF666666),
              fontFamily: 'Archivo',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildMealColumn('AM Snack', menuSet['AM Snack'] ?? []),
              ),
              Expanded(
                child: _buildMealColumn('Lunch', menuSet['Lunch'] ?? []),
              ),
              Expanded(
                child: _buildMealColumn('PM Snack', menuSet['PM Snack'] ?? []),
              ),
            ],
          ),
        ),
        
        
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: hasFreebies ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'FREE FLOWING COFFEE',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontFamily: 'Archivo',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'FREE PICA-PICA',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontFamily: 'Archivo',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ) : Container(), 
              ),
              ElevatedButton(
                onPressed: () => _selectMenuSet(setNumber, menuType),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.red[900] : const Color(0xFF8B0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                ),
                child: Text(
                  isSelected ? 'Selected' : 'Select',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Archivo',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }

  Widget _buildMealColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF666666),
            fontFamily: 'Archivo',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            item,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontFamily: 'Archivo',
              fontSize: 10,
            ),
          ),
        )).toList(),
      ],
    );
  }
}