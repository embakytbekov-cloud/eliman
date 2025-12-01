import 'package:flutter/material.dart';

class CarpetCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const CarpetCleaningBookingScreen({super.key, required this.item});

  @override
  State<CarpetCleaningBookingScreen> createState() =>
      _CarpetCleaningBookingScreenState();
}

class _CarpetCleaningBookingScreenState
    extends State<CarpetCleaningBookingScreen> {
  String? selectedServiceType;
  String? selectedDay;
  String? selectedTime;

  /// ---- Генерируем 3 дня ----
  List<String> getNextThreeDays() {
    final now = DateTime.now();
    return List.generate(3, (i) {
      final d = now.add(Duration(days: i + 1));
      return "${d.month}/${d.day}/${d.year}";
    });
  }

  /// ---- Время ----
  final List<String> timeSlots = [
    "9 AM - 12 PM",
    "12 PM - 6 PM",
    "9 AM - 6 PM",
    "6 PM - 9 PM",
  ];

  /// ---- Типы ковровых услуг ----
  final Map<String, Map<String, int>> carpetPriceOptions = {
    "1 Room Carpet Cleaning": {"min": 50, "max": 90},
    "2 Rooms Carpet Cleaning": {"min": 90, "max": 150},
    "3 Rooms Carpet Cleaning": {"min": 140, "max": 210},
    "Whole Apartment Carpet": {"min": 200, "max": 350},
  };

  @override
  Widget build(BuildContext context) {
    final days = getNextThreeDays();

    final price = selectedServiceType != null
        ? carpetPriceOptions[selectedServiceType]!
        : {
            "min": widget.item["minPrice"],
            "max": widget.item["maxPrice"],
          };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Carpet Cleaning",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---- IMAGE ----
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                widget.item["image"],
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 22),

            /// ---- SELECT TYPE ----
            const Text(
              "Select Carpet Service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedServiceType,
                  isExpanded: true,
                  hint: const Text("Choose service"),
                  items: carpetPriceOptions.keys.map((service) {
                    return DropdownMenuItem(
                      value: service,
                      child: Text(service),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedServiceType = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// ---- DAY ----
            const Text(
              "Select Day",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDay,
                  isExpanded: true,
                  hint: const Text("Choose day"),
                  items: days.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDay = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// ---- TIME ----
            const Text(
              "Select Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedTime,
                  isExpanded: true,
                  hint: const Text("Choose time"),
                  items: timeSlots.map((slot) {
                    return DropdownMenuItem(
                      value: slot,
                      child: Text(slot),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTime = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// ---- PRICE ----
            Text(
              "\$${price['min']} - \$${price['max']}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 25),

            /// ---- QUALITY INFO ----
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Our professional carpet cleaners provide:\n"
                "• Steam extraction (industry standard)\n"
                "• Deep stain and spot removal\n"
                "• Pet odor elimination\n"
                "• Anti-allergen treatment\n"
                "• Pre-spray + hot water extraction\n"
                "• Fast drying with industrial air movers\n\n"
                "You pay only after the job is completed.\n"
                "Booking fee \$9.99 ensures guaranteed arrival.",
                style: TextStyle(fontSize: 15),
              ),
            ),

            const SizedBox(height: 30),

            /// ---- CONFIRM BUTTON ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedServiceType == null ||
                      selectedDay == null ||
                      selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select all fields"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

// Later: Telegram send
                },
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

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
