import 'package:flutter/material.dart';

class JumpStartBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const JumpStartBookingScreen({super.key, required this.item});

  @override
  State<JumpStartBookingScreen> createState() => _JumpStartBookingScreenState();
}

class _JumpStartBookingScreenState extends State<JumpStartBookingScreen> {
  final Color primary = const Color(0xFF23A373);
  final Color soft = const Color(0xFFEFF7F3);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedCar;
  String? selectedBatteryType;
  String? selectedIssue;
  String? selectedTime;

  final List<String> carTypes = [
    "Sedan",
    "SUV",
    "Pickup Truck",
    "Minivan",
    "Sports Car",
  ];

  final List<String> batteryTypes = [
    "Standard 12V Battery",
    "AGM Battery",
    "Start-Stop Battery",
    "Truck/SUV Heavy Duty",
    "Not Sure",
  ];

  final List<String> issues = [
    "Car won’t start",
    "Weak battery",
    "Cold weather issue",
    "Lights left on",
    "Battery dead overnight",
    "Not sure — diagnose",
  ];

  final List<String> timeSlots = [
    "ASAP (30–60 min)",
    "In 1 hour",
    "Schedule for today",
    "Schedule for tomorrow",
  ];

  late List<String> nextThreeDays;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    nextThreeDays = List.generate(3, (i) {
      final d = now.add(Duration(days: i));
      return "${d.month}/${d.day}/${d.year}";
    });
  }

  Widget dropDown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: soft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            hint: const Text("Select"),
            value: value,
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          item["title"],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PRICE RANGE
            Text(
              "\$${item["minPrice"]} - \$${item["maxPrice"]}",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            /// CAR TYPE
            dropDown(
              label: "Car Type",
              value: selectedCar,
              items: carTypes,
              onChanged: (v) => setState(() => selectedCar = v),
            ),

            /// BATTERY TYPE
            dropDown(
              label: "Battery Type",
              value: selectedBatteryType,
              items: batteryTypes,
              onChanged: (v) => setState(() => selectedBatteryType = v),
            ),

            /// ISSUE TYPE
            dropDown(
              label: "Problem Type",
              value: selectedIssue,
              items: issues,
              onChanged: (v) => setState(() => selectedIssue = v),
            ),

            /// TIME
            dropDown(
              label: "When do you need help?",
              value: selectedTime,
              items: timeSlots,
              onChanged: (v) => setState(() => selectedTime = v),
            ),

            /// DATE (only if scheduled)
            if (selectedTime != null &&
                selectedTime != "ASAP (30–60 min)" &&
                selectedTime != "In 1 hour")
              dropDown(
                label: "Select Date",
                value: nextThreeDays.first,
                items: nextThreeDays,
                onChanged: (v) {},
              ),

            const SizedBox(height: 10),

            /// ADDRESS
            const Text("Service Location",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            TextField(
              controller: addressCtrl,
              decoration: InputDecoration(
                hintText: "Parking lot, home driveway, roadside…",
                filled: true,
                fillColor: soft,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// NOTES
            const Text(
              "Additional Notes",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Optional (battery age, hazards on, etc.)",
                filled: true,
                fillColor: soft,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// WHAT'S INCLUDED
            const Text(
              "What's Included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),
            const Text("✔️ Technician arrival within 30–60 min"),
            const Text("✔️ Battery jump start / boost"),
            const Text("✔️ Full inspection of terminals & cables"),
            const Text("✔️ Charging system test"),
            const Text("✔️ Secure \$9.99 booking fee"),

            const SizedBox(height: 35),

            /// BOOK BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCar == null ||
                      selectedBatteryType == null ||
                      selectedIssue == null ||
                      selectedTime == null ||
                      addressCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all required fields"),
                      ),
                    );
                    return;
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Request Jump Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
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
