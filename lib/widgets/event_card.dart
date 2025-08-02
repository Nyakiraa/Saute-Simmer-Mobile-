import 'package:flutter/material.dart';

/* Authored by: Raphael Andrei Abad
Company: CREative Studios
Project: Sauté & Simmer
Feature: [SNS-004] Booking Page
Description: This page is for the event cards of the book now screen.
 */

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String eventName;
  final VoidCallback? onTap; 

  const EventCard({
    Key? key,
    required this.imageUrl,
    required this.eventName,
    this.onTap, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNetworkImage = imageUrl.startsWith('http') || imageUrl.startsWith('https');

    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          
          Positioned.fill(
            child: isNetworkImage
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[300]),
                  )
                : Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[300]),
                  ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                eventName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Archivo',
                ),
              ),
            ),
          ),
          
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
