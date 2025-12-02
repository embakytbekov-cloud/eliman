import 'package:flutter/material.dart';

class SmartLockBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartLockBookingScreen({super.key, required this.item});

  @override
  State<SmartLockBookingScreen> createState() => _SmartLockBookingScreenState();
}

class _SmartLockBookingScreenState extends State<SmartLockBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  int locks = 1;

  String lockType = "Deadbolt";
  final List<String> lockTypes = [
    "Deadbolt",
    "Lever lock",
    "Knob lock",
    "No existing lock (new install)",
  ];

  final List<String> extras = [
    "App & remote setup",
    "Connect to WiFi",
    "Connect to Alexa / Google",
    "Remove old lock",
  ];

  List<String> selectedExtras = [];

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
    final min = widget.item["minPrice"];
    final max = widget.item["maxPrice"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Address"),
            _field(addressCtrl, "Enter your address"),
            const SizedBox(height: 25),
            _title("How many smart locks?"),
            _counter(
              value: locks,
              label: "lock",
              onChanged: (v) => setState(() => locks = v),
            ),
            const SizedBox(height: 25),
            _title("Lock Type"),
            _chipSelector(
              options: lockTypes,
              selected: lockType,
              onSelect: (v) => setState(() => lockType = v),
            ),
            const SizedBox(height: 25),
            _title("Extra Options"),
            _multiChipSelector(
              options: extras,
              selectedList: selectedExtras,
            ),
            const SizedBox(height: 25),
            _title("Select Date"),
            _datePicker(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timePicker(),
            const SizedBox(height: 25),
            _title("Notes (optional)"),
            _notesField(),
            const SizedBox(height: 25),
            _priceBlock(min, max),
            const SizedBox(height: 35),
            _confirmBtn(),
          ],
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  AppBar _appBar() => AppBar(
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
      );

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget _field(TextEditingController c, String hint) {
    return _card(
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(14),
        ),
      ),
    );
  }

  Widget _notesField() => _card(
        child: TextField(
          controller: notesCtrl,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Access code, parking notes, special instructions...",
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(14),
          ),
        ),
      );

  Widget _counter({
    required int value,
    required String label,
    required ValueChanged<int> onChanged,
  }) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$value $label${value > 1 ? 's' : ''}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (value > 1) onChanged(value - 1);
                }),
                const SizedBox(width: 10),
                _circleBtn(Icons.add, () => onChanged(value + 1)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _chipSelector({
    required List<String> options,
    required String selected,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final isSelected = selected == opt;
        return GestureDetector(
          onTap: () => onSelect(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color:
                  isSelected ? const Color(0xFF23A373) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _multiChipSelector({
    required List<String> options,
    required List<String> selectedList,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final selected = selectedList.contains(opt);
        return GestureDetector(
          onTap: () {
            setState(() {
              selected ? selectedList.remove(opt) : selectedList.add(opt);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _datePicker() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              selected: selected,
              selectedColor: const Color(0xFF23A373),
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(color: selected ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _timePicker() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              selected: selected,
              selectedColor: const Color(0xFF23A373),
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style: TextStyle(color: selected ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _priceBlock(int min, int max) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Estimated Price: \$$min – \$$max\n\n"
          "You’ll never be charged until the job is completed.\n"
          "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
          "We’ll notify you as soon as someone accepts your request.",
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
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
            borderRadius: BorderRadius.circular(14),
          ),
        ),
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

  // Card + Circle Btn
  Widget _card({required Widget child}) => Container(
        margin: const EdgeInsets.only(top: 8),
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

  Widget _circleBtn(IconData i, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFF23A373),
          shape: BoxShape.circle,
        ),
        child: Icon(i, size: 18, color: Colors.white),
      ),
    );
  }
}
