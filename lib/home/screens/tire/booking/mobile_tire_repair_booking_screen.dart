import 'package:flutter/material.dart';

class MobileTireRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const MobileTireRepairBookingScreen({super.key, required this.item});

  @override
  State<MobileTireRepairBookingScreen> createState() =>
      _MobileTireRepairBookingScreenState();
}

class _MobileTireRepairBookingScreenState
    extends State<MobileTireRepairBookingScreen> {
  final Color primary = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedTime;

  final List<String> times = [
    "ASAP",
    "Morning",
    "Afternoon",
    "Evening",
  ];

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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
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

            /// ADDRESS
            const Text(
              "Where is your car located?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: addressCtrl,
              decoration: InputDecoration(
                hintText: "Address, parking lot, garage...",
                filled: true,
                fillColor: const Color(0xFFF4F6F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// TIME OPTIONS
            const Text(
              "Preferred Time",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: times.map((t) {
                return ChoiceChip(
                  label: Text(t),
                  selected: selectedTime == t,
                  selectedColor: primary.withOpacity(0.15),
                  onSelected: (_) {
                    setState(() => selectedTime = t);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// NOTES
            const Text(
              "Notes (optional)",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Describe the problem (if you know)...",
                filled: true,
                fillColor: const Color(0xFFF4F6F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (addressCtrl.text.trim().isEmpty || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill address and time"),
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
                  "Book Now",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
