import 'package:flutter/material.dart';

class GarageOpenerBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const GarageOpenerBookingScreen({super.key, required this.item});

  @override
  State<GarageOpenerBookingScreen> createState() =>
      _GarageOpenerBookingScreenState();
}

class _GarageOpenerBookingScreenState extends State<GarageOpenerBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String doorType = "Single Door";
  final List<String> doorTypes = [
    "Single Door",
    "Double Door",
    "Insulated Door",
    "Old Door Replacement Needed"
  ];

  String openerType = "Smart WiFi Opener";
  final List<String> openerTypes = [
    "Smart WiFi Opener",
    "Remote-Only Opener",
    "Belt Drive",
    "Chain Drive"
  ];

  List<String> extraOptions = [
    "Remove old opener",
    "Setup mobile app",
    "Connect to WiFi",
    "Mount keypad",
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
            _title("Garage Door Type"),
            _singleChipSelector(
              options: doorTypes,
              selected: doorType,
              onSelect: (v) => setState(() => doorType = v),
            ),
            const SizedBox(height: 25),
            _title("Opener Type"),
            _singleChipSelector(
              options: openerTypes,
              selected: openerType,
              onSelect: (v) => setState(() => openerType = v),
            ),
            const SizedBox(height: 25),
            _title("Extra Options"),
            _multiChipSelector(
              options: extraOptions,
              selectedList: selectedExtras,
            ),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("Notes"),
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

  // -------- UI HELPERS ----------

  AppBar _appBar() => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
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
            contentPadding: const EdgeInsets.all(14)),
      ),
    );
  }

  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
            hintText: "Any extra notes...",
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(14)),
      ),
    );
  }

  Widget _singleChipSelector({
    required List<String> options,
    required String selected,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final isSel = opt == selected;
        return GestureDetector(
          onTap: () => onSelect(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSel ? const Color(0xFF23A373) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(opt,
                style: TextStyle(
                    color: isSel ? Colors.white : Colors.black, fontSize: 14)),
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
        final isSel = selectedList.contains(opt);
        return GestureDetector(
          onTap: () {
            setState(() {
              isSel ? selectedList.remove(opt) : selectedList.add(opt);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSel ? const Color(0xFF23A373) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(opt,
                style: TextStyle(
                    color: isSel ? Colors.white : Colors.black, fontSize: 14)),
          ),
        );
      }).toList(),
    );
  }

  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((day) {
            final selected = day == selectedDate;
            return ChoiceChip(
              selectedColor: const Color(0xFF23A373),
              backgroundColor: Colors.grey.shade200,
              selected: selected,
              label: Text(day,
                  style:
                      TextStyle(color: selected ? Colors.white : Colors.black)),
              onSelected: (_) => setState(() => selectedDate = day),
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
          spacing: 10,
          children: timeSlots.map((slot) {
            final sel = slot == selectedTime;
            return ChoiceChip(
              selected: sel,
              selectedColor: const Color(0xFF23A373),
              backgroundColor: Colors.grey.shade200,
              label: Text(slot,
                  style: TextStyle(color: sel ? Colors.white : Colors.black)),
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
          "Our \$9.99 booking fee simply reserves your time slot and "
          "begins the search for the best available professional.\n\n"
          "We’ll notify you once your request is accepted.",
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
                  borderRadius: BorderRadius.circular(14))),
          child: const Text("Confirm Booking — \$9.99",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ));
  }

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ]),
      child: child,
    );
  }
}
