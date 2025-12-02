import 'package:flutter/material.dart';
import 'package:eliman/home/services/handyman_services.dart';

// ─────────────────────────────────────────────────────────────
//                        IMPORTS
// ─────────────────────────────────────────────────────────────

// BASIC BOOKING SCREENS
import 'package:eliman/home/screens/handyman/booking/tv_mounting_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/light_fixture_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/ceiling_fan_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/faucet_repair_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/window_door_repair_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/drywall_repair_booking_screen.dart';

// WIBIM NEW SERVICES
import 'package:eliman/home/screens/handyman/booking/baby_proofing_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/shelf_mounting_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/furniture_disassembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/outdoor_furniture_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/curtain_rod_install_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/small_painting_booking_screen.dart';

// EXTRA SERVICES
import 'package:eliman/home/screens/handyman/booking/wall_patch_repair_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/appliance_hookup_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/minor_plumbing_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/cabinet_repair_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/clean_bathroom_fan_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/replace_air_filters_booking_screen.dart';

// ADVANCED HANDYMAN SERVICES
import 'package:eliman/home/screens/handyman/booking/window_blinds_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/tile_caulking_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/door_handle_fix_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/general_handyman_booking_screen.dart';

// ASSEMBLY SERVICES
import 'package:eliman/home/screens/handyman/booking/furniture_assembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/bed_frame_assembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/table_assembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/desk_assembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/sofa_assembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/dresser_assembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/wardrobe_assembly_booking_screen.dart';
import 'package:eliman/home/screens/handyman/booking/baby_proofing_booking_screen.dart';

// ─────────────────────────────────────────────────────────────
//                MAIN SCREEN CLASS
// ─────────────────────────────────────────────────────────────

class HandymanDetailsScreen extends StatelessWidget {
  final HandymanService item;

  const HandymanDetailsScreen({super.key, required this.item});

  // ─────────────────────────────────────────────────────────────
  //                    BOOKING ROUTER
  // ─────────────────────────────────────────────────────────────
  Widget getBookingScreen(HandymanService s) {
    final data = {
      "title": s.title,
      "subtitle": s.subtitle,
      "minPrice": s.minPrice,
      "maxPrice": s.maxPrice,
      "image": s.image,
      "badge": s.badge,
    };

    switch (s.title) {
      // ───────── BASIC SERVICES ─────────
      case "TV Mounting":
        return TvMountingBookingScreen(item: data);

      case "Light Fixture Install":
        return LightFixtureBookingScreen(item: data);

      case "Ceiling Fan Install":
        return CeilingFanBookingScreen(item: data);

      case "Faucet Repair":
        return FaucetRepairBookingScreen(item: data);

      case "Window/Door Repair":
        return WindowDoorRepairBookingScreen(item: data);

      case "Drywall Repair":
        return DrywallRepairBookingScreen(item: data);

      // ───────── WIBIM NEW SERVICES ─────────
      case "Baby Proofing":
        return BabyProofingBookingScreen(item: data);

      case "Shelf Mounting":
        return ShelfMountingBookingScreen(item: data);

      case "Furniture Disassembly":
        return FurnitureDisassemblyBookingScreen(item: data);

      case "Outdoor Furniture":
        return OutdoorFurnitureBookingScreen(item: data);

      case "Curtain Rod Install":
        return CurtainRodInstallBookingScreen(item: data);

      case "Small Painting":
        return SmallPaintingBookingScreen(item: data);

      // ───────── EXTRA SERVICES ─────────
      case "Wall Patch Repair":
        return WallPatchRepairBookingScreen(item: data);

      case "Appliance Hookup":
        return ApplianceHookupBookingScreen(item: data);

      case "Minor Plumbing":
        return MinorPlumbingBookingScreen(item: data);

      case "Cabinet Repair":
        return CabinetRepairBookingScreen(item: data);

      case "Clean Bathroom Fan":
        return CleanBathroomFanBookingScreen(item: data);

      case "Replace Air Filters":
        return ReplaceAirFiltersBookingScreen(item: data);

      // ───────── ADVANCED HANDYMAN SERVICES ─────────
      case "Window Blinds":
        return WindowBlindsBookingScreen(item: data);

      case "Tile Caulking":
        return TileCaulkingBookingScreen(item: data);

      case "Door Handle Fix":
        return DoorHandleFixBookingScreen(item: data);

      case "General Handyman":
        return GeneralHandymanBookingScreen(item: data);

      // ───────── ASSEMBLY SERVICES ─────────
      case "Furniture Assembly":
        return FurnitureAssemblyBookingScreen(item: data);

      case "Bed and Frame Assembly":
        return BedFrameAssemblyBookingScreen(item: data);

      case "Table Assembly":
        return TableAssemblyBookingScreen(item: data);

      case "Desk Assembly":
        return DeskAssemblyBookingScreen(item: data);

      case "Sofa Assembly":
        return SofaAssemblyBookingScreen(item: data);

      case "Dresser Assembly":
        return DresserAssemblyBookingScreen(item: data);

      case "Wardrobe Assembly":
        return WardrobeAssemblyBookingScreen(item: data);

      case "Baby Proofing":
        return BabyProofingBookingScreen(item: data);

      // ───────── DEFAULT ─────────
      default:
        return GeneralHandymanBookingScreen(item: data);
    }
  }

  // ─────────────────────────────────────────────────────────────
  //                  FEATURE ROW BUILDER
  // ─────────────────────────────────────────────────────────────
  Widget feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //                        UI
  // ─────────────────────────────────────────────────────────────

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
            // IMAGE
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

            // BADGE
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

            // TITLE
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            // PRICE
            Text(
              "\$${item.minPrice} - \$${item.maxPrice}",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
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

            const SizedBox(height: 25),

            // INCLUDED
            const Text(
              "What's Included",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            feature("✔️ Background-checked professionals"),
            feature("✔️ Tools included"),
            feature("✔️ Same-day options available"),
            feature("✔️ Secure \$9.99 booking"),

            const SizedBox(height: 35),

            // BOOK BUTTON
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
                  fontWeight: FontWeight.w700,
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
