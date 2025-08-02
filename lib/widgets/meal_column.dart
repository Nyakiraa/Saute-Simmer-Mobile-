import 'package:flutter/material.dart';

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This is the meals of the set menus and menus.
 */

class MealColumn extends StatelessWidget {
  final String title;
  final List<String> items;
  final double bottomMargin;

  const MealColumn({
    Key? key,
    required this.title,
    required this.items,
    this.bottomMargin = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            title,
            style: TextStyle(
              color: Colors.black.withOpacity(0.54), 
              fontFamily: 'Archivo',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.28,
              height: 12 / 11,
            ),
          ),
          const SizedBox(height: 5),

          
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.54), 
                  fontFamily: 'Archivo',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.28,
                  height: 12 / 9,
                ),
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }
}
