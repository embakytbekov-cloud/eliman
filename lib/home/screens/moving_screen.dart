import 'package:flutter/material.dart';

class MovingScreen extends StatelessWidget {
  const MovingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Moving Services",
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
                "16 services",
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
          itemCount: movingServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            final item = movingServices[index];
            return MovingCard(item: item);
          },
        ),
      ),
    );
  }
}

class MovingCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const MovingCard({super.key, required this.item});

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
// ---- IMAGE ----
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                item["image"],
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 6),

// ---- BADGE ----
            if (item["badge"] != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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

// ---- TITLE ----
            Text(
              item["title"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 4),

// ---- SUBTITLE ----
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

// ---- PRICE ----
            Text(
              item["price"],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23A373),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- MOVING SERVICES DATA ----
final List<Map<String, dynamic>> movingServices = [
  {
    "badge": "Popular",
    "title": "Full Apartment Move",
    "subtitle": "Complete moving service",
    "price": "\$300 - \$800",
    "image": "assets/images/full_apartment_move.jpg"
  },
  {
    "badge": "Popular",
    "title": "Small Move",
    "subtitle": "1–2 items local moving",
    "price": "\$100 - \$250",
    "image": "assets/images/small_move.jpg"
  },
  {
    "badge": "Popular",
    "title": "Furniture Pickup",
    "subtitle": "Store-to-home delivery",
    "price": "\$80 - \$200",
    "image": "assets/images/furniture_pickup.jpg"
  },
  {
    "badge": "Emergency",
    "title": "Heavy Lifting",
    "subtitle": "Big/Heavy items moved",
    "price": "\$120 - \$250",
    "image": "assets/images/heavy_lifting.jpg"
  },
  {
    "badge": "Popular",
    "title": "Packing",
    "subtitle": "Professional packing",
    "price": "\$150 - \$400",
    "image": "assets/images/packing.jpg"
  },
  {
    "badge": "Popular",
    "title": "Unpacking",
    "subtitle": "Unpack items efficiently",
    "price": "\$120 - \$250",
    "image": "assets/images/unpacking.jpg"
  },
  {
    "badge": "Popular",
    "title": "Office Move",
    "subtitle": "Business & office relocation",
    "price": "\$400 - \$1500",
    "image": "assets/images/office_move.jpg"
  },
  {
    "title": "storage move",
    "subtitle": "Move items to/from storage",
    "price": "\$300 - \$500",
    "image": "assets/images/storage_move.jpg"
  },
];
