// booking_service.dart
class BookingService {
  static final BookingService _instance = BookingService._internal();
  
  factory BookingService() {
    return _instance;
  }
  
  BookingService._internal();
  
  // Booking details
  Map<String, dynamic> bookingDetails = {};
  
  // Order items
  List<Map<String, dynamic>> orderItems = [];
  
  // Add a property to store selected menu set information
  Map<String, dynamic> selectedMenuSet = {};
  
  // Add an order item
  void addOrderItem(String name, int price) {
    orderItems.add({
      'name': name,
      'price': price,
    });
  }
  
  // Remove an order item
  void removeOrderItem(int index) {
    if (index >= 0 && index < orderItems.length) {
      orderItems.removeAt(index);
    }
  }
  
  // Clear all order items
  void clearOrderItems() {
    orderItems.clear();
  }
  
  // Update booking details
  void updateBookingDetails(Map<String, dynamic> details) {
    bookingDetails.addAll(details);
  }
  
  // Clear booking details
  void clearBookingDetails() {
    bookingDetails.clear();
    selectedMenuSet.clear();
    orderItems.clear();
  }
  
  // Add a method to set the selected menu set
  void setSelectedMenuSet(int setNumber, String menuType, int price, List<String> items) {
    selectedMenuSet = {
      'setNumber': setNumber,
      'menuType': menuType,
      'price': price,
      'items': items,
    };
    
    // Also update booking details with this information
    updateBookingDetails({
      'menuSet': 'Set $setNumber',
      'menuType': menuType,
      'menuPrice': price,
    });
  }
  
  // Calculate total based on menu price and guest count
  int calculateTotal() {
    final menuPrice = bookingDetails['menuPrice'] as int? ?? 0;
    final guestCount = int.tryParse(bookingDetails['paxCount']?.toString() ?? '0') ?? 0;
    return menuPrice * guestCount;
  } 
  
  // Get all selected menu items as a formatted list
  List<String> getSelectedMenuItems() {
    List<String> result = [];
    
    // Add items from the selected menu set
    if (selectedMenuSet.isNotEmpty) {
      final List<dynamic> items = selectedMenuSet['items'] as List<dynamic>? ?? [];
      for (var item in items) {
        result.add(item.toString());
      }
    }
    
    // Add items from individual selections
    for (final item in orderItems) {
      result.add(item['name'] as String);
    }
    
    return result;
  }
}