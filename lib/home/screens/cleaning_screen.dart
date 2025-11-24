import 'package:flutter/material.dart';

class CleaningScreen extends StatelessWidget {
  const CleaningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Services",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "12 services",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: cleaningServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final item = cleaningServices[index];
            return CleaningCard(item: item);
          },
        ),
      ),
    );
  }
}

class CleaningCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const CleaningCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item["image"],
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

// BADGE
            if (item["badge"] != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF23A373).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item["badge"],
                  style: const TextStyle(
                    color: Color(0xFF23A373),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),

            const SizedBox(height: 8),

// TITLE
            Text(
              item["title"],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 4),

// SUBTITLE
            Text(
              item["subtitle"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const Spacer(),

// PRICE AND ARROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item["price"],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF23A373),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> cleaningServices = [
  {
    "badge": "Popular",
    "title": "Standard Cleaning",
    "subtitle": "Regular home cleaning service",
    "price": "\$80 - \$150",
    "image": "assets/images/standard_cleaning.jpg",
  },
  {
    "badge": "Popular",
    "title": "Deep Cleaning",
    "subtitle": "Thorough deep cleaning for your home",
    "price": "\$150 - \$300",
    "image": "assets/images/deep_cleaning.jpg",
  },
  {
    "title": "Move-In Cleaning",
    "subtitle": "Complete cleaning before moving in",
    "price": "\$120 - \$250",
    "image": "assets/images/move_in_cleaning.jpg",
  },
  {
    "title": "Move-Out Cleaning",
    "subtitle": "Final cleaning when moving out",
    "price": "\$120 - \$250",
    "image": "assets/images/move_out_cleaning.jpg",
  },
  {
    "badge": "Popular",
    "title": "Airbnb Cleaning",
    "subtitle": "Quick turnaround cleaning for rentals",
    "price": "\$60 - \$120",
    "image": "assets/images/airbnb_cleaning.jpg",
  },
  {
    "title": "Office Cleaning",
    "subtitle": "Professional office space cleaning",
    "price": "\$100 - \$200",
    "image": "assets/images/office_cleaning.jpg",
  },
  {
    "title": "Post-Construction Cleaning",
    "subtitle": "Clean up after construction work",
    "price": "\$200 - \$400",
    "image": "assets/images/post_construction.jpg",
  },
  {
    "title": "After-Party Cleaning",
    "subtitle": "Full cleaning after events",
    "price": "\$120 - \$250",
    "image": "assets/images/after_party.jpg",
  },
];
