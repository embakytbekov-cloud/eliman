import 'package:flutter/material.dart';

class HouseLockoutBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const HouseLockoutBookingScreen({super.key, required this.item});

  @override
  State<HouseLockoutBookingScreen> createState() =>
      _HouseLockoutBookingScreenState();
}

class _HouseLockoutBookingScreenState extends State<HouseLockoutBookingScreen> {
  final Color wibiGreen = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();

  String? selectedUrgency;

  final List<String> urgencyOptions = [
    "Emergency — ASAP",
    "Within 1 hour",
    "Within 2–3 hours",
    "Schedule for later today",
  ];

  String? selectedDoorType;

  final List<String> doorTypes = [
    "Standard lock",
    "Deadbolt",
    "Smart lock",
    "High-security lock",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "House Lockout",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Your Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter service address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 22),
            _title("Urgency"),
            Wrap(
              spacing: 10,
              children: urgencyOptions.map((e) {
                final selected = selectedUrgency == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: wibiGreen,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => selectedUrgency = e),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            _title("Door Type"),
            Wrap(
              spacing: 10,
              children: doorTypes.map((e) {
                final selected = selectedDoorType == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: wibiGreen,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => selectedDoorType = e),
                );
              }).toList(),
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

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.06),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$75 – \$150\n\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee reserves your time slot and immediately dispatches the closest available locksmith.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: wibiGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
