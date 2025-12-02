import 'package:flutter/material.dart';

class SmallMoveBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmallMoveBookingScreen({super.key, required this.item});

  @override
  State<SmallMoveBookingScreen> createState() => _SmallMoveBookingScreenState();
}

class _SmallMoveBookingScreenState extends State<SmallMoveBookingScreen> {
  // CONTROLLERS
  final TextEditingController pickupCtrl = TextEditingController();
  final TextEditingController dropoffCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // QUESTIONS
  bool heavyItem = false;
  bool needTruck = false;

  // DATE / TIME
  String? selectedDate;
  String? selectedTime;

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

  // ------------------------------
  // UI HELPERS
  // ------------------------------

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          t,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      );

  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: child,
    );
  }

  // DATE SELECTOR
  Widget _dateButtons() {
    return _card(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final isSelected = selectedDate == d;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: const Color(0xFF2B6E4F),
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TIME SELECTOR
  Widget _timeSelector() {
    return _card(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final isSelected = selectedTime == slot;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: const Color(0xFF2B6E4F),
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // YES/NO select
  Widget _yesNo(bool value, Function(bool) onSelect) {
    return Row(
      children: [
        _choice("Yes", value == true, () => onSelect(true)),
        const SizedBox(width: 10),
        _choice("No", value == false, () => onSelect(false)),
      ],
    );
  }

  Widget _choice(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // TRUST BLOCK (GREEN)
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$80 – \$200\n\n"
        "You will never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available mover.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }

  // CONFIRM BUTTON
  Widget _confirmBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25D366),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Small Move request sent!")));
        },
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // -------------------------------------------------------

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
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Pickup Address"),
            _card(
              TextField(
                controller: pickupCtrl,
                decoration: const InputDecoration(
                    hintText: "Enter pickup location",
                    contentPadding: EdgeInsets.all(14),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20),
            _title("Drop-off Address"),
            _card(
              TextField(
                controller: dropoffCtrl,
                decoration: const InputDecoration(
                    hintText: "Enter drop-off location",
                    contentPadding: EdgeInsets.all(14),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20),
            _title("Is it a heavy item?"),
            _yesNo(heavyItem, (v) => setState(() => heavyItem = v)),
            const SizedBox(height: 20),
            _title("Do you need a truck?"),
            _yesNo(needTruck, (v) => setState(() => needTruck = v)),
            const SizedBox(height: 20),
            _title("Select Date"),
            _dateButtons(),
            const SizedBox(height: 20),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 20),
            _title("Extra Notes"),
            _card(
              TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any additional details...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 25),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmBtn(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
