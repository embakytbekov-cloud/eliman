import 'package:flutter/material.dart';

class DeadboltInstallBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DeadboltInstallBookingScreen({super.key, required this.item});

  @override
  State<DeadboltInstallBookingScreen> createState() =>
      _DeadboltInstallBookingScreenState();
}

class _DeadboltInstallBookingScreenState
    extends State<DeadboltInstallBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  int locks = 1;

  String? selectedDay;
  String? selectedTime;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM"
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

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          t,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      );

  Widget _card(Widget child) => Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Deadbolt Install",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _title("Service Address"),
          _card(
            TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                  hintText: "Enter your address", border: InputBorder.none),
            ),
          ),
          _title("How many deadbolts?"),
          _card(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Deadbolts", style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    _circleBtn(Icons.remove, () {
                      if (locks > 1) setState(() => locks--);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("$locks",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    _circleBtn(Icons.add, () {
                      setState(() => locks++);
                    }),
                  ],
                )
              ],
            ),
          ),
          _title("Select Date"),
          _card(
            Wrap(
              spacing: 10,
              children: nextThreeDays.map((d) {
                final selected = selectedDay == d;
                return ChoiceChip(
                  label: Text(
                    d,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                  ),
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (_) => setState(() => selectedDay = d),
                );
              }).toList(),
            ),
          ),
          _title("Select Time"),
          _card(
            Wrap(
              spacing: 10,
              children: timeSlots.map((t) {
                final selected = selectedTime == t;
                return ChoiceChip(
                  label: Text(
                    t,
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black),
                  ),
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (_) => setState(() => selectedTime = t),
                );
              }).toList(),
            ),
          ),
          _title("Notes (Optional)"),
          _card(
            TextField(
              controller: notesCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                  hintText: "Any extra details…", border: InputBorder.none),
            ),
          ),
          const SizedBox(height: 10),
          _card(const Text(
            "Estimated Price: \$80 – \$180\n\n"
            "You’ll never be charged until the job is completed.\n"
            "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
            "We’ll notify you as soon as someone accepts your request.",
            style: TextStyle(fontSize: 15, height: 1.4),
          )),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {},
              child: const Text(
                "Confirm Booking — \$9.99",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFF2B6E4F),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
