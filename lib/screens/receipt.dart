import 'package:flutter/material.dart';
import '../services/booking_service.dart';
import 'profile.dart';


/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This page is for the receipt screen showing the venue, time, name, 
              payment, and the menus that the users picked.
 */

class BookingConfirmationScreen extends StatefulWidget {

  final Map<String, dynamic> bookingDetails;
  final String bookingNumber;
  final String status;
  final String orderTime;
  final String paymentMethod;


  factory BookingConfirmationScreen.fromService({Key? key}) {
    final bookingService = BookingService();
    

    final now = DateTime.now();
    final bookingNum = "CS-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch.toString().substring(5)}";
    
    return BookingConfirmationScreen(
      key: key,
      bookingDetails: Map<String, dynamic>.from(bookingService.bookingDetails),
      bookingNumber: bookingNum,
      status: "Confirmed",
      orderTime: "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
      paymentMethod: bookingService.bookingDetails['paymentMethod'] ?? 'Not specified',
    );
  }

  const BookingConfirmationScreen({
    Key? key,
    required this.bookingDetails,
    required this.bookingNumber,
    required this.status,
    required this.orderTime,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {

  bool _showSetMenu = true;
  String _displayEventType = 'Not specified';

  @override
  void initState() {
    super.initState();
    _processEventType();
  }

  // Process the event type to handle custom event types from "Others" category
  void _processEventType() {
    final eventType = widget.bookingDetails['eventType'] as String?;
    
    if (eventType != null) {
      // Check if it's an "Other" event type with custom input
      if (eventType.startsWith('Other:')) {
        _displayEventType = eventType;
      } else {
        _displayEventType = eventType;
      }
    }
  }

  void _finishBooking(BuildContext context) {
    
    final bookingService = BookingService();
    bookingService.clearBookingDetails(); 
    
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _toggleSetMenuVisibility() {
    setState(() {
      _showSetMenu = !_showSetMenu;
    });
  }

  @override
  Widget build(BuildContext context) {

    final hasMenuSet = widget.bookingDetails.containsKey('menuSet');
    final menuSet = widget.bookingDetails['menuSet'] as String?;
    final menuType = widget.bookingDetails['menuType'] as String?;
    final menuPrice = widget.bookingDetails['menuPrice'] as int?;
    
    final venue = widget.bookingDetails['venue'] as String? ?? 'Not specified';
    

    final specialRequest = widget.bookingDetails['specialRequest'] as String?;
    
    int paxCount;
    if (widget.bookingDetails['paxCount'] is int) {
      paxCount = widget.bookingDetails['paxCount'] as int;
    } else {
      paxCount = int.tryParse(widget.bookingDetails['guests']?.toString().split('-')[0] ?? '0') ?? 0;
    }
    
    final bookingService = BookingService();
    
    // Get the individual menu price (not multiplied)
    final individualMenuPrice = menuPrice ?? 0;
    
    // Calculate menu set total
    final menuSetTotal = individualMenuPrice * paxCount;
    
    // Calculate individual items total
    int individualItemsTotal = 0;
    for (final item in bookingService.orderItems) {
      individualItemsTotal += (item['price'] as int);
    }
    
    // Calculate the grand total
    final total = menuSetTotal + individualItemsTotal;
    
    List<String> setMenuItems = [];
    if (bookingService.selectedMenuSet.isNotEmpty) {
      final items = bookingService.selectedMenuSet['items'] as List<dynamic>? ?? [];
      setMenuItems = items.map((item) => item.toString()).toList();
    }
    
    
    List<Map<String, dynamic>> individualMenuItems = [];
    for (final item in bookingService.orderItems) {
      individualMenuItems.add({
        'name': item['name'] as String,
        'price': item['price'] as int,
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F3),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _buildSectionTitle('BOOKING DETAILS'),
              const SizedBox(height: 10),
              _buildDetailRow('Date', widget.bookingDetails['date'] ?? 'Not specified'),
              _buildDetailRow('Time', widget.bookingDetails['time'] ?? 'Not specified'),
              _buildDetailRow('Guests', '${paxCount} pax'),
              _buildDetailRow('Venue', venue), 
              _buildDetailRow('Event Type', _displayEventType),
              
              
              if (specialRequest != null && specialRequest.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15), 
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE8E8),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Special Request:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B0000),
                              fontFamily: 'Archivo',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            specialRequest,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF877C74),
                              fontFamily: 'Archivo',
                              height: 1.5, 
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15), 
                  ],
                ),
              
              const SizedBox(height: 20),
              
              
              _buildSectionTitle('BOOKED BY'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.bookingDetails['name'] ?? 'Not specified',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF877C74),
                        fontFamily: 'Archivo',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Booking #:',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF877C74),
                        fontFamily: 'Archivo',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.bookingNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF877C74),
                        fontFamily: 'Archivo',
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                widget.bookingDetails['email'] ?? 'Not specified',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF877C74),
                  fontFamily: 'Archivo',
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.bookingDetails['phone'] ?? 'Not specified',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF877C74),
                        fontFamily: 'Archivo',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Status:',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF877C74),
                        fontFamily: 'Archivo',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.status,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF877C74),
                        fontFamily: 'Archivo',
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              
              Container(
                color: const Color(0xFFD9D9D9),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'DESCRIPTION',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF877C74),
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'AMOUNT',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF877C74),
                          fontFamily: 'Archivo',
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              
              
              if (hasMenuSet && menuPrice != null && menuType != null && menuSet != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    children: [
                      // Display the menu set with per person price
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '$individualMenuPrice MENU - $menuSet',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF877C74),
                                fontFamily: 'Archivo',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '₱$individualMenuPrice/person',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF877C74),
                                fontFamily: 'Archivo',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      // Display the calculation with pax count
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '($individualMenuPrice × $paxCount pax)',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF877C74),
                                  fontFamily: 'Archivo',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '₱$menuSetTotal',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF877C74),
                                  fontFamily: 'Archivo',
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              
              
              if (setMenuItems.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Set Menu Items:',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF877C74),
                              fontFamily: 'Archivo',
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _toggleSetMenuVisibility,
                            icon: Icon(
                              _showSetMenu ? Icons.visibility_off : Icons.visibility,
                              size: 16,
                            ),
                            label: Text(_showSetMenu ? 'Hide' : 'Show'),
                            style: ElevatedButton.styleFrom(
                              
                              backgroundColor: const Color(0xFFD9D9D9),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              minimumSize: const Size(80, 30),
                              textStyle: const TextStyle(fontSize: 12),
                
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    
                    if (_showSetMenu)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: setMenuItems.map((item) => Padding(
                            padding: const EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              '• $item',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF877C74),
                                fontFamily: 'Archivo',
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                  ],
                ),
              
              
              if (individualMenuItems.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Individual Menu Items:',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF877C74),
                          fontFamily: 'Archivo',
                        ),
                      ),
                      const SizedBox(height: 5),
                      ...individualMenuItems.map((item) => Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                '• ${item['name']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF877C74),
                                  fontFamily: 'Archivo',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '₱${item['price']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF877C74),
                                  fontFamily: 'Archivo',
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              
              // Display individual items subtotal if there are individual items
              if (individualMenuItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Individual Items Subtotal:',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF877C74),
                            fontFamily: 'Archivo',
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '₱$individualItemsTotal',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF877C74),
                            fontFamily: 'Archivo',
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              
              Container(
                color: const Color(0xFFD9D9D9),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'TOTAL:',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF877C74),
                          fontFamily: 'Archivo',
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '₱$total',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF877C74),
                          fontFamily: 'Archivo',
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              
              _buildSectionTitle('ADDITIONAL INFORMATION'),
              const SizedBox(height: 10),
              Text(
                'Ordered at ${widget.orderTime}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF877C74),
                  fontFamily: 'Archivo',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Payment Method: ${widget.paymentMethod}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF877C74),
                  fontFamily: 'Archivo',
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Please make your payment to confirm your booking.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8B0000),
                  fontFamily: 'Archivo',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              
              
              _buildSectionTitle('PAYMENT INSTRUCTIONS'),
              const SizedBox(height: 10),
              _buildPaymentInstructions(),
              const SizedBox(height: 30),
              
              
              const Center(
                child: Text(
                  'THANK YOU!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF877C74),
                    fontFamily: 'Archivo',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              
              Center(
                child: ElevatedButton(
                  onPressed: () => _finishBooking(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000),
                    minimumSize: const Size(200, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Finish Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 70), // Added extra padding for the navigation bar
            ],
          ),
        ),
      ),
      // Remove the bottom navigation bar from here
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF877C74),
        fontFamily: 'Archivo',
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF877C74),
                fontFamily: 'Archivo',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF877C74),
                fontFamily: 'Archivo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF877C74),
                fontFamily: 'Archivo',
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '₱$price',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF877C74),
                fontFamily: 'Archivo',
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPaymentInstructions() {
    final paymentMethodLower = widget.paymentMethod.toLowerCase();
    
    if (paymentMethodLower.contains('contact')) {
      return const Text(
        'Please contact us at +63 917 500 6429 to arrange your payment.',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF877C74),
          fontFamily: 'Archivo',
        ),
      );
    } else if (paymentMethodLower.contains('gcash')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Please send your payment to:',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF877C74),
              fontFamily: 'Archivo',
            ),
          ),
          SizedBox(height: 5),
          Text(
            'GCash Number: +63 917 500 6429',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF877C74),
              fontFamily: 'Archivo',
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Account Name: Saute & Simmer Catering Services',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF877C74),
              fontFamily: 'Archivo',
            ),
          ),
        ],
      );
    } else if (paymentMethodLower.contains('facebook')) {
      return const Text(
        'Please message us on Facebook at "Saute & Simmer Catering Services" to arrange your payment.',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF877C74),
          fontFamily: 'Archivo',
        ),
      );
    } else {
      return const Text(
        'Please contact our customer service for payment instructions.',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF877C74),
          fontFamily: 'Archivo',
        ),
      );
    }
  }
}