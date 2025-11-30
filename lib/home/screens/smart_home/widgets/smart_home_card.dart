import 'package:flutter/material.dart';
import 'package:eliman/home/services/smart_home_service.dart';
import '../smart_home_details_screen.dart'; // <-- ВАЖНЫЙ ИМПОРТ

class SmartHomeCard extends StatelessWidget {
  final SmartHomeService item;

  const SmartHomeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        // ✅ ПЕРЕХОД В ДЕТАЛИ ЧЕРЕЗ Navigator.push
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SmartHomeDetailsScreen(item: item),
            ),
          );
        },

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                item.image,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// BADGE
            if (item.badge != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.badge!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

            /// TITLE
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            /// SUBTITLE
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 4, right: 10),
              child: Text(
                item.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            /// PRICE
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8),
              child: Text(
                "\$${item.minPrice.toStringAsFixed(0)} - \$${item.maxPrice.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
