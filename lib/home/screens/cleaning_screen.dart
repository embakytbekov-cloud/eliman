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
            childAspectRatio: 0.70, // ключ! больше пространства для фото
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---- IMAGE (точно как в ServiceItem) ----
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              item['image'],
              height: 120, // 1-в-1 как в ServiceItem
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 6),

          /// ---- BADGE ----
          if (item['badge'] != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item['badge'],
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

          const SizedBox(height: 6),

          /// ---- TITLE ----
          Text(
            item['title'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          /// ---- SUBTITLE ----
          Text(
            item['subtitle'],
            maxLines: 1, // как в ServiceItem
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          /// ---- PRICE ----
          Text(
            item['price'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> cleaningServices = [
  {
    "badge": "Popular",
    "title": "Standard Cleaning",
    "subtitle": "Regular home cleaning service",
    "price": "\$90 - \$300",
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
    "image": "assets/images/post_construction_cleaning.jpg",
  },
  {
    "title": "Carpet-Cleaning",
    "subtitle": "Professional service provider",
    "price": "\$120 - \$250",
    "image": "assets/images/carpet_cleaning.jpg",
  },
  {
    "title": "Car-standard cleaning",
    "subtitle": "Detailed Interior Cleaning",
    "price": "\$120 - \$140",
    "image": "assets/images/car_standard_cleaning.jpg",
  },
  {
    "title": "car-deep cleaning",
    "subtitle": "Thorough Interior Cleaning",
    "price": "\$300 - \$500",
    "image": "assets/images/car_deep_cleaning.jpg",
  },
  {
    "title": "Truck Cabin refresh",
    "subtitle": "Standard Truck Interior Cleaning",
    "price": "\$160-250\$",
    "image": "assets/images/truck_cabin_cleaning.jpg",
  },
  {
    "title": "Truck Elit Premium",
    "subtitle": "Flawless cleanliness for you truck",
    "price": "\$400 -700\$",
    "image": "assets/images/truck_deep_cleaning.jpg",
  },
  {
    "title": "Driveway cleaning",
    "subtitle": "Clear driveway snow",
    "price": "\$80-120\$",
    "image": "assets/images/driveway_cleaning.jpg",
  },
  {
    "title": "sidewalk cleaning",
    "subtitle": "Clear driveway snow",
    "price": "\60-100\$",
    "image": "assets/images/sidewalk_cleaning.jpg",
  },
];
