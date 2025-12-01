import 'package:flutter/material.dart';

class FurnitureDisassemblyBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const FurnitureDisassemblyBookingScreen({super.key, required this.item});

  @override
  State<FurnitureDisassemblyBookingScreen> createState() =>
      _FurnitureDisassemblyBookingScreenState();
}

class _FurnitureDisassemblyBookingScreenState
    extends State<FurnitureDisassemblyBookingScreen> {
  final Color accent = const Color(0xFF2B6E4F); // dark green
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp green
  final Color softGreen = const Color(0xFFDFF3E8); // info blocks

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // QUANTITY
  int itemsCount = 1;

  // ITEM TYPES (chips)
  final List<String> itemTypes = [
    "Bed frame",
    "Wardrobe / Closet",
    "Dresser",
    "Desk",
    "Table",
    "Sectional sofa",
    "TV stand",
    "Bookshelf",
  ];

  List<String> selectedTypes = [];

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
    final minPrice = widget.item["minPrice"];
    final maxPrice = widget.item["maxPrice"];

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
            _addressField(),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("How many items?"),
            _stepper(
              label: "Furniture items",
              value: itemsCount,
              onChanged: (v) => setState(() => itemsCount = v),
            ),
            const SizedBox(height: 25),
            _title("What needs to be disassembled?"),
            _typeChips(),
            const SizedBox(height: 25),
            _title("Additional Notes (optional)"),
            _notesField(),
            const SizedBox(height: 28),
            _estimatedPrice(minPrice, maxPrice),
            const SizedBox(height: 28),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ----------------- UI HELPERS -----------------

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _addressField() {
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

  // SELECT DATE (3 DAYS)
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((day) {
            final selected = selectedDate == day;
            return ChoiceChip(
              label: Text(
                day,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedDate = day),
            );
          }).toList(),
        ),
      ),
    );
  }

  // SELECT TIME
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
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                ),
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

  // STEPPER (кол-во предметов)
  Widget _stepper({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
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
                  if (value > 1) onChanged(value - 1);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _circleBtn(Icons.add, () => onChanged(value + 1)),
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
        decoration: BoxDecoration(
          color: accent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // CHIPS — ITEM TYPES
  Widget _typeChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: itemTypes.map((t) {
            final selected = selectedTypes.contains(t);
            return ChoiceChip(
              label: Text(
                t,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) {
                setState(() {
                  if (selected) {
                    selectedTypes.remove(t);
                  } else {
                    selectedTypes.add(t);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // NOTES
  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Any additional notes (stairs, parking, heavy items...)",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ESTIMATED PRICE (без калькулятора, из модели)
  Widget _estimatedPrice(num minPrice, num maxPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$${minPrice.toInt()} – \$${maxPrice.toInt()}",
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // TRUST BLOCK (зелёный текст про 9.99)
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
        style: TextStyle(
          fontSize: 15,
          height: 1.4,
        ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          // TODO: later send to Telegram / Supabase
        },
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

  // CARD WRAPPER
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
