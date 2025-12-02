import 'package:flutter/material.dart';

class IceMakerRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const IceMakerRepairBookingScreen({super.key, required this.item});

  @override
  State<IceMakerRepairBookingScreen> createState() =>
      _IceMakerRepairBookingScreenState();
}

class _IceMakerRepairBookingScreenState
    extends State<IceMakerRepairBookingScreen> {
  final Color wibiGreen = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // DATE
  String? selectedDate;
  late List<String> nextThreeDays;

  // TIME
  String? selectedTime;
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
  ];

  // ISSUE TYPE
  String? issueType;

  final List<String> issueOptions = [
    "Not Making Ice",
    "Slow Ice Production",
    "Leaking Water",
    "Ice Taste/Smell Issue",
    "Ice Jammed",
    "Freezer Too Warm",
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    nextThreeDays = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
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
            // ADDRESS
            _title("Service Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter address",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ISSUE TYPE
            _title("Select Issue"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: issueOptions.map((e) {
                final selected = issueType == e;
                return ChoiceChip(
                  label: Text(e),
                  selectedColor: wibiGreen,
                  selected: selected,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => issueType = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

            // DATE
            _title("Select Date"),
            Wrap(
              spacing: 10,
              children: nextThreeDays.map((d) {
                final selected = selectedDate == d;
                return ChoiceChip(
                  label: Text(d),
                  selected: selected,
                  selectedColor: wibiGreen,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => selectedDate = d),
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

            // TIME
            _title("Select Time"),
            Wrap(
              spacing: 10,
              children: timeSlots.map((slot) {
                final selected = selectedTime == slot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: selected,
                  selectedColor: wibiGreen,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => selectedTime = slot),
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

            // NOTES
            _title("Additional Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Describe any details...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // TRUST TEXT
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFDFF3E8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                "Estimated Price: \$85 – \$180\n\n"
                "You’ll never be charged until the job is completed.\n"
                "The \$9.99 booking fee simply reserves your time slot and begins "
                "the search for the best available technician.\n\n"
                "We’ll notify you as soon as a specialist accepts your request.",
                style: TextStyle(fontSize: 15, height: 1.45),
              ),
            ),

            const SizedBox(height: 30),

            // CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: wibiGreen,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Confirm Booking — \$9.99",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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

  // ---------------- HELPERS ----------------

  Widget _title(String t) {
    return Text(
      t,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: child,
    );
  }
}
