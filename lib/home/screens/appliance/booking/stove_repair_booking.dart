import 'package:flutter/material.dart';

class StoveRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const StoveRepairBookingScreen({super.key, required this.item});

  @override
  State<StoveRepairBookingScreen> createState() =>
      _StoveRepairBookingScreenState();
}

class _StoveRepairBookingScreenState extends State<StoveRepairBookingScreen> {
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
    "6 PM – 9 PM",
  ];

  // PROBLEM TAGS
  final List<String> symptoms = [
    "Not heating",
    "Gas smell",
    "Igniter not working",
    "Burner clicking",
    "Uneven cooking",
    "Turns off randomly",
    "Electric issue",
    "Knob broken",
  ];

  List<String> selectedSymptoms = [];

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
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
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
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 22),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 22),
            _title("What seems to be the issue?"),
            _symptomTags(),
            const SizedBox(height: 22),
            _title("Extra Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: "Add any additional details...",
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 28),
            _estimatedPrice(),
            const SizedBox(height: 26),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // TITLE
  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  // DATE
  Widget _dateSelector() {
    return _card(
      child: Wrap(
        spacing: 10,
        children: nextThreeDays.map((day) {
          final isSelected = selectedDate == day;
          return ChoiceChip(
            label: Text(
              day,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
            selected: isSelected,
            selectedColor: wibiGreen,
            backgroundColor: Colors.grey.shade200,
            onSelected: (_) => setState(() => selectedDate = day),
          );
        }).toList(),
      ),
    );
  }

  // TIME
  Widget _timeSelector() {
    return _card(
      child: Wrap(
        spacing: 10,
        children: timeSlots.map((slot) {
          final isSelected = slot == selectedTime;
          return ChoiceChip(
            label: Text(
              slot,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
            selected: isSelected,
            selectedColor: wibiGreen,
            backgroundColor: Colors.grey.shade200,
            onSelected: (_) => setState(() => selectedTime = slot),
          );
        }).toList(),
      ),
    );
  }

  // AIRBNB TAG CHIPS
  Widget _symptomTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: symptoms.map((s) {
        final selected = selectedSymptoms.contains(s);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selected) {
                selectedSymptoms.remove(s);
              } else {
                selectedSymptoms.add(s);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? wibiGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              s,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ESTIMATED PRICE
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$${widget.item["minPrice"]} – \$${widget.item["maxPrice"]}",
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
    );
  }

  // TRUST BLOCK
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  // CONFIRM BUTTON
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

  // CARD
  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
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
