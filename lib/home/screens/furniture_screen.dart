import 'package:flutter/material.dart';

class FurnitureScreen extends StatelessWidget {
  const FurnitureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Furniture Services",
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
                "8 services",
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
          itemCount: furnitureServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.70, // такой же как у остальных
          ),
          itemBuilder: (context, index) {
            final item = furnitureServices[index];
            return FurnitureCard(item: item);
          },
        ),
      ),
    );
  }
}

class FurnitureCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const FurnitureCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
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

            /// BADGE
            if (item["badge"] != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF23A373).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item["badge"],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF23A373),
                  ),
                ),
              ),

            const SizedBox(height: 6),

            /// TITLE
            Text(
              item["title"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 2),

            /// SUBTITLE
            Text(
              item["subtitle"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 6),

            /// PRICE
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

final List<Map<String, dynamic>> furnitureServices = [
  {
    "badge": "Popular",
    "title": "Furniture Assembly",
    "subtitle": "Assemble any furniture",
    "price": "\$60 - \$150",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Furniture Disassembly",
    "subtitle": "Disassemble furniture safely",
    "price": "\$50 - \$120",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Bed Assembly",
    "subtitle": "Assemble all bed types",
    "price": "\$70 - \$160",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Dresser Assembly",
    "subtitle": "Assemble dressers & cabinets",
    "price": "\$60 - \$140",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Table Assembly",
    "subtitle": "Assemble dining / office tables",
    "price": "\$50 - \$120",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Chair Assembly",
    "subtitle": "Office / home chairs setup",
    "price": "\$40 - \$100",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Outdoor Furniture",
    "subtitle": "Patio furniture setup",
    "price": "\$80 - \$180",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Office Furniture",
    "subtitle": "Build office desks & chairs",
    "price": "\$90 - \$200",
    "image": "assets/images/furniture_assembly.jpg",
  },
  {
    "badge": "Popular",
    "title": "Office Furniture",
    "subtitle": "Build office desks & chairs",
    "price": "\$90 - \$200",
    "image": "assets/images/furniture_assembly.jpg",
  },
];
