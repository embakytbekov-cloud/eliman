import 'package:flutter/material.dart';

class WallPatchRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const WallPatchRepairBookingScreen({super.key, required this.item});

  @override
  State<WallPatchRepairBookingScreen> createState() =>
      _WallPatchRepairBookingScreenState();
}

class _WallPatchRepairBookingScreenState
    extends State<WallPatchRepairBookingScreen> {
  final Color green = const Color(0xFF23A373);
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedDate;
  String? selectedTime;
  late List<String> days;

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
    days = [
      "${now.month}/${now.day}/${now.year}",
      "${now.month}/${now.day + 1}/${now.year}",
      "${now.month}/${now.day + 2}/${now.year}",
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
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
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
            _title("Describe the problem"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Example: hole size, drywall damage, etc.",
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Day"),
            _card(
              child: Wrap(
                spacing: 10,
                children: days.map((d) {
                  final selected = selectedDate == d;
                  return ChoiceChip(
                    selected: selected,
                    selectedColor: green,
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
                children: timeSlots.map((slot) {
                  final selected = selectedTime == slot;
                  return ChoiceChip(
                    selected: selected,
                    selectedColor: green,
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
            _title("Estimated Price"),
            _card(
              child: Text(
                "\$${widget.item["minPrice"]} – \$${widget.item["maxPrice"]}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 25),
            _trust(),
            const SizedBox(height: 25),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  Widget _trust() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: green.withOpacity(.10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You’ll never be charged until the job is completed.\n"
        "The \$9.99 booking fee simply reserves your time slot and sends the request to the best available handyman.\n\n"
        "We’ll notify you as soon as a professional accepts your booking.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: green,
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
}
