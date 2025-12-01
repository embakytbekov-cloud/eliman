import 'package:flutter/material.dart';

class BabyProofingBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const BabyProofingBookingScreen({super.key, required this.item});

  @override
  State<BabyProofingBookingScreen> createState() =>
      _BabyProofingBookingScreenState();
}

class _BabyProofingBookingScreenState extends State<BabyProofingBookingScreen> {
  final Color accent = const Color(0xFF2B6E4F); // dark green
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp green
  final Color softGreen = const Color(0xFFDFF3E8); // block BG

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // STEP COUNTERS
  int rooms = 1;

  // CHIPS
  List<String> selectedOptions = [];

  final List<String> options = [
    "Cabinet locks",
    "Outlet covers",
    "Furniture anchoring",
    "Baby gates",
    "Door stoppers",
    "Window locks",
  ];

  // TIME / DATE
  String? selectedDate;
  String? selectedTime;

  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM"
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
            _title("Address"),
            _address(),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("How many rooms?"),
            _stepper("Rooms", rooms, (v) => setState(() => rooms = v)),
            const SizedBox(height: 25),
            _title("Choose Baby Proofing Tasks"),
            _chipSelector(),
            const SizedBox(height: 25),
            _title("Notes (optional)"),
            _notes(),
            const SizedBox(height: 28),
            _estimatedPrice(),
            const SizedBox(height: 28),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // -----------------------------
  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      );

  // -----------------------------
  Widget _address() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          hintText: "Enter service address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // -----------------------------
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              label: Text(
                d,
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // -----------------------------
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              label: Text(
                slot,
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // -----------------------------
  Widget _stepper(String label, int value, Function(int) onChange) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 17)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (value > 1) onChange(value - 1);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$value",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _circleBtn(Icons.add, () => onChange(value + 1)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // -----------------------------
  Widget _chipSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((o) {
            final selected = selectedOptions.contains(o);
            return ChoiceChip(
              label: Text(
                o,
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) {
                setState(() {
                  if (selected) {
                    selectedOptions.remove(o);
                  } else {
                    selectedOptions.add(o);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // -----------------------------
  Widget _notes() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Any additional notes...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // -----------------------------
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$${widget.item["minPrice"]} – \$${widget.item["maxPrice"]}",
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // -----------------------------
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You pay the cleaner only after the job is fully completed.\n\n"
        "A small \$9.99 booking fee guarantees your appointment, locks the time slot, "
        "and ensures a trusted professional is dispatched to your address.\n\n"
        "Your home is in safe hands — we deliver quality every single time.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  // -----------------------------
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

  // -----------------------------
  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: child,
    );
  }
}
