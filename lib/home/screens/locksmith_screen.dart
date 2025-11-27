import 'package:flutter/material.dart';
import 'package:eliman/home/screens/locksmith_details_screen.dart';

class LocksmithScreen extends StatelessWidget {
  const LocksmithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Locksmith Services",
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
                "10 services",
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
          itemCount: locksmithServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.70, // тот же размер, что и во всех экранах
          ),
          itemBuilder: (context, index) {
            final item = locksmithServices[index];
            return LocksmithCard(item: item);
          },
        ),
      ),
    );
  }
}

class LocksmithCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const LocksmithCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LocksmithDetailsScreen(item: item),
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

final List<Map<String, dynamic>> locksmithServices = [
  {
    "badge": "Emergency",
    "title": "House Lockout",
    "subtitle": "Emergency home lockout service",
    "price": "\$75 - \$150",
    "image": "assets/images/house_lockout.jpg"
  },
  {
    "badge": "Emergency",
    "title": "Car Lockout",
    "subtitle": "Locked keys in car",
    "price": "\$60 - \$120",
    "image": "assets/images/car_lockout.jpg"
  },
  {
    "badge": "Popular",
    "title": "Lock Installation",
    "subtitle": "Install new locks",
    "price": "\$80 - \$200",
    "image": "assets/images/lock_installation.jpg"
  },
  {
    "badge": "Popular",
    "title": "Lock Repair",
    "subtitle": "Fix broken door locks",
    "price": "\$70 - \$150",
    "image": "assets/images/lock_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Rekey Locks",
    "subtitle": "Change key for existing lock",
    "price": "\$50 - \$120",
    "image": "assets/images/rekey_locks.jpg"
  },
  {
    "badge": "Popular",
    "title": "Smart Lock Install",
    "subtitle": "Install smart home locks",
    "price": "\$90 - \$220",
    "image": "assets/images/smart_lock_install.jpg"
  },
  {
    "badge": null,
    "title": "Mailbox Lock Replace",
    "subtitle": "Replace mailbox locks",
    "price": "\$40 - \$90",
    "image": "assets/images/mail_lock_replace.jpg"
  },
  {
    "badge": null,
    "title": "Door Handle Replace",
    "subtitle": "Handle & knob replacement",
    "price": "\$60 - \$130",
    "image": "assets/images/door_handle_replace.jpg"
  },
  {
    "badge": null,
    "title": "Deadbolt Install",
    "subtitle": "Install deadbolt locks",
    "price": "\$80 - \$180",
    "image": "assets/images/deadbolt_install.jpg"
  },
  {
    "badge": null,
    "title": "Broken Key Extraction",
    "subtitle": "Remove broken keys",
    "price": "\$70 - \$150",
    "image": "assets/images/broken_key_extraction.jpg"
  },
];
