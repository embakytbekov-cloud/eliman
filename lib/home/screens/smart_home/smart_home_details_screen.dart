import 'package:flutter/material.dart';
import 'package:eliman/home/services/smart_home_service.dart';

// SMART SECURITY
import 'package:eliman/home/screens/smart_home/booking/video_doorbell_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/security_camera_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/smart_lock_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/garage_opener_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/doorbell_replace_booking_screen.dart';

// SMART COMFORT
import 'package:eliman/home/screens/smart_home/booking/smart_thermostat_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/smart_ac_controller_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/smart_heater_controller_booking_screen.dart';

// SMART LIGHTING & NETWORK
import 'package:eliman/home/screens/smart_home/booking/smart_switch_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/smart_dimmer_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/smart_bulbs_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/smart_assistant_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/wifi_router_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/mesh_wifi_booking_screen.dart';
import 'package:eliman/home/screens/smart_home/booking/smart_tv_booking_screen.dart';

class SmartHomeDetailsScreen extends StatelessWidget {
  final SmartHomeService item;

  const SmartHomeDetailsScreen({super.key, required this.item});

  // 🔥 OPEN BOOKING SCREEN
  Widget getBookingScreen(SmartHomeService s) {
    final data = {
      "title": s.title,
      "subtitle": s.subtitle,
      "minPrice": s.minPrice,
      "maxPrice": s.maxPrice,
      "image": s.image,
      "badge": s.badge,
    };

    switch (s.title) {
      // ⭐ SMART SECURITY
      case "Video Doorbell Install":
        return VideoDoorbellBookingScreen(item: data);
      case "Security Camera Install":
        return SecurityCameraBookingScreen(item: data);
      case "Smart Lock Install":
        return SmartLockBookingScreen(item: data);
      case "Garage Smart Opener":
        return GarageOpenerBookingScreen(item: data);
      case "Doorbell Replace/Upgrade":
        return DoorbellReplaceBookingScreen(item: data);

      // ⭐ SMART COMFORT
      case "Smart Thermostat Install":
        return SmartThermostatBookingScreen(item: data);
      case "Smart AC Controller":
        return SmartACControllerBookingScreen(item: data);
      case "Smart Heater Controller":
        return SmartHeaterControllerBookingScreen(item: data);

      // ⭐ SMART LIGHTING & NETWORK
      case "Smart Switch Install":
        return SmartSwitchBookingScreen(item: data);
      case "Smart Dimmer Install":
        return SmartDimmerBookingScreen(item: data);
      case "Smart Bulbs & Hubs Setup":
        return SmartBulbsBookingScreen(item: data);
      case "Alexa / Google Home Setup":
        return SmartAssistantBookingScreen(item: data);
      case "WiFi Router Setup":
        return WifiRouterBookingScreen(item: data);
      case "Mesh WiFi Install":
        return MeshWifiBookingScreen(item: data);
      case "Smart TV & Streaming Setup":
        return SmartTvBookingScreen(item: data);

      default:
        return VideoDoorbellBookingScreen(item: data);
    }
  }

  // WiBiM Chips or Features
  Widget feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          height: 1.3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // APP BAR
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

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
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

            // BADGE
            if (item.badge != null && item.badge!.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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

            const SizedBox(height: 16),

            // SUBTITLE
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 18),

            // PRICE
            Text(
              "\$${item.minPrice} – \$${item.maxPrice}",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // WHAT'S INCLUDED
            const Text(
              "What's Included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            feature("✔️ Expert smart home technician"),
            feature("✔️ Tools & installation included"),
            feature("✔️ App configuration & setup"),
            feature("✔️ Safety testing & verification"),
            feature("✔️ \$9.99 Secure WiBiM booking"),

            const SizedBox(height: 40),

            // BOOK NOW BUTTON
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

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
