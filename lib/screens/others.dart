import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'profile.dart';
import 'menu.dart';
import '../services/booking_service.dart';

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This page is for the others event user input the specific event.
 */

class OtherEventRegistrationScreen extends StatefulWidget {
  final Map<String, String> otherInfo;

  const OtherEventRegistrationScreen({
    Key? key, 
    required this.otherInfo,
  }) : super(key: key);

  @override
  State<OtherEventRegistrationScreen> createState() => _OtherEventRegistrationScreenState();
}

class _OtherEventRegistrationScreenState extends State<OtherEventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bookingService = BookingService();
  
  late final TextEditingController _eventTypeController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _streetAddressController;
  late final TextEditingController _cityController;
  late final TextEditingController _provinceController;
  late final TextEditingController _phoneController;
  late final TextEditingController _peopleController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  late final TextEditingController _specialRequestController;

  @override
  void initState() {
    super.initState();
    
    _eventTypeController = TextEditingController(text: widget.otherInfo['eventType'] ?? '');
    final nameParts = widget.otherInfo['name']?.split(' ') ?? ['', ''];
    _firstNameController = TextEditingController(text: nameParts.isNotEmpty ? nameParts[0] : '');
    _lastNameController = TextEditingController(text: nameParts.length > 1 ? nameParts[1] : '');
    _streetAddressController = TextEditingController(text: widget.otherInfo['address'] ?? '');
    _cityController = TextEditingController(text: widget.otherInfo['city'] ?? '');
    _provinceController = TextEditingController(text: widget.otherInfo['province'] ?? '');
    _phoneController = TextEditingController(text: widget.otherInfo['phone'] ?? '+63');
    _peopleController = TextEditingController(text: widget.otherInfo['people'] ?? '');
    _dateController = TextEditingController(text: widget.otherInfo['date'] ?? '');
    _timeController = TextEditingController(text: widget.otherInfo['time'] ?? '');
    _specialRequestController = TextEditingController(text: widget.otherInfo['specialRequest'] ?? '');
  }

  @override
  void dispose() {
    _eventTypeController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _phoneController.dispose();
    _peopleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _specialRequestController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8B0000),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8B0000),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  bool _validateForm() {
    if (_eventTypeController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _streetAddressController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _provinceController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _peopleController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return false;
    }
    return true;
  }

  void _submitAndGoToMenu() {
    if (!_validateForm()) return;

    final String combinedVenue = [
      _streetAddressController.text.trim(),
      _cityController.text.trim(),
      _provinceController.text.trim()
    ].where((part) => part.isNotEmpty).join(', ');

    final bookingDetails = {
      'name': '${_firstNameController.text} ${_lastNameController.text}',
      'email': '${_firstNameController.text.toLowerCase()}${_lastNameController.text.toLowerCase()}@example.com',
      'phone': _phoneController.text,
      'address': _streetAddressController.text,
      'city': _cityController.text,
      'province': _provinceController.text,
      'venue': combinedVenue, 
      'date': _dateController.text,
      'time': _timeController.text,
      'guests': _peopleController.text,
      'specialRequest': _specialRequestController.text,
      'eventType': ' ${_eventTypeController.text}',
    };

    _bookingService.updateBookingDetails(bookingDetails);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ),
    );
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
          children: [
            Image.asset(
              'assets/images/Others.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: Color(0xFFD9D9D9)),
                    const SizedBox(height: 16),
                    
                    const Center(
                      child: Text(
                        'OTHERS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    const Center(
                      child: Text(
                        'Your registration will be verified prior to your call',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Archivo',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    _buildInputField(
                      label: 'What kind of event?',
                      controller: _eventTypeController,
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            label: 'First Name',
                            controller: _firstNameController,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInputField(
                            label: 'Last Name',
                            controller: _lastNameController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInputField(
                      label: 'Street Address',
                      controller: _streetAddressController,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            label: 'City',
                            controller: _cityController,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInputField(
                            label: 'Province',
                            controller: _provinceController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            label: 'Phone Number',
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInputField(
                            label: 'Number of People',
                            controller: _peopleController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(
                            label: 'Date',
                            controller: _dateController,
                            onTap: () => _selectDate(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildDateField(
                            label: 'Time',
                            controller: _timeController,
                            onTap: () => _selectTime(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInputField(
                      label: 'Do you have any special requests?',
                      controller: _specialRequestController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitAndGoToMenu,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B0000),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Archivo',
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
      ),
      // Remove the bottom navigation bar from here
    );
  }

  // Reusable input field widget
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Archivo',
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  // Calendar
  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Archivo',
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}