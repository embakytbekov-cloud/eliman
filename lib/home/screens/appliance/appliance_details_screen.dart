import 'package:flutter/material.dart';
import 'package:eliman/home/services/appliance_service.dart';

// BOOKING SCREENS (добавим по очереди)
import 'package:eliman/home/screens/appliance/booking/washer_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/dryer_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/refrigerator_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/dishwasher_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/oven_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/stove_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/microwave_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/garbage_disposal_booking.dart';
import 'package:eliman/home/screens/appliance/booking/ice_maker_repair_booking.dart';
import 'package:eliman/home/screens/appliance/booking/range_hood_repair_booking.dart';

class ApplianceDetailsScreen extends StatelessWidget {
  final ApplianceService item;

  const ApplianceDetailsScreen({super.key, required this.item});

  // -----------------------------------------------------------
  // SWITCH — открываем нужный booking screen
  // -----------------------------------------------------------
  Widget getBookingScreen(ApplianceService s) {
    final data = {
      "title": s.title,
      "subtitle": s.subtitle,
      "minPrice": s.minPrice,
      "maxPrice": s.maxPrice,
      "image": s.image,
      "badge": s.badge,
    };

    switch (s.title) {
      case "Washer Repair":
        return WasherRepairBookingScreen(item: data);

      case "Dryer Repair":
        return DryerRepairBookingScreen(item: data);

      case "Refrigerator Repair":
        return RefrigeratorRepairBookingScreen(item: data);

      case "Dishwasher Repair":
        return DishwasherRepairBookingScreen(item: data);

      case "Oven Repair":
        return OvenRepairBookingScreen(item: data);

      case "Stove Repair":
        return StoveRepairBookingScreen(item: data);

      case "Microwave Repair":
        return MicrowaveRepairBookingScreen(item: data);

      case "Garbage Disposal":
        return GarbageDisposalRepairBookingScreen(item: data);

      case "Ice Maker Repair":
        return IceMakerRepairBookingScreen(item: data);

      case "Range Hood Repair":
        return RangeHoodRepairBookingScreen(item: data);

      default:
        return WasherRepairBookingScreen(item: data);
    }
  }

  // -----------------------------------------------------------
  // FEATURE BUILDER
  // -----------------------------------------------------------
  Widget feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
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
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 18),

            /// BADGE
            if (item.badge != null && item.badge!.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.badge!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),

            const SizedBox(height: 14),

            /// SUBTITLE
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            /// PRICE
            Text(
              "\$${item.minPrice} – \$${item.maxPrice}",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23A373),
              ),
            ),

            const SizedBox(height: 30),

            /// WHAT'S INCLUDED
            const Text(
              "What’s Included",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            feature("✔️ Licensed appliance technician"),
            feature("✔️ Diagnostic & full inspection"),
            feature("✔️ Tools & basic parts included"),
            feature("✔️ 30–90 min arrival time"),
            feature("✔️ \$9.99 WIBIM secure booking"),

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
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
