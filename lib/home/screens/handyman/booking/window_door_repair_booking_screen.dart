import 'package:flutter/material.dart';

class WindowDoorRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const WindowDoorRepairBookingScreen({super.key, required this.item});

  @override
  State<WindowDoorRepairBookingScreen> createState() =>
      _WindowDoorRepairBookingScreenState();
}

class _WindowDoorRepairBookingScreenState
    extends State<WindowDoorRepairBookingScreen> {
  // COLORS
  final Color accent = const Color(0xFF2B6E4F);
  final Color buttonGreen = const Color(0xFF25D366);
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // QUESTIONS
  String repairType = "Window";
  int quantity = 1;

  String? selectedIssue;
  String? selectedDate;
  String? selectedTime;

  final List<String> issueOptions = [
    "Does not open/close",
    "Loose hinges",
    "Broken handle/lock",
    "Air draft / sealing issue",
    "Cracked frame",
    "Alignment problem",
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

    DateTime now = DateTime.now();
    nextThreeDays = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}",
    ];
  }

  // -------------------------------
  // UI
  // -------------------------------

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
            _addressField(),
            const SizedBox(height: 25),
            _title("What needs repair?"),
            _repairSelector(),
            const SizedBox(height: 25),
            _title("How many?"),
            _counterSelector(),
            const SizedBox(height: 25),
            _title("Main Issue"),
            _issueSelector(),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("Additional Notes"),
            _notesField(),
            const SizedBox(height: 30),
            _estimatedPrice(),
            const SizedBox(height: 25),
            _trustBlock(),
            const SizedBox(height: 40),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // COMPONENTS
  // -------------------------------

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      );

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
              offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  // ADDRESS
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

  // REPAIR TYPE: Window / Door
  Widget _repairSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            _typeBtn("Window"),
            const SizedBox(width: 12),
            _typeBtn("Door"),
          ],
        ),
      ),
    );
  }

  Widget _typeBtn(String t) {
    final selected = repairType == t;
    return GestureDetector(
      onTap: () => setState(() => repairType = t),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? accent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          t,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // QUANTITY
  Widget _counterSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Quantity",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (quantity > 1) setState(() => quantity--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "$quantity",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _circleBtn(Icons.add, () {
                  setState(() => quantity++);
                }),
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
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // ISSUE SELECTOR (chips)
  Widget _issueSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: issueOptions.map((i) {
            final selected = selectedIssue == i;
            return ChoiceChip(
              label: Text(
                i,
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedIssue = i),
            );
          }).toList(),
        ),
      ),
    );
  }

  // DATE SELECTOR
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
                style: TextStyle(color: selected ? Colors.white : Colors.black),
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

  // TIME SELECTOR
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
                style: TextStyle(color: selected ? Colors.white : Colors.black),
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

  // NOTES
  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Add instructions or describe the problem...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ESTIMATED PRICE
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$80 – \$180",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  // TRUST BLOCK
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.45),
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
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
