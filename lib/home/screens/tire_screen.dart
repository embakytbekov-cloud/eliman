import 'package:flutter/material.dart';
import 'package:eliman/home/screens/tire_details_screen.dart';

class TireScreen extends StatelessWidget {
  const TireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Tire Services",
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
          itemCount: tireServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            final item = tireServices[index];
            return TireCard(item: item);
          },
        ),
      ),
    );
  }
}

class TireCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const TireCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TireDetailsScreen(item: item),
          ),
        );
      },
      child: Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
      ),
    );
  }
}

final List<Map<String, dynamic>> tireServices = [
  {
    "badge": "Popular",
    "title": "Mobile Tire Change",
    "subtitle": "Replace tires on-site",
    "price": "\$60 - \$120",
    "image": "assets/images/tire_change.jpg"
  },
  {
    "badge": "Popular",
    "title": "Flat Tire Repair",
    "subtitle": "Patch or plug flat tires",
    "price": "\$40 - \$90",
    "image": "assets/images/flat_tire_change.jpg"
  },
  {
    "badge": null,
    "title": "Tire Rotation",
    "subtitle": "Rotate tires for even wear",
    "price": "\$30 - \$60",
    "image": "assets/images/tire_rotation.jpg"
  },
  {
    "badge": null,
    "title": "tire_installation",
    "subtitle": "Balance wheels on-site",
    "price": "\$50 - \$90",
    "image": "assets/images/tire_installation.jpg"
  },
  {
    "badge": "Emergency",
    "title": "Roadside Assistance",
    "subtitle": "Emergency tire help",
    "price": "\$70 - \$150",
    "image": "assets/images/roadside_assistance.jpg"
  },
  {
    "badge": null,
    "title": "Tire Delivery",
    "subtitle": "We bring new tires to you",
    "price": "\$100 - \$300",
    "image": "assets/images/tire_delivery.jpg"
  },
  {
    "badge": null,
    "title": "Rim Repair",
    "subtitle": "Fix bent or damaged rims",
    "price": "\$80 - \$200",
    "image": "assets/images/rim_repair.jpg"
  },
  {
    "badge": null,
    "title": "Lug Nut tightening",
    "subtitle": "Replace broken or missing lugs",
    "price": "\$20 - \$50",
    "image": "assets/images/lug_nut_tightening.jpg"
  },
];
