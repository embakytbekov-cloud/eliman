import 'package:flutter/material.dart';

class MicrowaveRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const MicrowaveRepairBookingScreen({super.key, required this.item});

  @override
  State<MicrowaveRepairBookingScreen> createState() =>
      _MicrowaveRepairBookingScreenState();
}

class _MicrowaveRepairBookingScreenState
    extends State<MicrowaveRepairBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // SELECTORS
  String? problemType;
  String? microwaveType;
  String? selectedDay;
  String? selectedTime;

  final List<String> microwaveTypes = [
    "Countertop",
    "Built-in",
    "Over-the-Range",
    "Drawer Style",
  ];

  final List<String> problemTypes = [
    "Not heating",
    "Turns on but no heat",
    "Plate not spinning",
    "Buttons not working",
    "No power",
    "Burning smell",
    "Makes loud noise",
    "Other issue",
  ];

  final List<String> nextThreeDays = [];
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    nextThreeDays.add("${now.month}/${now.day}/${now.year}");
    nextThreeDays.add(
        "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}");
    nextThreeDays.add(
        "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Microwave Repair",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _inputCard(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Microwave Type"),
            Wrap(
              spacing: 10,
              children: microwaveTypes.map((t) {
                final selected = microwaveType == t;
                return ChoiceChip(
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  label: Text(
                    t,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                  ),
                  onSelected: (_) => setState(() => microwaveType = t),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            _title("Problem Type"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: problemTypes.map((p) {
                final selected = problemType == p;
                return ChoiceChip(
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  label: Text(
                    p,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                  ),
                  onSelected: (_) => setState(() => problemType = p),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            _title("Select Day"),
            Wrap(
              spacing: 10,
              children: nextThreeDays.map((d) {
                final selected = selectedDay == d;
                return ChoiceChip(
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  label: Text(
                    d,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                  ),
                  onSelected: (_) => setState(() => selectedDay = d),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            _title("Select Time"),
            Wrap(
              spacing: 10,
              children: timeSlots.map((t) {
                final selected = selectedTime == t;
                return ChoiceChip(
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  label: Text(
                    t,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                  ),
                  onSelected: (_) => setState(() => selectedTime = t),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            _title("Extra Notes"),
            _inputCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any additional details...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // Titles
  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          t,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      );

  // White card
  Widget _inputCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  // Trust block
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$70 – \$150\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available technician.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.35),
      ),
    );
  }

  // Confirm button
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25D366), // WhatsApp green
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: () {},
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
