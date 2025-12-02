import 'package:flutter/material.dart';
import 'package:eliman/home/services/moving_services.dart';

/// ---- BOOKING SCREENS ----
import 'package:eliman/home/screens/moving/booking/full_apartment_move_booking_screen.dart';
import 'package:eliman/home/screens/moving/booking/small_move_booking_screen.dart';
import 'package:eliman/home/screens/moving/booking/furniture_pickup_booking_screen.dart';
import 'package:eliman/home/screens/moving/booking/heavy_lifting_booking_screen.dart';
import 'package:eliman/home/screens/moving/booking/packing_service_booking_screen.dart';
import 'package:eliman/home/screens/moving/booking/unpacking_service_booking_screen.dart';
import 'package:eliman/home/screens/moving/booking/storage_move_booking_screen.dart';
import 'package:eliman/home/screens/moving/booking/office_move_booking_screen.dart';

class MovingDetailsScreen extends StatelessWidget {
  final MovingService item;

  const MovingDetailsScreen({super.key, required this.item});

  // --------------------------------------------------------
  // SELECT WI BIM BOOKING SCREEN
  // --------------------------------------------------------
  Widget getBookingScreen(MovingService s) {
    final data = {
      "title": s.title,
      "subtitle": s.subtitle,
      "minPrice": s.minPrice,
      "maxPrice": s.maxPrice,
      "image": s.image,
      "badge": s.badge,
    };

    switch (s.title) {
      case "Full Apartment Move":
        return FullApartmentMoveBookingScreen(item: data);

      case "Small Move (1–2 items)":
        return SmallMoveBookingScreen(item: data);

      case "Furniture Pickup & Delivery":
        return FurniturePickupBookingScreen(item: data);

      case "Heavy Lifting":
        return HeavyLiftingBookingScreen(item: data);

      case "Packing Service":
        return PackingServiceBookingScreen(item: data);

      case "Unpacking Service":
        return UnpackingServiceBookingScreen(item: data);

      case "Storage Move":
        return StorageMoveBookingScreen(item: data);

      case "Office Move":
        return OfficeMoveBookingScreen(item: data);

      default:
        return FullApartmentMoveBookingScreen(item: data);
    }
  }

  // --------------------------------------------------------
  // FEATURE ROW
  // --------------------------------------------------------
  Widget buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // --------------------------------------------------------
  // MAIN UI
  // --------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                item.image,
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "\$${item.minPrice} - \$${item.maxPrice}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "What's Included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 15),

            buildFeature("Professional movers"),
            buildFeature("Safe item handling"),
            buildFeature("Fast service"),
            buildFeature("Furniture protection"),
            buildFeature("Flexible timing"),

            const SizedBox(height: 35),

            /// BOOK BUTTON
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
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
