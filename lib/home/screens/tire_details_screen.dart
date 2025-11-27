import 'package:flutter/material.dart';

class TireDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const TireDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          item["title"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---- BIG IMAGE ----
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                item["image"],
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            /// ---- CONTENT ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    item["title"],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// SUBTITLE
                  Text(
                    item["subtitle"],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// PRICE BOX
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF23A373).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.payments,
                            color: Color(0xFF23A373), size: 26),
                        const SizedBox(width: 12),
                        Text(
                          "Price: ${item["price"]}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF23A373),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  /// WHAT’S INCLUDED
                  const Text(
                    "What’s included",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildCheck("Mobile tire change anywhere"),
                  _buildCheck("Professionally trained technician"),
                  _buildCheck("We come to your location"),
                  _buildCheck("Fast 20–40 min service"),
                  _buildCheck("Free inspection included"),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),

      /// ---- BOOK NOW BUTTON ----
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23A373),
              padding: const EdgeInsets.symmetric(vertical: 18),
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
        ),
      ),
    );
  }

  /// ----- Small reusable check-row -----
  Widget _buildCheck(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF23A373), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
