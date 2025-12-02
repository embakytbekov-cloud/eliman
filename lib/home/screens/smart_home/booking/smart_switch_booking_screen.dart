import 'package:flutter/material.dart';

class SmartSwitchBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartSwitchBookingScreen({
    super.key,
    required this.item,
  });

  @override
  State<SmartSwitchBookingScreen> createState() =>
      _SmartSwitchBookingScreenState();
}

class _SmartSwitchBookingScreenState extends State<SmartSwitchBookingScreen> {
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // SWITCH OPTIONS
  int switchCount = 1;
  String switchType = "Single Switch";
  String wiring = "Neutral Wire Available";
  List<String> selectedExtras = [];

  final List<String> switchTypes = [
    "Single Switch",
    "Double Switch",
    "Triple Switch",
    "Dimmer Switch",
    "3-Way Switch",
  ];

  final List<String> wiringOptions = [
    "Neutral Wire Available",
    "Not Sure",
    "Old House Wiring",
  ];

  final List<String> extras = [
    "Remove old switch",
    "Install smart dimmer",
    "Install smart 3-way",
    "App setup",
    "Smart home integration",
  ];

  // DATE / TIME
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
    final min = widget.item["minPrice"];
    final max = widget.item["maxPrice"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
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
            _title("Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 22),
            _title("How Many Switches?"),
            _switchCounter(),
            const SizedBox(height: 22),
            _title("Switch Type"),
            _chips(
                switchTypes, switchType, (v) => setState(() => switchType = v)),
            const SizedBox(height: 22),
            _title("Wiring Condition"),
            _chips(wiringOptions, wiring, (v) => setState(() => wiring = v)),
            const SizedBox(height: 22),
            _title("Extras"),
            _multiChips(),
            const SizedBox(height: 22),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 22),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 22),
            _title("Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Notes for technician...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 25),
            _priceBlock(min, max),
            const SizedBox(height: 25),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // UI HELPERS --------------------------------------------------------

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _chips(List<String> items, String selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: items.map((opt) {
        final sel = opt == selected;
        return GestureDetector(
          onTap: () => onTap(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: sel ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: sel ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _multiChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: extras.map((opt) {
        final sel = selectedExtras.contains(opt);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (sel) {
                selectedExtras.remove(opt);
              } else {
                selectedExtras.add(opt);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: sel ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: sel ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _switchCounter() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Switches", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (switchCount > 1) {
                    setState(() => switchCount--);
                  }
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$switchCount",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                _circleBtn(Icons.add, () {
                  setState(() => switchCount++);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: accent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          children: nextThreeDays.map((d) {
            final sel = selectedDate == d;

            return ChoiceChip(
              selected: sel,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(color: sel ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          children: timeSlots.map((slot) {
            final sel = selectedTime == slot;

            return ChoiceChip(
              selected: sel,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style: TextStyle(color: sel ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _priceBlock(min, max) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Estimated Price: \$$min – \$$max\n\n"
          "You’ll never be charged until the job is completed.\n"
          "The \$9.99 booking fee reserves your time slot and begins searching for a nearby professional.\n\n"
          "We’ll notify you immediately once someone accepts your request.",
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: confirmGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
