import 'package:flutter/material.dart';

class PostConstructionBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const PostConstructionBookingScreen({super.key, required this.item});

  @override
  State<PostConstructionBookingScreen> createState() =>
      _PostConstructionBookingScreenState();
}

class _PostConstructionBookingScreenState
    extends State<PostConstructionBookingScreen> {
  String? selectedLevel;
  String? selectedDay;
  String? selectedTime;

  /// ---- 3 DAY PICKER ----
  List<String> getNextThreeDays() {
    final now = DateTime.now();
    return List.generate(3, (i) {
      final date = now.add(Duration(days: i + 1));
      return "${date.month}/${date.day}/${date.year}";
    });
  }

  /// ---- TIME SLOTS ----
  final List<String> timeSlots = [
    "9 AM - 12 PM",
    "12 PM - 6 PM",
    "9 AM - 6 PM",
    "6 PM - 9 PM",
  ];

  /// ---- SERVICE LEVELS ----
  final Map<String, Map<String, int>> levels = {
    "Light Post-Construction": {"min": 200, "max": 260},
    "Medium Post-Construction": {"min": 260, "max": 340},
    "Heavy Post-Construction": {"min": 340, "max": 430},
    "Full Deep Construction Cleanup": {"min": 430, "max": 600},
  };

  @override
  Widget build(BuildContext context) {
    final days = getNextThreeDays();

    final price = selectedLevel != null
        ? levels[selectedLevel]!
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
          "Post-Construction Cleaning",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
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

            /// SELECT LEVEL
            const Text(
              "Select Cleanup Level",
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
                  value: selectedLevel,
                  isExpanded: true,
                  hint: const Text("Choose level"),
                  items: levels.keys.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// SELECT DAY
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

            /// SELECT TIME
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

            /// PRICE
            Text(
              "\$${price["min"]} - \$${price["max"]}",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),

            const SizedBox(height: 25),

            /// QUALITY DESCRIPTION
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Our post-construction cleaning includes:\n"
                "• Heavy dust removal (walls, baseboards, vents)\n"
                "• Vacuuming & detailed floor cleaning\n"
                "• Sticker, glue, and paint splatter removal\n"
                "• Window & glass cleaning + track detailing\n"
                "• Cabinet, closet, and drawer cleaning\n"
                "• Bathroom & kitchen deep sanitation\n"
                "• Professional contractor-grade equipment\n\n"
                "You pay only after the work is completed.\n"
                "Booking fee \$9.99 guarantees worker arrival.",
                style: TextStyle(fontSize: 15),
              ),
            ),

            const SizedBox(height: 30),

            /// CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedLevel == null ||
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

// Later — send to Telegram
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
                      color: Colors.white),
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
