import 'package:flutter/material.dart';

class TireChangeAtHomeBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const TireChangeAtHomeBookingScreen({super.key, required this.item});

  @override
  State<TireChangeAtHomeBookingScreen> createState() =>
      _TireChangeAtHomeBookingScreenState();
}

class _TireChangeAtHomeBookingScreenState
    extends State<TireChangeAtHomeBookingScreen> {
  final Color primary = const Color(0xFF23A373);
  final Color soft = const Color(0xFFEFF7F3);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedCar;
  String? selectedTireSize;
  String? selectedServiceType;
  String? selectedDate;
  String? selectedTime;

  final List<String> carTypes = [
    "Sedan",
    "SUV",
    "Pickup Truck",
    "Minivan",
    "Coupe",
  ];

  final List<String> tireSizes = [
    "16 inch",
    "17 inch",
    "18 inch",
    "19 inch",
    "20 inch",
    "21 inch",
  ];

  final List<String> serviceTypes = [
    "Replace with your spare tire",
    "Replace with technician-supplied tire",
    "Tire swap from storage",
    "Seasonal change (Winter/Summer)",
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
            value: value,
            hint: const Text("Select"),
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
            /// PRICE
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

            /// TIRE SIZE
            dropDown(
              label: "Tire Size",
              value: selectedTireSize,
              items: tireSizes,
              onChanged: (v) => setState(() => selectedTireSize = v),
            ),

            /// SERVICE TYPE
            dropDown(
              label: "Type of Tire Change",
              value: selectedServiceType,
              items: serviceTypes,
              onChanged: (v) => setState(() => selectedServiceType = v),
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
              "Service Address (Where your car is)",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: addressCtrl,
              decoration: InputDecoration(
                hintText: "Home address, parking lot, or driveway",
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

            /// INCLUDED
            const Text(
              "What's Included",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),
            const Text("✔️ Mobile tire technician arrives to your home"),
            const Text("✔️ Full tire removal & installation"),
            const Text("✔️ Torque check on all lug nuts"),
            const Text("✔️ Tire pressure check"),
            const Text("✔️ Same-day availability"),
            const Text("✔️ Secure \$9.99 booking fee"),

            const SizedBox(height: 35),

            /// BOOK BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCar == null ||
                      selectedTireSize == null ||
                      selectedServiceType == null ||
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
                  "Confirm Tire Change",
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
