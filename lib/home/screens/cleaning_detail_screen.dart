import 'package:flutter/material.dart';

class CleaningDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const CleaningDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          item["title"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---- LARGE IMAGE ----
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                item["image"],
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            /// BADGE
            if (item['badge'] != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['badge'],
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),

            const SizedBox(height: 12),

            /// TITLE
            Text(
              item["title"],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            /// PRICE
            Text(
              item["price"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            /// SUBTITLE (DESCRIPTION)
            Text(
              item["subtitle"],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 25),

            /// ---- FEATURES ----
            const Text(
              "What's included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            buildFeature("✔ Professional cleaners"),
            buildFeature("✔ All supplies included"),
            buildFeature("✔ Flexible timing"),
            buildFeature("✔ Satisfaction guaranteed"),

            const SizedBox(height: 40),

            /// ---- BOOK NOW BUTTON ----
            ElevatedButton(
              onPressed: () {
// Тут позже добавим страницу бронирования
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF23A373),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Book Now",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Helper for bullet points
  Widget buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
