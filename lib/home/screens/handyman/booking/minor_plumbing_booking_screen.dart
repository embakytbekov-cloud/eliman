import 'package:flutter/material.dart';

class MinorPlumbingBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const MinorPlumbingBookingScreen({super.key, required this.item});

  @override
  State<MinorPlumbingBookingScreen> createState() =>
      _MinorPlumbingBookingScreenState();
}

class _MinorPlumbingBookingScreenState
    extends State<MinorPlumbingBookingScreen> {
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

  // Plumbing issue type
  String? plumbingType;

  final issues = [
    "Clogged Sink",
    "Leaking Pipe",
    "Running Toilet",
    "Garbage Disposal Issue",
    "Shower Pressure Issue",
    "Valve Replacement",
    "Other Small Fix",
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
            _title("What needs fixing?"),
            _card(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: issues.map((i) {
                  final selected = plumbingType == i;
                  return ChoiceChip(
                    label: Text(i),
                    selected: selected,
                    selectedColor: green,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                    onSelected: (_) => setState(() => plumbingType = i),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("Additional Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Describe the issue if needed...",
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
                    label: Text(
                      d,
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black),
                    ),
                    selected: selected,
                    selectedColor: green,
                    backgroundColor: Colors.grey.shade200,
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
                    label: Text(
                      slot,
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black),
                    ),
                    selected: selected,
                    selectedColor: green,
                    backgroundColor: Colors.grey.shade200,
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
            _trustBlock(),
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

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: green.withOpacity(.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You’ll never be charged until the job is completed.\n"
        "The \$9.99 booking fee simply reserves your time slot and sends your request to the best available professional.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
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
