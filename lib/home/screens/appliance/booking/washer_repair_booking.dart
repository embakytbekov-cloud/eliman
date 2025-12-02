import 'package:flutter/material.dart';

class WasherRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const WasherRepairBookingScreen({super.key, required this.item});

  @override
  State<WasherRepairBookingScreen> createState() =>
      _WasherRepairBookingScreenState();
}

class _WasherRepairBookingScreenState extends State<WasherRepairBookingScreen> {
  final Color wibiGreen = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? problemType;
  String? brand;
  String? selectedDay;
  String? selectedTime;

  final List<String> problems = [
    "Washer not spinning",
    "Washer not draining",
    "Leaking water",
    "Making noise",
    "Not turning on",
    "Other",
  ];

  final List<String> brands = [
    "LG",
    "Samsung",
    "Whirlpool",
    "GE",
    "Bosch",
    "Maytag",
    "Other",
  ];

  late List<String> next3days;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    next3days = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Washer Issue"),
            _chipSelect(
              list: problems,
              value: problemType,
              onSelect: (v) => setState(() => problemType = v),
            ),
            const SizedBox(height: 25),
            _title("Washer Brand"),
            _chipSelect(
              list: brands,
              value: brand,
              onSelect: (v) => setState(() => brand = v),
            ),
            const SizedBox(height: 25),
            _title("Select Day"),
            _chipSelect(
              list: next3days,
              value: selectedDay,
              onSelect: (v) => setState(() => selectedDay = v),
            ),
            const SizedBox(height: 25),
            _title("Select Time"),
            _chipSelect(
              list: timeSlots,
              value: selectedTime,
              onSelect: (v) => setState(() => selectedTime = v),
            ),
            const SizedBox(height: 25),
            _title("Additional Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Optional notes…",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _infoBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // UI COMPONENTS -------------------------------------------------

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      title: Text(
        widget.item["title"],
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          t,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      );

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _chipSelect({
    required List<String> list,
    required String? value,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: list.map((e) {
        final selected = value == e;
        return GestureDetector(
          onTap: () => onSelect(e),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? wibiGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              e,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _infoBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$90 – \$180\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and "
        "begins the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.4),
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
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
