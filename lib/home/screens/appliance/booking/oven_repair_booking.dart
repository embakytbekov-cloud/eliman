import 'package:flutter/material.dart';

class OvenRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const OvenRepairBookingScreen({super.key, required this.item});

  @override
  State<OvenRepairBookingScreen> createState() =>
      _OvenRepairBookingScreenState();
}

class _OvenRepairBookingScreenState extends State<OvenRepairBookingScreen> {
  final Color green = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // 🔧 SELECTORS
  String? ovenType;
  String? issueType;
  String? selectedDay;
  String? selectedTime;

  final List<String> ovenTypes = [
    "Gas Oven",
    "Electric Oven",
    "Wall Oven",
    "Double Oven",
    "Stove + Oven Combo",
  ];

  final List<String> issues = [
    "Not heating",
    "Uneven temperature",
    "Igniter not working",
    "Door won’t close",
    "Strange noise",
    "Other issue",
  ];

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  late List<String> nextThreeDays;

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
          widget.item["title"] ?? "Oven Repair",
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
            _title("Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter service address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _title("Oven Type"),
            _chips(ovenTypes, ovenType, (v) => setState(() => ovenType = v)),
            const SizedBox(height: 20),
            _title("Issue"),
            _chips(issues, issueType, (v) => setState(() => issueType = v)),
            const SizedBox(height: 20),
            _title("Select Day"),
            _chips(nextThreeDays, selectedDay,
                (v) => setState(() => selectedDay = v)),
            const SizedBox(height: 20),
            _title("Select Time"),
            _chips(timeSlots, selectedTime,
                (v) => setState(() => selectedTime = v)),
            const SizedBox(height: 25),
            _title("Extra Notes (optional)"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Describe the issue…",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _trustBox(),
            const SizedBox(height: 30),
            _confirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _title(String t) {
    return Text(
      t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _chips(List<String> items, String? selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((e) {
        final bool active = selected == e;
        return GestureDetector(
          onTap: () => onTap(e),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: active ? const Color(0xFF23A373) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              e,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _trustBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$XX – \$XX\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and starts searching for the best available professional.\n\n"
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
          backgroundColor: const Color(0xFF25D366),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
