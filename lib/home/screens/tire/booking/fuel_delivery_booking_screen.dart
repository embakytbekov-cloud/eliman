import 'package:flutter/material.dart';

class FuelDeliveryBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const FuelDeliveryBookingScreen({super.key, required this.item});

  @override
  State<FuelDeliveryBookingScreen> createState() =>
      _FuelDeliveryBookingScreenState();
}

class _FuelDeliveryBookingScreenState extends State<FuelDeliveryBookingScreen> {
  final Color primary = const Color(0xFF23A373);
  final Color soft = const Color(0xFFEFF7F3);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedCar;
  String? selectedFuelType;
  String? selectedAmount;
  String? selectedTime;

  final List<String> carTypes = [
    "Sedan",
    "SUV",
    "Pickup Truck",
    "Minivan",
    "Sports Car",
  ];

  final List<String> fuelTypes = [
    "Regular Gas (87)",
    "Midgrade Gas (89)",
    "Premium Gas (91/93)",
    "Diesel",
  ];

  final List<String> amounts = [
    "1 Gallon",
    "2 Gallons",
    "3 Gallons",
    "5 Gallons",
    "Full Tank (as needed)",
  ];

  final List<String> timeSlots = [
    "ASAP (30-60 min)",
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
            // PRICE RANGE
            Text(
              "\$${item["minPrice"]} - \$${item["maxPrice"]}",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
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

            /// FUEL TYPE
            dropDown(
              label: "Fuel Type",
              value: selectedFuelType,
              items: fuelTypes,
              onChanged: (v) => setState(() => selectedFuelType = v),
            ),

            /// AMOUNT
            dropDown(
              label: "Amount Needed",
              value: selectedAmount,
              items: amounts,
              onChanged: (v) => setState(() => selectedAmount = v),
            ),

            /// TIME
            dropDown(
              label: "When do you need fuel?",
              value: selectedTime,
              items: timeSlots,
              onChanged: (v) => setState(() => selectedTime = v),
            ),

            /// DATE (only for scheduled)
            if (selectedTime != null &&
                selectedTime != "ASAP (30-60 min)" &&
                selectedTime != "In 1 hour")
              dropDown(
                label: "Select Date",
                value: nextThreeDays.first,
                items: nextThreeDays,
                onChanged: (v) {},
              ),

            /// ADDRESS
            const Text("Location (Where your car is parked)",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: addressCtrl,
              decoration: InputDecoration(
                hintText: "Street, house, parking lot, highway…",
                filled: true,
                fillColor: soft,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// NOTES
            const Text("Additional Notes (Optional)",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Example: I’m on the right side, hazards on",
                filled: true,
                fillColor: soft,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// INCLUDED
            const Text(
              "What's Included",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 10),
            const Text("✔️ Fuel delivery directly to your car"),
            const Text("✔️ Technician arrives within 30–60 min"),
            const Text("✔️ Up to 5 gallons delivery"),
            const Text("✔️ Safety check & priming if needed"),
            const Text("✔️ Secure \$9.99 booking fee"),

            const SizedBox(height: 35),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCar == null ||
                      selectedFuelType == null ||
                      selectedAmount == null ||
                      selectedTime == null ||
                      addressCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please fill all required fields")),
                    );
                    return;
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Order Fuel Delivery",
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
