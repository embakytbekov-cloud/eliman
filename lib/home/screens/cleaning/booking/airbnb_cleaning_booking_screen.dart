import 'package:flutter/material.dart';

class AirbnbCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const AirbnbCleaningBookingScreen({super.key, required this.item});

  @override
  State<AirbnbCleaningBookingScreen> createState() =>
      _AirbnbCleaningBookingScreenState();
}

class _AirbnbCleaningBookingScreenState
    extends State<AirbnbCleaningBookingScreen> {
// ------------ TIME SLOTS ------------
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 6 PM",
    "9 AM – 6 PM",
    "6 PM – 9 PM",
  ];

  String selectedTime = "9 AM – 12 PM";

// ------------ DATE ------------
  List<String> generateAvailableDates() {
    DateTime now = DateTime.now();
    return List.generate(
      3,
      (i) => "${now.year}/${now.month}/${now.day + i}",
    );
  }

  String selectedDate = "";

// ------------ EXTRA SERVICES ------------
  bool linenService = false;
  bool laundry = false;
  bool restockSupplies = false;
  bool trashRemoval = false;

// ------------ BEDROOMS / BATHROOMS ------------
  int bedrooms = 1;
  int bathrooms = 1;
  bool hasPets = false;

  @override
  void initState() {
    super.initState();
    selectedDate = generateAvailableDates()[0];
  }

// ------------ PRICE CALCULATION (*.double fix) ------------
  int minPriceCalc() {
    int min = (widget.item["minPrice"] as double).toInt();
    int extra = 0;

// Bedrooms + Bathrooms
    extra += (bedrooms - 1) * 10;
    extra += (bathrooms - 1) * 10;

// Extras
    if (linenService) extra += 10;
    if (laundry) extra += 15;
    if (restockSupplies) extra += 10;
    if (trashRemoval) extra += 10;

// Pets
    if (hasPets) extra += 20;

    return min + extra;
  }

  int maxPriceCalc() {
    int max = (widget.item["maxPrice"] as double).toInt();
    int extra = 0;

// Bedrooms + Bathrooms
    extra += (bedrooms - 1) * 15;
    extra += (bathrooms - 1) * 15;

// Extras
    if (linenService) extra += 20;
    if (laundry) extra += 25;
    if (restockSupplies) extra += 15;
    if (trashRemoval) extra += 10;

// Pets
    if (hasPets) extra += 40;

    return max + extra;
  }

  @override
  Widget build(BuildContext context) {
    final dates = generateAvailableDates();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.item["title"],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

// ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                widget.item["image"],
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

// TITLE
            const Text(
              "What’s Included",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 12),

            _included("Full Airbnb-ready cleaning"),
            _included("Bedroom & living area refresh"),
            _included("Bathroom disinfection"),
            _included("Kitchen wipe-down"),
            _included("Dusting, floors, trash removal"),

            const SizedBox(height: 20),
            const Divider(),

// 🔥 BEDROOMS / BATHROOMS / PETS
            const SizedBox(height: 20),
            const Text(
              "Home Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 12),

            _counter("Bedrooms", bedrooms, (v) {
              setState(() => bedrooms = v);
            }),

            const SizedBox(height: 10),

            _counter("Bathrooms", bathrooms, (v) {
              setState(() => bathrooms = v);
            }),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Any Pets?",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: hasPets,
                  activeColor: Colors.green,
                  onChanged: (v) => setState(() => hasPets = v),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

// EXTRA SERVICES
            const SizedBox(height: 20),
            const Text(
              "Extra Services",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            _extra("Linen Change", linenService, (v) {
              setState(() => linenService = v);
            }),

            _extra("Laundry Service", laundry, (v) {
              setState(() => laundry = v);
            }),

            _extra("Restock Supplies", restockSupplies, (v) {
              setState(() => restockSupplies = v);
            }),

            _extra("Trash Removal", trashRemoval, (v) {
              setState(() => trashRemoval = v);
            }),

            const SizedBox(height: 20),
            const Divider(),

// DATE
            const SizedBox(height: 20),
            const Text(
              "Select Day",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            DropdownButton<String>(
              value: selectedDate,
              items: dates
                  .map((d) => DropdownMenuItem(
                        value: d,
                        child: Text(d),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedDate = value!);
              },
            ),

            const SizedBox(height: 20),

// TIME
            const Text(
              "Select Time",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            DropdownButton<String>(
              value: selectedTime,
              items: timeSlots
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedTime = value!);
              },
            ),

            const SizedBox(height: 30),
            const Divider(),

// PRICE
            const SizedBox(height: 20),

            Text(
              "\$${minPriceCalc()} - \$${maxPriceCalc()}",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "You only pay the cleaner after the job is completed.\n"
                "Booking fee 9.99 ensures guaranteed arrival.",
                style: TextStyle(fontSize: 15),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

// BUTTON
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Confirm Booking for 9.99",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

// ---------------- HELPERS ----------------

  Widget _included(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 22),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _extra(String text, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Checkbox(
            value: value,
            onChanged: (v) => onChanged(v!),
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _counter(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (value > 1) onChanged(value - 1);
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              "$value",
              style: const TextStyle(fontSize: 17),
            ),
            IconButton(
              onPressed: () {
                onChanged(value + 1);
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ],
    );
  }
}
