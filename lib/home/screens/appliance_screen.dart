import 'package:flutter/material.dart';
import '../screens/appliance_details_screen.dart'; // ⭐ добавь этот импорт

class ApplianceScreen extends StatelessWidget {
  const ApplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Appliance Services",
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
                "18 services",
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
          itemCount: applianceServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.67, // 🔥 идеально, без overflow
          ),
          itemBuilder: (context, index) {
            final item = applianceServices[index];
            return ApplianceCard(item: item);
          },
        ),
      ),
    );
  }
}

// ---------------- CARD ----------
class ApplianceCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ApplianceCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ApplianceDetailsScreen(item: item),
          ),
        );
      },
      child: Container(
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

              /// TITLE
              Text(
                item["title"],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              /// SUBTITLE
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

              /// PRICE + ARROW
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
      ),
    );
  }
}
// ---------------- LIST ----------------

final List<Map<String, dynamic>> applianceServices = [
  {
    "badge": "Popular",
    "title": "Washer Repair",
    "subtitle": "Fix washing machine issues",
    "price": "\$90 - \$250",
    "image": "assets/images/washer_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Dryer Repair",
    "subtitle": "Dryer heating & drum issues",
    "price": "\$80 - \$230",
    "image": "assets/images/dryer_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Refrigerator Repair",
    "subtitle": "Cooling, leaking, noise issues",
    "price": "\$120 - \$350",
    "image": "assets/images/refrigerator_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Dishwasher Repair",
    "subtitle": "Leaks, pump, sensor issues",
    "price": "\$100 - \$300",
    "image": "assets/images/dishwasher_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Oven Repair",
    "subtitle": "Heating & electrical issues",
    "price": "\$90 - \$250",
    "image": "assets/images/oven_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Stove Repair",
    "subtitle": "Gas or electric stove fix",
    "price": "\$90 - \$220",
    "image": "assets/images/stove_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Microwave Repair",
    "subtitle": "Microwave repair service",
    "price": "\$70 - \$150",
    "image": "assets/images/microwave_repair.jpg"
  },
  {
    "title": "Garbage_disposal",
    "subtitle": "Fix garbage disposal",
    "price": "\$80 - \$180",
    "image": "assets/images/garbage_disposal.jpg"
  },
  {
    "title": "Ice Maker Repair",
    "subtitle": "Repair ice maker",
    "price": "\$90 - \$220",
    "image": "assets/images/ice_maker_repair.jpg"
  },
  {
    "title": "Range hood repair ",
    "subtitle": "Range hood repair ",
    "price": "\$90 - \$220",
    "image": "assets/images/rage_hood_repair.jpg"
  },
];
