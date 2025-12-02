import 'package:flutter/material.dart';

class CarLockoutBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const CarLockoutBookingScreen({super.key, required this.item});

  @override
  State<CarLockoutBookingScreen> createState() =>
      _CarLockoutBookingScreenState();
}

class _CarLockoutBookingScreenState extends State<CarLockoutBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedTime;
  final List<String> timeSlots = [
    "ASAP (Emergency)",
    "Within 1 hour",
    "2–3 hours",
  ];

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _title("Your Location"),
          _card(
            child: TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your address",
              ),
            ),
          ),
          const SizedBox(height: 25),
          _title("When do you need help?"),
          Wrap(
            spacing: 10,
            children: timeSlots.map((t) {
              bool selected = selectedTime == t;
              return ChoiceChip(
                label: Text(t),
                selected: selected,
                selectedColor: const Color(0xFF23A373),
                onSelected: (_) => setState(() => selectedTime = t),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          _title("Extra Notes"),
          _card(
            child: TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Add details (optional)…",
              ),
            ),
          ),
          const SizedBox(height: 30),
          _infoBlock(),
          const SizedBox(height: 30),
          _confirm(),
        ]),
      ),
    );
  }

  Widget _title(String t) => Text(t,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700));

  Widget _card({required Widget child}) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.06)),
          ],
        ),
        child: child,
      );

  Widget _infoBlock() => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFDFF3E8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Text(
          "Estimated Price: \$60 – \$120\n"
          "\nYou’ll never be charged until the job is completed.\n"
          "Our \$9.99 booking fee simply reserves your time slot and sends the nearest locksmith to you.",
          style: TextStyle(fontSize: 15, height: 1.4),
        ),
      );

  Widget _confirm() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25D366),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
