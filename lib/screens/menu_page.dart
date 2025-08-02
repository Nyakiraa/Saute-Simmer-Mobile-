import 'package:flutter/material.dart';
import 'profile.dart';


/*Authored by: Charlene Nepomuceno
  Company: CREation Studios
  Project: Saute & Simmer
  Feature: [SNS-003] Offerings: Menu Page
  Description: This is the menu page of our app: Saute & Simmer.
  This page displays the food options available for catering including
  Food Trays and Food Packs with detailed descriptions and set menu options.
  Users can view different food categories and meal options.
  */

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTraySize = "25-30 pax";
  String _selectedFoodPackPrice = "450";

  // Map to store prices for different tray sizes
  final Map<String, Map<String, double>> _trayPrices = {
    "25-30 pax": {
      "Pork": 3500,
      "Beef": 3950,
      "Chicken": 3600,
      "Vegetable": 2700,
      "Guisado": 1900,
      "Pasta/Noodles": 2500,
    },
    "50-55 pax": {
      "Pork": 6900,
      "Beef": 8100,
      "Chicken": 6900,
      "Vegetable": 5300,
      "Guisado": 4000,
      "Pasta/Noodles": 5200,
    },
    "100-105 pax": {
      "Pork": 13900,
      "Beef": 17100,
      "Chicken": 14100,
      "Vegetable": 10300,
      "Guisado": 8100,
      "Pasta/Noodles": 10100,
    },
  };

  // Map to track best sellers
  final Map<String, List<String>> _bestSellers = {
    "Pork": ["Baby back ribs"],
    "Beef": ["Beef Salpicao"],
    "Chicken": ["Cordon Bleu"],
    "Vegetable": ["Buttered Vegetable"],
    "Guisado": ["Pancit Guisado"],
    "Pasta/Noodles": ["Carbonara"],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      // Remove the bottom navigation bar from here
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xFF9F0100), width: 1),
            ),
            child: Row(
              children: [
                // Food Trays Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 0
                            ? const Color(0xFF9F0100)
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Food Trays',
                        style: TextStyle(
                          fontFamily: 'Archivo',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _tabController.index == 0
                              ? Colors.white
                              : const Color(0xFF9F0100),
                        ),
                      ),
                    ),
                  ),
                ),
                // Food Packs Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 1
                            ? const Color(0xFF9F0100)
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Food Packs',
                        style: TextStyle(
                          fontFamily: 'Archivo',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _tabController.index == 1
                              ? Colors.white
                              : const Color(0xFF9F0100),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Food Trays Tab
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description text
                        const Text(
                          'Indulge in a culinary feast with our extensive selection of food trays. From savory pork and beef to flavorful chicken and vegetarian options, we cater to every palate. Perfect for gatherings.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Archivo',
                            color: Color(0xFF747610),
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF9F0100),
                              width: 1,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedTraySize,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xFF9F0100),
                              ),
                              items:
                                  ["25-30 pax", "50-55 pax", "100-105 pax"].map(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      "FOOD TRAYS ($value)",
                                      style: const TextStyle(
                                        fontFamily: 'Archivo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9F0100),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedTraySize = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Pork section
                        _buildFoodSectionAlternating(
                          imageUrl: 'assets/images/TRAYSpork.jpg',
                          foodItems: [
                            'Baby back ribs',
                            'Pork Salpicao',
                            'Caldereta',
                            'Steak ala Pobre',
                            'Hamonado',
                            'Grilled Liempo',
                          ],
                          imageOnLeft: true,
                          category: 'Pork',
                        ),

                        _buildDivider(),

                        // Beef section
                        _buildFoodSectionAlternating(
                          imageUrl: 'assets/images/TRAYSbeef.jpg',
                          foodItems: [
                            'Beef Steak',
                            'Beef Salpicao',
                            'Beef Caldereta',
                            'Peppered Beef with mushroom',
                          ],
                          imageOnLeft: false,
                          category: 'Beef',
                        ),

                        _buildDivider(),

                        // Chicken section
                        _buildFoodSectionAlternating(
                          imageUrl: 'assets/images/TRAYSchicken.jpg',
                          foodItems: [
                            'Roasted Rosemary Chicken',
                            'Cordon Bleu',
                            'Buttered Chicken',
                            'Chicken Marsala',
                            'Grilled Chicken',
                          ],
                          imageOnLeft: true,
                          category: 'Chicken',
                        ),

                        _buildDivider(),

                        // Vegetable section
                        _buildFoodSectionAlternating(
                          imageUrl: 'assets/images/TRAYSvegetable.png',
                          foodItems: [
                            'Buttered Vegetable',
                            'Stir Fry Vegetable',
                            'Chopsuey',
                            'Kare Kare',
                            'Steamed Vegetable',
                          ],
                          imageOnLeft: false,
                          category: 'Vegetable',
                        ),

                        _buildDivider(),

                        // Pansit section
                        _buildFoodSectionAlternating(
                          imageUrl: 'assets/images/TRAYSpansit.jpg',
                          foodItems: [
                            'Pancit Guisado',
                            'Bihon Guisado',
                            'Sotanghon Guisado',
                          ],
                          imageOnLeft: true,
                          category: 'Guisado',
                        ),

                        _buildDivider(),

                        // Pasta section
                        _buildFoodSectionAlternating(
                          imageUrl: 'assets/images/TRAYSspag.jpg',
                          foodItems: [
                            'Carbonara',
                            'Pesto Pasta',
                            'Spaghetti',
                            'Macaroni Salad',
                          ],
                          imageOnLeft: false,
                          category: 'Pasta/Noodles',
                        ),

                        const SizedBox(height: 70), // Add extra padding for the navigation bar
                      ],
                    ),
                  ),
                ),

                // Food Packs Tab
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description text
                        const Text(
                          'Enjoy delicious and convenient meals on the go with our customizable food packs. Ideal for seminars, meetings, and busy schedules.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Archivo',
                            color: Color(0xFF346B3E),
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Food Pack images
                        Column(
                          children: [
                            // AM Snack
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      'assets/images/PACKSamsnack.jpg',
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      'AM Snack',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Archivo',
                                        color: Color(0xFF346B3E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Lunch
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      'assets/images/PACKSlunch.jpg',
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      'Lunch',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Archivo',
                                        color: Color(0xFF346B3E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // PM Snack
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      'assets/images/PACKSpmsnack.jpg',
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      'PM Snack',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Archivo',
                                        color: Color(0xFF346B3E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Price selector
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF9F0100),
                              width: 1,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedFoodPackPrice,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xFF9F0100),
                              ),
                              items: ["379", "450", "635"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    "FOOD PACK SET (₱$value)",
                                    style: const TextStyle(
                                      fontFamily: 'Archivo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF9F0100),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedFoodPackPrice = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Food Pack Set Prices Dropdown Menu
                        if (_selectedFoodPackPrice == "379")
                          _buildHorizontalFoodPackMenu(price: "379"),
                        if (_selectedFoodPackPrice == "450")
                          _buildHorizontalFoodPackMenu(price: "450"),
                        if (_selectedFoodPackPrice == "635")
                          _buildHorizontalFoodPackMenu(price: "635"),

                        const SizedBox(height: 70), // Add extra padding for the navigation bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodSectionAlternating({
    required String imageUrl,
    required List<String> foodItems,
    required bool imageOnLeft,
    required String category,
  }) {
    double price = _trayPrices[_selectedTraySize]?[category] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$category (₱${price.toStringAsFixed(0)} per tray Good for $_selectedTraySize)",
            style: const TextStyle(
              fontFamily: 'Archivo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF747610),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imageOnLeft)
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: const Color(0xFFE0E0E0), // Using a constant color instead of Colors.grey.shade300
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 30),
                        ),
                      );
                    },
                  ),
                ),
              ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  left: imageOnLeft ? 15 : 5,
                  right: imageOnLeft ? 5 : 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: foodItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "● ",
                                style: TextStyle(
                                  color: Color(0xff290606),
                                  fontSize: 18,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: item,
                                        style: const TextStyle(
                                          fontFamily: 'Archivo',
                                          fontSize: 18,
                                          color: Color(0xff290606),
                                        ),
                                      ),
                                      if (_bestSellers[category]?.contains(
                                            item,
                                          ) ??
                                          false)
                                        const TextSpan(
                                          text: " (best seller)",
                                          style: TextStyle(
                                            fontFamily: 'Archivo',
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color: Color(0xFF9F0100),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            if (!imageOnLeft)
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: const Color(0xFFE0E0E0), // Using a constant color instead of Colors.grey.shade300
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 30),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Divider(height: 1, color: Color(0xFFE0E0E0)), // Using a constant color instead of Colors.grey.shade300
    );
  }

  Widget _buildHorizontalFoodPackMenu({required String price}) {
    late List<Map<String, dynamic>> setData;

    if (price == "379") {
      setData = [
        {
          'setNumber': '1',
          'amSnack': ['Macaroni Salad', 'Pizza Roll', 'Juice/Soda'],
          'lunch': [
            'Fish Florentin',
            'Buttered Vegetable',
            'Rice',
            'Tropical Fruit w/ Almond Jelly'
          ],
          'pmSnack': ['Tuna Sandwich', 'Banana Fritters', 'Juice/Soda'],
        },
        {
          'setNumber': '2',
          'amSnack': ['Tuna Submarine', 'Sweet Potato Fries', 'Juice/Soda'],
          'lunch': [
            'Breaded Tonkatsu',
            'Stir Fried Togue w/ Tofu',
            'Rice',
            'Fresh Fruit'
          ],
          'pmSnack': ['Classic Carbonara', 'Garlic Bread', 'Juice/Soda'],
        },
        {
          'setNumber': '3',
          'amSnack': ['German Potato Salad', 'Cheese Sticks', 'Juice/Soda'],
          'lunch': ['Grilled Liempo', 'Chopsuey', 'Rice', 'Banana'],
          'pmSnack': ['Sotanghon Guisado', 'Cheese Puto', 'Juice/Soda'],
        },
        {
          'setNumber': '4',
          'amSnack': ['Pemiento Sandwich', 'Nachos', 'Juice/Soda'],
          'lunch': ['Pork Salpicao', 'Fried Lumpia', 'Rice', 'Pineapple'],
          'pmSnack': ['Bihon Guisado', 'Turon', 'Juice/Soda'],
        },
        {
          'setNumber': '5',
          'amSnack': ['Chicken Salad Sandwich', 'Potato Fries', 'Juice/Soda'],
          'lunch': ['Buttered Chicken', 'Seafood Vegetable', 'Rice', 'Gelatin'],
          'pmSnack': ['Pansit Guisado', 'Toasted Bread', 'Juice/Soda'],
        },
      ];
    } else if (price == "450") {
      setData = [
        {
          'setNumber': '1',
          'amSnack': ['Pansit Guisado', 'Turon', 'Juice/Soda'],
          'lunch': [
            'Pork Salpicao',
            'Buttered Vegetable',
            'Rice',
            'Tropical Fruit Salad'
          ],
          'pmSnack': ['Tuna Sandwich', 'Camote Chips', 'Juice/Soda'],
        },
        {
          'setNumber': '2',
          'amSnack': ['Sotanghon Guisado', 'Cheese Puto', 'Juice/Soda'],
          'lunch': ['Roasted Chicken', 'Chopsuey', 'Rice', 'Banana'],
          'pmSnack': [
            'Cheese Pemiento Sandwich',
            'Banana Fritters',
            'Juice/Soda'
          ],
        },
        {
          'setNumber': '3',
          'amSnack': ['Chicken Macaroni Salad', 'Bread Roll', 'Juice/Soda'],
          'lunch': ['Honey Orange Pork', 'Fish Fillet', 'Rice', 'Fruit Salad'],
          'pmSnack': ['Ham & Cheese Sandwich', 'Potato Fries', 'Juice/Soda'],
        },
        {
          'setNumber': '4',
          'amSnack': ['Classic Carbonara', 'Garlic Bread', 'Juice/Soda'],
          'lunch': ['Grilled Liempo', 'Laing', 'Rice', 'Pineapple'],
          'pmSnack': ['Jolly Hotdog Sandwich', 'Nachos', 'Juice/Soda'],
        },
        {
          'setNumber': '5',
          'amSnack': ['Bihon Guisado', 'Banana Chips', 'Juice/Soda'],
          'lunch': ['Pork Caldereta', 'Fried Lumpia', 'Rice', 'Gelatin'],
          'pmSnack': ['Empanada', 'Chips', 'Juice/Soda'],
        },
      ];
    } else {
      // 635
      setData = [
        {
          'setNumber': '1',
          'amSnack': ['Macaroni Salad', 'Pizza Roll', 'Juice/Soda'],
          'lunch': [
            'Fish Florentin',
            'Steak Ala Pobre',
            'Buttered Vegetable',
            'Rice',
            'Tropical Fruit Salad'
          ],
          'pmSnack': ['Tuna Sandwich', 'Earth Salad', 'Juice/Soda'],
        },
        {
          'setNumber': '2',
          'amSnack': ['Clubhaus Sandwich', 'Sweet Potato Fries', 'Juice/Soda'],
          'lunch': [
            'Chicken Marsala',
            'Breaded Tonkatsu',
            'Stir Fried Togue w/ Tofu',
            'Rice',
            'Mango Tapioca'
          ],
          'pmSnack': ['Classic Carbonara', 'Garlic Bread', 'Juice/Soda'],
        },
        {
          'setNumber': '3',
          'amSnack': [
            'German Potato Salad',
            'Grilled Chicken Sandwich',
            'Juice/Soda'
          ],
          'lunch': [
            'Chicken Cordon Bleu',
            'Grilled Liempo',
            'Chopsuey',
            'Rice',
            'Buko Pandan'
          ],
          'pmSnack': ['Sotanghon Guisado', 'Cheese Puto', 'Juice/Soda'],
        },
        {
          'setNumber': '4',
          'amSnack': ['Cheese Burger', 'Nachos', 'Juice/Soda'],
          'lunch': [
            'Fish Fillet',
            'Pork Salpicao',
            'Fried Lumpia',
            'Rice',
            'Fruit Salad'
          ],
          'pmSnack': ['Baked Macaroni', 'Cheese Sticks', 'Juice/Soda'],
        },
        {
          'setNumber': '5',
          'amSnack': ['Chicken Salad Sandwich', 'Potato Fries', 'Juice/Soda'],
          'lunch': [
            'Embutido',
            'Buttered Chicken',
            'Seafood Vegetable',
            'Rice',
            'Leche Flan'
          ],
          'pmSnack': ['Pansit Guisado', 'Toasted Bread', 'Juice/Soda'],
        },
      ];
    }

    return Column(
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            'Sample Food Pack\nSET MENU for ₱${price}',
            style: const TextStyle(
              fontFamily: 'Archivo',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9F0100),
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Menu sets
        for (var set in setData)
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFFDDDD), width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                // Set header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC0CB),
                  ),
                  child: Text(
                    'SET ${set['setNumber']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Archivo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),

                // Meal sections
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AM SNACK column
                    Expanded(
                      child: Column(
                        children: [
                          // AM SNACK header
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            color: const Color(0xFFADE2F5),
                            child: const Text(
                              'AM SNACK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Archivo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006080),
                              ),
                            ),
                          ),

                          // AM SNACK items
                          for (String item in set['amSnack'])
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white,
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Archivo',
                                  fontSize: 12,
                                  color: Color(0xFF666666), // Using a constant color instead of Colors.grey[800]
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // LUNCH column
                    Expanded(
                      child: Column(
                        children: [
                          // LUNCH header
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            color: const Color(0xFFADE2F5),
                            child: const Text(
                              'LUNCH',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Archivo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006080),
                              ),
                            ),
                          ),

                          // LUNCH items
                          for (String item in set['lunch'])
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white,
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Archivo',
                                  fontSize: 12,
                                  color: Color(0xFF666666), // Using a constant color instead of Colors.grey[800]
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // PM SNACK column
                    Expanded(
                      child: Column(
                        children: [
                          // PM SNACK header
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            color: const Color(0xFFADE2F5),
                            child: const Text(
                              'PM SNACK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Archivo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006080),
                              ),
                            ),
                          ),

                          // PM SNACK items
                          for (String item in set['pmSnack'])
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white,
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Archivo',
                                  fontSize: 12,
                                  color: Color(0xFF666666), // Using a constant color instead of Colors.grey[800]
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Free flowing coffee and pica-pica
                if (price == "635")
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFFFFF9C4),
                    child: const Text(
                      'FREE FLOWING COFFEE\nFREE PICA-PICA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Archivo',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}