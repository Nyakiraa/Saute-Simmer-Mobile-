import 'package:flutter/material.dart';
import 'meal_column.dart';

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This is the structure of the menus and menu set design.
 */

class MenuSet extends StatelessWidget {
  final int setNumber;
  final List<String> amSnackItems;
  final List<String> lunchItems;
  final List<String> pmSnackItems;
  final bool hasFreebies;

  const MenuSet({
    Key? key,
    required this.setNumber,
    required this.amSnackItems,
    required this.lunchItems,
    required this.pmSnackItems,
    this.hasFreebies = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width <= 640;

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Set Title
          Text(
            'SET $setNumber',
            style: TextStyle(
              color: Colors.black.withOpacity(0.54),
              fontFamily: 'Archivo',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.28,
              height: 12 / 14,
            ),
          ),
          const SizedBox(height: 15),

          
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFFD9D9D9),
            child: isSmallScreen
                ? Column(
                    children: [
                      MealColumn(
                        title: 'AM Snack',
                        items: amSnackItems,
                        bottomMargin: 15,
                      ),
                      MealColumn(
                        title: 'Lunch',
                        items: lunchItems,
                        bottomMargin: 15,
                      ),
                      MealColumn(
                        title: 'PM Snack',
                        items: pmSnackItems,
                        bottomMargin: 15,
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MealColumn(
                          title: 'AM Snack',
                          items: amSnackItems,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MealColumn(
                          title: 'Lunch',
                          items: lunchItems,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MealColumn(
                          title: 'PM Snack',
                          items: pmSnackItems,
                        ),
                      ),
                    ],
                  ),
          ),

          
          if (hasFreebies)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: const Column(
                children: [
                  Text(
                    'FREE FLOWING COFFEE',
                    style: TextStyle(
                      color: Colors.black, 
                      fontFamily: 'Archivo',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.28,
                      height: 12 / 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'FREE PICA - PICA',
                    style: TextStyle(
                      color: Colors.black, 
                      fontFamily: 'Archivo',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.28,
                      height: 12 / 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

          
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF852221),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                minimumSize: const Size(60, 19),
                padding: EdgeInsets.zero,
                textStyle: TextStyle(
                  fontFamily: 'Archivo',
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                  height: 20 / 14,
                ),
              ),
              child: const Text('Select'),
            ),
          ),
        ],
      ),
    );
  }
}
