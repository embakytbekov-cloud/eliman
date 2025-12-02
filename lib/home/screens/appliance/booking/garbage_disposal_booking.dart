import 'package:flutter/material.dart';

class GarbageDisposalRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const GarbageDisposalRepairBookingScreen({super.key, required this.item});

  @override
  State<GarbageDisposalRepairBookingScreen> createState() =>
      _GarbageDisposalRepairBookingScreenState();
}

class _GarbageDisposalRepairBookingScreenState
    extends State<GarbageDisposalRepairBookingScreen> {
  final Color wibiGreen = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // SELECT OPTIONS
  String? issueType;
  String? unitAge;
  bool needsReplacement = false;

  final List<String> issueTypes = [
    "Disposal jammed",
    "Humming but not spinning",
    "Leaking disposal",
    "Won’t turn on",
    "Bad odor / cleaning",
    "Other issue",
  ];

  final List<String> ageOptions = [
    "Less than 3 years",
    "3 – 7 years",
    "7 – 12 years",
    "More than 12 years",
  ];

  // DATE & TIME
  String? selectedDate;
  String? selectedTime;

  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _whiteBox(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Issue"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: issueTypes.map((e) {
                final selected = issueType == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: wibiGreen,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle:
                      TextStyle(color: selected ? Colors.white : Colors.black),
                  onSelected: (_) => setState(() => issueType = e),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            _title("Unit Age"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ageOptions.map((e) {
                final selected = unitAge == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: wibiGreen,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => unitAge = e),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            _title("Replacement Needed?"),
            Row(
              children: [
                _option("Yes", needsReplacement == true, () {
                  setState(() => needsReplacement = true);
                }),
                const SizedBox(width: 12),
                _option("No", needsReplacement == false, () {
                  setState(() => needsReplacement = false);
                }),
              ],
            ),
            const SizedBox(height: 25),
            _title("Select Date"),
            _whiteBox(
              child: Wrap(
                spacing: 10,
                children: nextThreeDays.map((d) {
                  final selected = selectedDate == d;
                  return ChoiceChip(
                    label: Text(d),
                    selected: selected,
                    selectedColor: wibiGreen,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) => setState(() => selectedDate = d),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Time"),
            _whiteBox(
              child: Wrap(
                spacing: 10,
                children: timeSlots.map((slot) {
                  final selected = selectedTime == slot;
                  return ChoiceChip(
                    label: Text(slot),
                    selected: selected,
                    selectedColor: wibiGreen,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                    onSelected: (_) => setState(() => selectedTime = slot),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("Additional Notes"),
            _whiteBox(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Describe the issue or anything important...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _greenInfo(),
            const SizedBox(height: 30),
            _confirmBtn(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // UI HELPERS --------------------------------------------------------

  Widget _title(String t) {
    return Text(
      t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _option(String t, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? wibiGreen : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          t,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _whiteBox({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
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

  Widget _greenInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$70 – \$150\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _confirmBtn() {
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
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
