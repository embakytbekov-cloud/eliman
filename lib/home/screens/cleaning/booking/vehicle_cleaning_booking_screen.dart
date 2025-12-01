import 'package:flutter/material.dart';

class VehicleCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const VehicleCleaningBookingScreen({super.key, required this.item});

  @override
  State<VehicleCleaningBookingScreen> createState() =>
      _VehicleCleaningBookingScreenState();
}

class _VehicleCleaningBookingScreenState
    extends State<VehicleCleaningBookingScreen> {
  String? selectedType;
  String? selectedDay;
  String? selectedTime;

  /// ---- ДНИ: 3 дня ----
  List<String> getNextThreeDays() {
    final now = DateTime.now();
    return List.generate(3, (i) {
      final d = now.add(Duration(days: i + 1));
      return "${d.month}/${d.day}/${d.year}";
    });
  }

  /// ---- ВРЕМЯ ----
  final List<String> timeSlots = [
    "9 AM - 12 PM",
    "12 PM - 6 PM",
    "9 AM - 6 PM",
    "6 PM - 9 PM",
  ];

  /// ---- ЦЕНЫ ПО ТИПАМ ----
  Map<String, dynamic> getPriceForType(String? type) {
    switch (type) {
      case "Car Standard Cleaning":
        return {"min": 120, "max": 140};

      case "Car Deep Cleaning":
        return {"min": 300, "max": 500};

      case "Truck Standard Cleaning":
        return {"min": 160, "max": 250};

      case "Truck Deep Cleaning":
        return {"min": 400, "max": 700};

      default:
        return {"min": widget.item["minPrice"], "max": widget.item["maxPrice"]};
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> threeDays = getNextThreeDays();
    final prices = getPriceForType(selectedType);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Vehicle Cleaning Booking",
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
              "Select Service Type",
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
                  value: selectedType,
                  isExpanded: true,
                  hint: const Text("Choose type"),
                  items: [
                    "Car Standard Cleaning",
                    "Car Deep Cleaning",
                    "Truck Standard Cleaning",
                    "Truck Deep Cleaning",
                  ].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
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
                  items: threeDays.map((day) {
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
                  items: timeSlots.map((time) {
                    return DropdownMenuItem(
                      value: time,
                      child: Text(time),
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
              "\$${prices['min']} - \$${prices['max']}",
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
                "Our technicians provide premium interior cleaning:\n"
                "• Professional vacuum + steam cleaning\n"
                "• Deep stain removal\n"
                "• Leather & fabric restoration\n"
                "• Pressure air cleaning of vents\n"
                "• Disinfection & odor removal\n\n"
                "You only pay after the job is completed.\n"
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
                  if (selectedType == null ||
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

// later: send to Telegram
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
