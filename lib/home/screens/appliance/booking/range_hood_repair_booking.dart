import 'package:flutter/material.dart';

class RangeHoodRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const RangeHoodRepairBookingScreen({super.key, required this.item});

  @override
  State<RangeHoodRepairBookingScreen> createState() =>
      _RangeHoodRepairBookingScreenState();
}

class _RangeHoodRepairBookingScreenState
    extends State<RangeHoodRepairBookingScreen> {
  final Color wibiGreen = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // USER SELECTED OPTIONS
  bool lightIssue = false;
  bool fanNoise = false;
  bool weakSuction = false;
  bool filterReplace = false;
  bool fullDiagnostic = false;

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
            _inputCard(TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                hintText: "Enter your address",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 25),
            _title("What seems to be the issue?"),
            _checkbox("Light not working", lightIssue, (v) {
              setState(() => lightIssue = v);
            }),
            _checkbox("Fan making noise", fanNoise, (v) {
              setState(() => fanNoise = v);
            }),
            _checkbox("Weak suction / low airflow", weakSuction, (v) {
              setState(() => weakSuction = v);
            }),
            _checkbox("Need filter replacement", filterReplace, (v) {
              setState(() => filterReplace = v);
            }),
            _checkbox("Full diagnostic", fullDiagnostic, (v) {
              setState(() => fullDiagnostic = v);
            }),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("Additional Notes"),
            _inputCard(TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Describe the issue in more detail...",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // UI COMPONENTS
  // ---------------------------------------------------------

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      );

  Widget _inputCard(Widget child) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.07),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _checkbox(String title, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      activeColor: wibiGreen,
      value: value,
      onChanged: (v) => onChanged(v!),
      title: Text(title),
    );
  }

  Widget _dateSelector() {
    return _inputCard(
      Wrap(
        spacing: 10,
        children: nextThreeDays.map((d) {
          final selected = selectedDate == d;
          return ChoiceChip(
            selected: selected,
            selectedColor: wibiGreen,
            backgroundColor: Colors.grey.shade200,
            label: Text(
              d,
              style: TextStyle(color: selected ? Colors.white : Colors.black),
            ),
            onSelected: (_) => setState(() => selectedDate = d),
          );
        }).toList(),
      ),
    );
  }

  Widget _timeSelector() {
    return _inputCard(
      Wrap(
        spacing: 10,
        children: timeSlots.map((t) {
          final selected = selectedTime == t;
          return ChoiceChip(
            selected: selected,
            selectedColor: wibiGreen,
            backgroundColor: Colors.grey.shade200,
            label: Text(
              t,
              style: TextStyle(color: selected ? Colors.white : Colors.black),
            ),
            onSelected: (_) => setState(() => selectedTime = t),
          );
        }).toList(),
      ),
    );
  }

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$XX – \$XX\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search "
        "for the best available professional in your area.\n\n"
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
}
