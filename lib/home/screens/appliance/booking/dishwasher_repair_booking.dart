import 'package:flutter/material.dart';

class DishwasherRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DishwasherRepairBookingScreen({super.key, required this.item});

  @override
  State<DishwasherRepairBookingScreen> createState() =>
      _DishwasherRepairBookingScreenState();
}

class _DishwasherRepairBookingScreenState
    extends State<DishwasherRepairBookingScreen> {
  final Color wibiGreen = const Color(0xFF23A373);
  final Color softGreen = const Color(0xFFDFF3E8);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedIssue;
  String? selectedDate;
  String? selectedTime;

  final List<String> issues = [
    "Not draining",
    "Leaks water",
    "Not washing properly",
    "Not turning on",
    "Strange noises",
    "Bad smell",
    "Buttons not working",
  ];

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
            _title("Service Address"),
            _inputCard(
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Dishwasher Issue"),
            _inputCard(
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedIssue,
                  hint: const Text("Select issue"),
                  isExpanded: true,
                  items: issues
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedIssue = v),
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Day"),
            _card(
              child: Wrap(
                spacing: 10,
                children: nextThreeDays.map((d) {
                  final selected = selectedDate == d;
                  return ChoiceChip(
                    selected: selected,
                    selectedColor: wibiGreen,
                    backgroundColor: Colors.grey.shade200,
                    label: Text(
                      d,
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black),
                    ),
                    onSelected: (_) => setState(() => selectedDate = d),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Time"),
            _card(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: timeSlots.map((slot) {
                  final selected = selectedTime == slot;
                  return ChoiceChip(
                    selected: selected,
                    selectedColor: wibiGreen,
                    backgroundColor: Colors.grey.shade200,
                    label: Text(
                      slot,
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black),
                    ),
                    onSelected: (_) => setState(() => selectedTime = slot),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("Extra Notes"),
            _inputCard(
              TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Describe the issue in detail...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _trustBlock(),
            const SizedBox(height: 35),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      );

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  Widget _inputCard(Widget child) {
    return _card(child: child);
  }

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$80 – \$180\n\n"
        "You’ll never be charged until the job is completed.\n"
        "The \$9.99 booking fee simply reserves your time slot and begins the search for the best available technician.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: wibiGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
