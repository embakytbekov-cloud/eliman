import 'package:flutter/material.dart';

class LockRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const LockRepairBookingScreen({super.key, required this.item});

  @override
  State<LockRepairBookingScreen> createState() =>
      _LockRepairBookingScreenState();
}

class _LockRepairBookingScreenState extends State<LockRepairBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController issueCtrl = TextEditingController();

  List<String> issues = [
    "Jammed Lock",
    "Loose Handle",
    "Key Not Turning",
    "Broken Cylinder",
    "Misaligned Latch",
    "Other Issue"
  ];

  String? selectedIssue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.item["title"],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _card(TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                hintText: "Enter address",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 20),
            _title("What’s the Problem?"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: issues.map((i) {
                final selected = selectedIssue == i;
                return _chip(i, selected, () {
                  setState(() => selectedIssue = i);
                });
              }).toList(),
            ),
            const SizedBox(height: 20),
            _title("Describe the Issue (optional)"),
            _card(TextField(
              controller: issueCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "More details…",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 30),
            _wibiInfo(widget.item),
            const SizedBox(height: 30),
            _confirmBtn(),
          ],
        ),
      ),
    );
  }

  Widget _title(String t) => Text(t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700));

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.07))
          ],
        ),
        child: child,
      );

  Widget _chip(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2B6E4F) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }

  Widget _wibiInfo(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: const Color(0xFFDFF3E8),
          borderRadius: BorderRadius.circular(14)),
      child: Text(
        "Estimated Price: \$${item["minPrice"]} – \$${item["maxPrice"]}\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee reserves your time slot and contacts the nearest available locksmith.\n\n"
        "We will notify you as soon as someone accepts your request.",
        style: const TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _confirmBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25D366),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))),
        child: const Text("Confirm Booking — \$9.99",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
    );
  }
}
