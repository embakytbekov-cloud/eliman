import 'package:eliman/home/screens/locksmith/booking/broken_key_extraction_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/door_handle_replace_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/mailbox_lock_replace_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/rekey_lock_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:eliman/home/services/locksmith_service.dart';

// BOOKING SCREENS (добавим позже)
import 'package:eliman/home/screens/locksmith/booking/house_lockout_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/car_lockout_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/lock_installation_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/lock_repair_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/rekey_lock_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/smart_lock_install_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/mailbox_lock_replace_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/door_handle_replace_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/deadbolt_install_booking_screen.dart';
import 'package:eliman/home/screens/locksmith/booking/broken_key_extraction_booking_screen.dart';

class LocksmithDetailsScreen extends StatelessWidget {
  final LocksmithService item;

  const LocksmithDetailsScreen({super.key, required this.item});

// -------------------------------------------------------------
// SWITCH: OPEN BOOKING SCREEN
// -------------------------------------------------------------
  Widget getBookingScreen(LocksmithService s) {
    final data = {
      "title": s.title,
      "subtitle": s.subtitle,
      "minPrice": s.minPrice,
      "maxPrice": s.maxPrice,
      "image": s.image,
      "badge": s.badge,
    };

    switch (s.title) {
      case "House Lockout":
        return HouseLockoutBookingScreen(item: data);

      case "Car Lockout":
        return CarLockoutBookingScreen(item: data);

      case "Lock Installation":
        return LockInstallationBookingScreen(item: data);

      case "Lock Repair":
        return LockRepairBookingScreen(item: data);

      case "Rekey Locks":
        return RekeyLocksBookingScreen(item: data);

      case "Smart Lock Install":
        return SmartLockInstallBookingScreen(item: data);

      case "Mailbox Lock Replace":
        return MailboxLockReplaceBookingScreen(item: data);

      case "Door Handle Replace":
        return DoorHandleReplaceBookingScreen(item: data);

      case "Deadbolt Install":
        return DeadboltInstallBookingScreen(item: data);

      case "Broken Key Extraction":
        return BrokenKeyExtractionBookingScreen(item: data);

      default:
        return HouseLockoutBookingScreen(item: data);
    }
  }

// -------------------------------------------------------------
// UI
// -------------------------------------------------------------
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

            const SizedBox(height: 20),

// BADGE
            if (item.badge != null && item.badge!.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.badge!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),

            const SizedBox(height: 12),

// TITLE
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

// PRICE
            Text(
              "\$${item.minPrice} - \$${item.maxPrice}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

// SUBTITLE
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 28),

// FEATURES
            const Text(
              "What’s Included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 15),

            _feature("✔️ Fast emergency response"),
            _feature("✔️ Professional locksmiths"),
            _feature("✔️ All tools included"),
            _feature("✔️ Secure and damage-free entry"),
            _feature("✔️ Trusted specialists"),

            const SizedBox(height: 35),

// BOOK BUTTON
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

// FEATURE ITEM
  Widget _feature(String text) {
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
}
