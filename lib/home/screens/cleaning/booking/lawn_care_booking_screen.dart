import 'package:flutter/material.dart';

class LawnCareBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const LawnCareBookingScreen({super.key, required this.item});

  @override
  State<LawnCareBookingScreen> createState() => _LawnCareBookingScreenState();
}

class _LawnCareBookingScreenState extends State<LawnCareBookingScreen> {
  // COLORS WIBI STYLE
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color buttonGreen = const Color(0xFF25D366);
  final Color softGreen = const Color(0xFFDFF3E8);

  // ADDRESS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // SELECTED VALUES
  String? lawnSize;
  String? grassHeight;
  String? yardArea;
  List<String> selectedExtras = [];

  // DATE / TIME
  String? selectedDate;
  String? selectedTime;

  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  // OPTIONS
  final List<String> lawnSizes = [
    "Small (0–4,000 sqft)",
    "Medium (4,000–8,000 sqft)",
    "Large (8,000–15,000 sqft)",
    "Extra Large (15,000+ sqft)",
  ];

  final List<String> grassHeights = [
    "Short (maintained)",
    "Medium",
    "Overgrown",
    "Heavily Overgrown",
  ];

  final List<String> yardAreas = [
    "Front Yard",
    "Back Yard",
    "Both",
  ];

  final List<String> extras = [
    "Edging",
    "Bush Trimming",
    "Weed Removal",
    "Leaf Cleanup",
    "Bagging Grass",
    "Mulch Refresh",
    "Debris Hauling",
    "Flower Bed Cleaning",
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
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Lawn Care",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _textCard(addressCtrl, "Enter your address"),
            const SizedBox(height: 25),
            _title("Lawn Size"),
            _chips(lawnSizes, lawnSize, (v) => setState(() => lawnSize = v)),
            const SizedBox(height: 25),
            _title("Grass Height"),
            _chips(grassHeights, grassHeight,
                (v) => setState(() => grassHeight = v)),
            const SizedBox(height: 25),
            _title("Area to Clean"),
            _chips(yardAreas, yardArea, (v) => setState(() => yardArea = v)),
            const SizedBox(height: 25),
            _title("Extra Tasks"),
            _multiSelectChips(),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateChips(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeChips(),
            const SizedBox(height: 25),
            _title("Notes (optional)"),
            _textCard(notesCtrl, "Anything we should know?"),
            const SizedBox(height: 30),
            _estimatedPrice(),
            const SizedBox(height: 30),
            const SizedBox(height: 40),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // TITLE
  Widget _title(String t) => Text(
        t,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
        ),
      );

  // TEXT CARD
  Widget _textCard(TextEditingController c, String hint) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: TextField(
        controller: c,
        maxLines: 2,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  // SINGLE SELECT CHIPS
  Widget _chips(List<String> items, String? selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((v) {
        final bool isSelected = selected == v;
        return GestureDetector(
          onTap: () => onTap(v),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              v,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 14),
            ),
          ),
        );
      }).toList(),
    );
  }

  // MULTI SELECT CHIPS
  Widget _multiSelectChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: extras.map((task) {
        final bool selected = selectedExtras.contains(task);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selected) {
                selectedExtras.remove(task);
              } else {
                selectedExtras.add(task);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              task,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // DATE
  Widget _dateChips() {
    return Wrap(
      spacing: 10,
      children: nextThreeDays.map((d) {
        final bool selected = selectedDate == d;
        return ChoiceChip(
          selected: selected,
          selectedColor: darkGreen,
          backgroundColor: Colors.grey.shade200,
          label: Text(
            d,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
          onSelected: (_) => setState(() => selectedDate = d),
        );
      }).toList(),
    );
  }

  // TIME
  Widget _timeChips() {
    return Wrap(
      spacing: 10,
      children: timeSlots.map((slot) {
        final bool selected = selectedTime == slot;
        return GestureDetector(
          onTap: () => setState(() => selectedTime = slot),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              slot,
              style: TextStyle(color: selected ? Colors.white : Colors.black87),
            ),
          ),
        );
      }).toList(),
    );
  }

  // PRICE BLOCK
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$65 – \$150\n"
        "You'll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins "
        "the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.35),
      ),
    );
  }

  // CONFIRM BUTTON
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
