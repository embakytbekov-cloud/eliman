import 'package:flutter/material.dart';

class OutsideWindowCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const OutsideWindowCleaningBookingScreen({super.key, required this.item});

  @override
  State<OutsideWindowCleaningBookingScreen> createState() =>
      _OutsideWindowCleaningBookingScreenState();
}

class _OutsideWindowCleaningBookingScreenState
    extends State<OutsideWindowCleaningBookingScreen> {
  // COLORS
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color softGreen = const Color(0xFFDFF3E8);
  final Color buttonGreen = const Color(0xFF25D366);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();

  // FIELDS
  String? selectedSurface; // inside / outside / both
  int floors = 1;

  List<String> selectedWindowCount = [];
  List<String> selectedExtras = [];

  // OPTIONS
  final List<String> surfaces = [
    "Outside Only",
    "Inside Only",
    "Inside + Outside"
  ];

  final List<String> windowCountOptions = [
    "1–10",
    "11–20",
    "21–30",
    "31–50",
    "50+"
  ];

  final List<String> extras = [
    "Screen Cleaning",
    "Track Cleaning",
    "Frame Wipe",
    "Sill Cleaning",
    "Hard Water Removal"
  ];

  // DATE / TIME
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
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Address"),
            _addressField(),
            const SizedBox(height: 25),
            _title("Cleaning Type"),
            _chips(
              options: surfaces,
              selected: selectedSurface,
              onSelect: (v) => setState(() => selectedSurface = v),
            ),
            const SizedBox(height: 25),
            _title("How many floors?"),
            _floorSelector(),
            const SizedBox(height: 25),
            _title("Window Count"),
            _multiChips(
              options: windowCountOptions,
              selectedList: selectedWindowCount,
              onTap: (v) {
                setState(() {
                  if (selectedWindowCount.contains(v)) {
                    selectedWindowCount.remove(v);
                  } else {
                    selectedWindowCount.clear();
                    selectedWindowCount.add(v);
                  }
                });
              },
            ),
            const SizedBox(height: 25),
            _title("Extra Services"),
            _multiChips(
              options: extras,
              selectedList: selectedExtras,
              onTap: (v) {
                setState(() {
                  if (selectedExtras.contains(v)) {
                    selectedExtras.remove(v);
                  } else {
                    selectedExtras.add(v);
                  }
                });
              },
            ),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 35),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ----------------------------
  //  COMPONENTS
  // ----------------------------
  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          t,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
      );

  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          hintText: "Enter service address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // CLEANING TYPE CHIPS
  Widget _chips({
    required List<String> options,
    required String? selected,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 10,
      children: options.map((op) {
        final bool active = selected == op;
        return ChoiceChip(
          label: Text(
            op,
            style: TextStyle(color: active ? Colors.white : Colors.black),
          ),
          selected: active,
          selectedColor: darkGreen,
          backgroundColor: Colors.grey.shade200,
          onSelected: (_) => onSelect(op),
        );
      }).toList(),
    );
  }

  // MULTI SELECT CHIPS
  Widget _multiChips({
    required List<String> options,
    required List<String> selectedList,
    required Function(String) onTap,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((op) {
        final active = selectedList.contains(op);
        return GestureDetector(
          onTap: () => onTap(op),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: active ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              op,
              style: TextStyle(
                color: active ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // FLOORS STEPPER
  Widget _floorSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Floors", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (floors > 1) setState(() => floors--);
                }),
                const SizedBox(width: 12),
                Text(
                  "$floors",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 12),
                _circleBtn(Icons.add, () => setState(() => floors++)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: darkGreen,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // DATE
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final active = selectedDate == d;
            return ChoiceChip(
              label: Text(
                d,
                style: TextStyle(color: active ? Colors.white : Colors.black),
              ),
              selected: active,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TIME
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final active = selectedTime == slot;
            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(color: active ? Colors.white : Colors.black),
              ),
              selected: active,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TRUST BLOCK
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$XX – \$XX\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional.\n\n"
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
          backgroundColor: buttonGreen,
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

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.07),
          ),
        ],
      ),
      child: child,
    );
  }
}
