import 'package:flutter/material.dart';

import 'package:eliman/home/services/cleaning_services.dart';

// BOOKING SCREENS
import 'package:eliman/home/screens/cleaning/booking/standard_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/deep_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/move_in_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/move_out_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/airbnb_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/office_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/post_construction_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/carpet_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/car_standard_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/car_deep_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/truck_cabin_refresh_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/truck_elite_premium_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/driveway_cleaning_booking_screen.dart';
import 'package:eliman/home/screens/cleaning/booking/sidewalk_cleaning_booking_screen.dart';

class CleaningDetailsScreen extends StatelessWidget {
  final CleaningService item;

  const CleaningDetailsScreen({super.key, required this.item});
  Widget getBookingScreen(CleaningService service) {
    final item = {
      "title": service.title,
      "subtitle": service.subtitle,
      "minPrice": service.minPrice,
      "maxPrice": service.maxPrice,
      "image": service.image,
      "badge": service.badge,
    };

    switch (service.title) {
      case "Standard Cleaning":
        return StandardCleaningBookingScreen(item: item);

      case "Deep Cleaning":
        return DeepCleaningBookingScreen(item: item);

      case "Move-In Cleaning":
        return MoveInCleaningBookingScreen(item: item);

      case "Move-Out Cleaning":
        return MoveOutCleaningBookingScreen(item: item);

      case "Airbnb Cleaning":
        return AirbnbCleaningBookingScreen(item: item);

      case "Office Cleaning":
        return OfficeCleaningBookingScreen(item: item);

      case "Post-Construction Cleaning":
        return PostConstructionBookingScreen(item: item);

      case "Carpet Cleaning":
        return CarpetCleaningBookingScreen(item: item);

      case "Car Standard Cleaning":
        return CarStandardCleaningBookingScreen(item: item);

      case "Car Deep Cleaning":
        return CarDeepCleaningBookingScreen(item: item);

      case "Truck Cabin Refresh":
        return TruckCabinRefreshBookingScreen(item: item);

      case "Truck Elite Premium":
        return TruckElitePremiumBookingScreen(item: item);

      case "Driveway Cleaning":
        return DrivewayCleaningBookingScreen(item: item);

      case "Sidewalk Cleaning":
        return SidewalkCleaningBookingScreen(item: item);

      default:
        return StandardCleaningBookingScreen(item: item);
    }
  }

  /// Small helper for the "what's included" list
  Widget buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

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
            fontSize: 20,
            fontWeight: FontWeight.w600,
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

            const SizedBox(height: 12),

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
              "\$${item.minPrice.toInt()} - \$${item.maxPrice.toInt()}",
              style: const TextStyle(
                fontSize: 20,
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

            const Text(
              "What's included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            buildFeature("✔ Professional cleaners"),
            buildFeature("✔ All supplies included"),
            buildFeature("✔ Flexible timing"),
            buildFeature("✔ Satisfaction guaranteed"),

            const SizedBox(height: 40),

            /// BOOK BUTTON
            ElevatedButton(
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
