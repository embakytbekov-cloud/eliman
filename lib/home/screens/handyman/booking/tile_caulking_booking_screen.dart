import 'package:flutter/material.dart';

class TileCaulkingBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const TileCaulkingBookingScreen({super.key, required this.item});

  @override
  State<TileCaulkingBookingScreen> createState() =>
      _TileCaulkingBookingScreenState();
}

class _TileCaulkingBookingScreenState extends State<TileCaulkingBookingScreen> {
  final Color green = const Color(0xFF1C6E54);
  final Color buttonGreen = const Color(0xFF25D366);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // HOW MANY AREAS?
  int areas = 1;

  // DATE / TIME
  String? selectedDate;
  String? selectedTime;
  late List<String> next3Days;

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

    next3Days = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item["title"]),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
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
            _title("How many areas need caulking?"),
            _counter("Areas", areas, (v) => setState(() => areas = v)),
            const SizedBox(height: 20),
            _title("Select Date"),
            _choice(next3Days, selectedDate, (v) {
              setState(() => selectedDate = v);
            }),
            const SizedBox(height: 20),
            _title("Select Time"),
            _choice(timeSlots, selectedTime, (v) {
              setState(() => selectedTime = v);
            }),
            const SizedBox(height: 20),
            _title("Extra Notes"),
            _card(TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Describe tile area, mold, water damage…",
              ),
            )),
            const SizedBox(height: 22),
            _estimated(),
            const SizedBox(height: 22),
            _trust(),
            const SizedBox(height: 22),
            _confirm(),
          ],
        ),
      ),
    );
  }

  // ---------------- widgets ----------------

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      );

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]),
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

  Widget _counter(String t, int value, Function(int) onChange) {
    return _card(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              _circle(Icons.remove, () {
                if (value > 1) onChange(value - 1);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "$value",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _circle(Icons.add, () => onChange(value + 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circle(IconData i, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(shape: BoxShape.circle, color: green),
        child: Icon(i, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _estimated() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFDFF3E8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          "Estimated Price: \$${widget.item["minPrice"]} – \$${widget.item["maxPrice"]}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      );

  Widget _trust() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFDFF3E8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Text(
          "You pay the handyman only after the job is fully completed.\n\n"
          "A small \$9.99 booking fee secures your appointment and assigns a trusted professional.\n\n"
          "Your home is in safe hands — we deliver quality every time.",
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
      );

  Widget _confirm() => SizedBox(
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
}
