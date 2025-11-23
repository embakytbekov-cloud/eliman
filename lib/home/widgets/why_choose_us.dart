import 'package:flutter/material.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        WhyItem(
          icon: Icons.verified,
          title: "Verified Pros",
          text: "Background-checked technicians you can trust.",
        ),
        SizedBox(height: 12),
        WhyItem(
          icon: Icons.flash_on,
          title: "Fast Response",
          text: "Same day or next day service available.",
        ),
        SizedBox(height: 12),
        WhyItem(
          icon: Icons.attach_money,
          title: "Fair Pricing",
          text: "Clear prices. No hidden fees.",
        ),
        SizedBox(height: 12),
        WhyItem(
          icon: Icons.support_agent,
          title: "24/7 Support",
          text: "Always here to help.",
        ),
      ],
    );
  }
}

class WhyItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const WhyItem({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.green.withOpacity(0.15),
          child: Icon(icon, color: Colors.green, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
