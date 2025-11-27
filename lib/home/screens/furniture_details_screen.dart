import 'package:flutter/material.dart';

class FurnitureDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const FurnitureDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          item['title'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// ---- IMAGE ----
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                item["image"],
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

// ---- BADGE ----
            if (item["badge"] != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF23A373).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item["badge"],
                  style: const TextStyle(
                    color: Color(0xFF23A373),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 16),

// ---- TITLE ----
            Text(
              item["title"],
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 10),

// ---- SUBTITLE ----
            Text(
              item["subtitle"],
              style: const TextStyle(
                fontSize: 17,
                color: Colors.grey,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

// ---- PRICE BLOCK ----
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF8F4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.attach_money,
                      size: 26, color: Color(0xFF23A373)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["price"],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF23A373),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Price depends on furniture size & complexity",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

// ---- WHAT'S INCLUDED ----
            const Text(
              "What’s Included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            buildBullet("Professional furniture assembly"),
            buildBullet("Tools included"),
            buildBullet("Leveling & alignment"),
            buildBullet("Cleanup of packaging materials"),

            const SizedBox(height: 30),

// ---- NOT INCLUDED ----
            const Text(
              "Not Included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            buildBullet("Wall mounting (available in Handyman category)",
                color: Colors.red),
            buildBullet("Electrical installation", color: Colors.red),
            buildBullet("Furniture moving", color: Colors.red),

            const SizedBox(height: 40),

// ---- ADVANTAGES CARDS ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSmallInfoCard(Icons.verified, "Trusted Workers"),
                buildSmallInfoCard(Icons.timer, "Fast Arrival"),
                buildSmallInfoCard(Icons.handyman, "Pro Tools"),
              ],
            ),

            const SizedBox(height: 50),

// ---- BOOK NOW BUTTON ----
            SizedBox(
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
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

// ---- WIDGETS ----

  Widget buildBullet(String text, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle,
              color: color == Colors.black ? const Color(0xFF23A373) : color,
              size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSmallInfoCard(IconData icon, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, size: 26, color: const Color(0xFF23A373)),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
