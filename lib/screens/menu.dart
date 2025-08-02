import 'package:flutter/material.dart';
import '../services/booking_service.dart';
import 'profile.dart';
import 'menu_set.dart'; 

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This page is for the menu items and what are the prices and the foods.
 */


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  
  final List<String> _selectedItems = [];
  
  
  String _selectedPax = '25-30 pax';
  
 
  final _bookingService = BookingService();

  
  final Map<String, Map<String, int>> _pricing = {
    '25-30 pax': {
      'Pork': 3500,
      'Beef': 3950,
      'Chicken': 3600,
      'Vegetable': 2700,
      'Guisado': 1900,
      'Pasta/Noodles': 2500,
    },
    '50-55 pax': {
      'Pork': 6900,
      'Beef': 8100,
      'Chicken': 6900,
      'Vegetable': 5300,
      'Guisado': 4000,
      'Pasta/Noodles': 5200,
    },
    '100-105 pax': {
      'Pork': 13900,
      'Beef': 17100,
      'Chicken': 14100,
      'Vegetable': 10300,
      'Guisado': 8100,
      'Pasta/Noodles': 10100,
    },
  };

  
  final Map<String, List<String>> _categories = {
    'Pork': [
      'Baby Back Ribs',
      'Pork Salpicao',
      'Caldereta',
      'Steak Ala Pobre',
      'Hamonado',
      'Grilled Liempo'
    ],
    'Vegetable': [
      'Buttered Veggies',
      'Stir Fry Veggies',
      'Chop Suey',
      'Kare Kare',
      'Steamed Veggies'
    ],
    'Beef': [
      'Peppered Beef',
      'Beef Salpicao',
      'Beef Caldereta',
      'Beef Steak'
    ],
    'Guisado': [
      'Pansit',
      'Bihon',
      'Sotanghon'
    ],
    'Chicken': [
      'Roasted Rosemary',
      'Cordon Bleu',
      'Buttered',
      'Chicken Marsala',
      'Grilled Chicken'
    ],
    'Pasta/Noodles': [
      'Carbonara',
      'Pesto',
      'Spaghetti',
      'Macaroni Salad'
    ]
  };

  
  String _getCategoryForItem(String item) {
    for (final entry in _categories.entries) {
      if (entry.value.contains(item)) {
        return entry.key;
      }
    }
    return '';
  }

 
  int _getPriceForItem(String item) {
    final category = _getCategoryForItem(item);
    if (category.isEmpty) return 0;
    
    return _pricing[_selectedPax]?[category] ?? 0;
  }

 
  void _toggleItemSelection(String item) {
    try {
      setState(() {
        if (_selectedItems.contains(item)) {
          _selectedItems.remove(item);
        } else {
          _selectedItems.add(item);
        }
      });
    } catch (e) {
      print('Error toggling item selection: $e');
    }
  }

 
  void _submitOrder() {
    try {
      
      _bookingService.clearOrderItems();
      
      
      for (final item in _selectedItems) {
        final price = _getPriceForItem(item);
        _bookingService.addOrderItem(item, price);
      }
      
      
      _bookingService.updateBookingDetails({
        'guests': _selectedPax,
        'paxCount': int.parse(_selectedPax.split('-')[0]), 
      });
      
      
      List<String> allSelectedItems = _selectedItems.toList();
      
      
      int totalPrice = 0;
      for (final item in _selectedItems) {
        totalPrice += _getPriceForItem(item);
      }
      
      
      _bookingService.setSelectedMenuSet(
        1, 
        _selectedPax, 
        totalPrice, 
        allSelectedItems, 
      );
      
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderForm(),
        ),
      );
    } catch (e) {
      print('Error submitting order: $e');
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting order: $e')),
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Center(
                      child: Text(
                        'ORDER FORM',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    
                    Center(
                      child: Text(
                        'Selected Items: ${_selectedItems.length}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Pax:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        DropdownButton<String>(
                          value: _selectedPax,
                          items: _pricing.keys.map((pax) {
                            return DropdownMenuItem(
                              value: pax,
                              child: Text(pax),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedPax = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    
                   
                    for (final category in _categories.keys)
                      _buildCategorySection(category),
                  ],
                ),
              ),
            ),
            
           
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _submitOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B0000),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Remove the bottom navigation bar from here
    );
  }

  
  Widget _buildCategorySection(String category) {
    final items = _categories[category] ?? [];
    final price = _pricing[_selectedPax]?[category] ?? 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          '$category Meals (₱$price per tray)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildFoodItem(item);
          },
        ),
        const Divider(thickness: 1),
      ],
    );
  }

  
  Widget _buildFoodItem(String item) {
    final imagePath = 'assets/images/${item.toLowerCase().replaceAll(" ", "_")}.jpg';
    final isSelected = _selectedItems.contains(item);
    
    return Card(
      elevation: 2,
      color: isSelected ? const Color(0xFFFFE5E5) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                ),
              ),
            ),
            
           
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
           
            ElevatedButton(
              onPressed: () => _toggleItemSelection(item),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.red[800] : const Color(0xFF8B0000),
                minimumSize: const Size(double.infinity, 30),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                isSelected ? 'Remove' : 'Add',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}