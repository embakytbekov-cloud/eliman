import 'package:flutter/material.dart';
import 'package:eliman/home/services/tire_service.dart';

// TIRE BOOKING SCREENS
import 'package:eliman/home/screens/tire/booking/tire_change_at_home_booking_screen.dart';
import 'package:eliman/home/screens/tire/booking/flat_tire_repair_booking_screen.dart';
import 'package:eliman/home/screens/tire/booking/mobile_tire_repair_booking_screen.dart';
import 'package:eliman/home/screens/tire/booking/tire_rotation_booking_screen.dart';
import 'package:eliman/home/screens/tire/booking/fuel_delivery_booking_screen.dart';
import 'package:eliman/home/screens/tire/booking/jump_start_booking_screen.dart';

class TireDetailsScreen extends StatelessWidget {
  final TireService item;

  const TireDetailsScreen({super.key, required this.item});

  // -----------------------------------------------------------
  // OPEN BOOKING SCREEN BY TITLE
  // -----------------------------------------------------------
  Widget getBookingScreen(TireService s) {
    final data = {
      "title": s.title,
      "subtitle": s.subtitle,
      "minPrice": s.minPrice,
      "maxPrice": s.maxPrice,
      "image": s.image,
      "badge": s.badge,
    };

    switch (s.title) {
      case "Tire Change (At Home)":
        return TireChangeAtHomeBookingScreen(item: data);

      case "Flat Tire Repair":
        return FlatTireRepairBookingScreen(item: data);

      case "Mobile Tire Repair":
        return MobileTireRepairBookingScreen(item: data);

      case "Tire Rotation":
        return TireRotationBookingScreen(item: data);

      case "Fuel Delivery":
        return FuelDeliveryBookingScreen(item: data);

      case "Jump Start":
        return JumpStartBookingScreen(item: data);

      default:
        return TireChangeAtHomeBookingScreen(item: data);
    }
  }

  // -----------------------------------------------------------
  // SMALL FEATURE TEXT BUILDER
  // -----------------------------------------------------------
  Widget feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
    );
  }

  // -----------------------------------------------------------
  // UI
  // -----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          item.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                item.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            /// BADGE
            if (item.badge != null && item.badge!.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.badge!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),

            const SizedBox(height: 14),

            /// TITLE
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            /// PRICE
            Text(
              "\$${item.minPrice} - \$${item.maxPrice}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            /// SUBTITLE
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 25),

            /// WHAT'S INCLUDED
            const Text(
              "What's Included",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            feature("✔️ Mobile tire technician"),
            feature("✔️ Tools included"),
            feature("✔️ Same-day service"),
            feature("✔️ 30–60 min arrival time"),
            feature("✔️ Secure \$9.99 booking"),

            const SizedBox(height: 35),

            /// BOOK NOW BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => getBookingScreen(item),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23A373),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
