import 'package:flutter/material.dart';

class TireRotationBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const TireRotationBookingScreen({super.key, required this.item});

  @override
  State<TireRotationBookingScreen> createState() =>
      _TireRotationBookingScreenState();
}

class _TireRotationBookingScreenState extends State<TireRotationBookingScreen> {
  final Color primary = const Color(0xFF23A373);
  final Color soft = const Color(0xFFEFF7F3);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedCar;
  String? selectedRotationType;
  String? selectedDate;
  String? selectedTime;

  final List<String> carTypes = [
    "Sedan",
    "SUV",
    "Pickup Truck",
    "Minivan",
    "Coupe",
  ];

  final List<String> rotationTypes = [
    "Standard 4-tire rotation",
    "Front-to-back rotation",
    "Cross-pattern rotation",
    "Include spare (if possible)",
  ];

  final List<String> timeSlots = [
    "8:00 AM",
    "10:00 AM",
    "12:00 PM",
    "2:00 PM",
    "4:00 PM",
    "6:00 PM",
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

  // REUSABLE DROPDOWN
  Widget dropDown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
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
            value: value,
            hint: const Text("Select"),
            items: items
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
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
          item["title"] ?? "Tire Rotation",
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
            // PRICE
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

            /// ROTATION TYPE
            dropDown(
              label: "Rotation Type",
              value: selectedRotationType,
              items: rotationTypes,
              onChanged: (v) => setState(() => selectedRotationType = v),
            ),

            /// DATE
            dropDown(
              label: "Select Date",
              value: selectedDate,
              items: nextThreeDays,
              onChanged: (v) => setState(() => selectedDate = v),
            ),

            /// TIME
            dropDown(
              label: "Time Slot",
              value: selectedTime,
              items: timeSlots,
              onChanged: (v) => setState(() => selectedTime = v),
            ),

            /// ADDRESS
            const Text(
              "Service Address",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: addressCtrl,
              decoration: InputDecoration(
                hintText: "Enter address",
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
                hintText: "Optional",
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

            const Text("✔️ Full tire rotation service"),
            const Text("✔️ Tire wear check & tread depth"),
            const Text("✔️ Torque check on all lug nuts"),
            const Text("✔️ Recommended rotation pattern"),
            const Text("✔️ \$9.99 secure booking fee"),

            const SizedBox(height: 35),

            /// BOOK NOW BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCar == null ||
                      selectedRotationType == null ||
                      selectedDate == null ||
                      selectedTime == null ||
                      addressCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all required fields"),
                      ),
                    );
                    return;
                  }

                  // Здесь позже можно добавить отправку в backend / Supabase
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
                  "Confirm Booking",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
