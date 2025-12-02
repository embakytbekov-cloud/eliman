import 'package:flutter/material.dart';

class DoorHandleFixBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DoorHandleFixBookingScreen({super.key, required this.item});

  @override
  State<DoorHandleFixBookingScreen> createState() =>
      _DoorHandleFixBookingScreenState();
}

class _DoorHandleFixBookingScreenState
    extends State<DoorHandleFixBookingScreen> {
  // COLORS
  final Color green = const Color(0xFF1C6E54);
  final Color softGreen = const Color(0xFFDFF3E8);
  final Color buttonGreen = const Color(0xFF25D366);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // NUMBER OF HANDLES
  int handles = 1;

  // BROKEN TYPE
  String? issueType;
  final List<String> issueOptions = [
    "Loose handle",
    "Handle fell off",
    "Locked door",
    "Misaligned latch",
    "Broken mechanism",
  ];

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.item["title"]),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _card(TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                hintText: "Enter your address",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 22),
            _title("How many door handles?"),
            _counter(handles, (v) => setState(() => handles = v)),
            const SizedBox(height: 22),
            _title("What seems to be the issue?"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: issueOptions.map((opt) {
                final selected = issueType == opt;
                return GestureDetector(
                  onTap: () => setState(() => issueType = opt),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? green : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      opt,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            _title("Select Date"),
            _choice(nextThreeDays, selectedDate, (v) {
              setState(() => selectedDate = v);
            }),
            const SizedBox(height: 22),
            _title("Select Time"),
            _choice(timeSlots, selectedTime, (v) {
              setState(() => selectedTime = v);
            }),
            const SizedBox(height: 22),
            _title("Additional Notes"),
            _card(TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: "Describe the issue…", border: InputBorder.none),
            )),
            const SizedBox(height: 25),
            _estimatedPrice(),
            const SizedBox(height: 25),
            _trustBlock(),
            const SizedBox(height: 32),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.06),
            )
          ],
        ),
        child: child,
      );

  Widget _choice(List<String> list, String? selected, Function(String) onSel) {
    return Wrap(
      spacing: 10,
      children: list.map((e) {
        final sel = selected == e;
        return ChoiceChip(
          label: Text(
            e,
            style: TextStyle(color: sel ? Colors.white : Colors.black),
          ),
          selected: sel,
          selectedColor: green,
          backgroundColor: Colors.grey.shade200,
          onSelected: (_) => onSel(e),
        );
      }).toList(),
    );
  }

  Widget _counter(int value, Function(int) change) {
    return _card(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Door Handles", style: TextStyle(fontSize: 16)),
          Row(
            children: [
              _circle(Icons.remove, () {
                if (value > 1) change(value - 1);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "$value",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _circle(Icons.add, () => change(value + 1)),
            ],
          )
        ],
      ),
    );
  }

  Widget _circle(IconData icon, VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: green, shape: BoxShape.circle),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
      );

  Widget _estimatedPrice() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: softGreen,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          "Estimated Price: \$${widget.item["minPrice"]} – \$${widget.item["maxPrice"]}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      );

  Widget _trustBlock() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: softGreen,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Text(
          "You pay the handyman only after the job is fully completed.\n\n"
          "A small \$9.99 booking fee secures your appointment and assigns a trusted professional.\n\n"
          "Your home is in safe hands — we deliver quality every time.",
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
      );

  Widget _confirmButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonGreen,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            "Confirm Booking — \$9.99",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
