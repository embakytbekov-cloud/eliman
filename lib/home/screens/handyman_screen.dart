import 'package:flutter/material.dart';

class HandymanScreen extends StatelessWidget {
  const HandymanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Handyman Services",
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
                "24 services",
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
          itemCount: handymanServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            return HandymanCard(item: handymanServices[index]);
          },
        ),
      ),
    );
  }
}

class HandymanCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const HandymanCard({super.key, required this.item});

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
            /// IMAGE (увеличено)
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
                    color: Color(0xFF23A373),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 2),

            /// SUBTITLE (короче)
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item["price"],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF23A373),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> handymanServices = [
  {
    "badge": "Popular",
    "title": "TV Mounting",
    "subtitle": "Professional TV wall mounting",
    "price": "\$75 - \$150",
    "image": "assets/images/tv_mounting.jpg"
  },
  {
    "badge": "Popular",
    "title": "Light Fixture Install",
    "subtitle": "Replace or install new lights",
    "price": "\$60 - \$120",
    "image": "assets/images/handyman_light.jpg"
  },
  {
    "badge": "Popular",
    "title": "Ceiling Fan Install",
    "subtitle": "Install or replace ceiling fans",
    "price": "\$80 - \$180",
    "image": "assets/images/handyman_fan.jpg"
  },
  {
    "badge": "Popular",
    "title": "Faucet Repair",
    "subtitle": "Fix leaking faucets",
    "price": "\$70 - \$130",
    "image": "assets/images/handyman_faucet.jpg"
  },
  {
    "badge": "Popular",
    "title": "Drywall Repair",
    "subtitle": "Repair damaged drywall",
    "price": "\$90 - \$200",
    "image": "assets/images/handyman_drywall.jpg"
  },
  {
    "badge": "Popular",
    "title": "Furniture Assembly",
    "subtitle": "Assemble home furniture",
    "price": "\$60 - \$150",
    "image": "assets/images/furniture_assembly.jpg"
  },
];
