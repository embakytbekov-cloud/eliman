import 'package:flutter/material.dart';

class AirbnbCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const AirbnbCleaningBookingScreen({super.key, required this.item});

  @override
  State<AirbnbCleaningBookingScreen> createState() =>
      _AirbnbCleaningBookingScreenState();
}

class _AirbnbCleaningBookingScreenState
    extends State<AirbnbCleaningBookingScreen> {
  // COLORS
  final Color accent = const Color(0xFF2B6E4F); // Dark green
  final Color confirmGreen = const Color(0xFF25D366); // WhatsApp green
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // ROOMS
  int bedrooms = 1;
  int bathrooms = 1;
  int guests = 1;

  // DATE
  String? selectedDate;
  late List<String> nextThreeDays;

  // TIME
  String? selectedTime;
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  // CLEAN TYPES (Airbnb specific)
  String? cleanType;
  final List<String> cleanTypes = [
    "Checkout Clean",
    "Back-to-Back",
    "Mid-Stay Clean",
  ];

  // LINEN & LAUNDRY
  List<String> linenTasks = [];
  final List<String> linenOptions = [
    "Change bedding",
    "Wash towels",
    "Laundry load",
    "Refill linens",
  ];

  // RESTOCKING
  List<String> restockTasks = [];
  final List<String> restockOptions = [
    "Refill toiletries",
    "Restock trash bags",
    "Paper towels",
    "Coffee / tea refill",
  ];

  // EXTRA TASKS
  List<String> extras = [];
  final List<String> extraOptions = [
    "Fridge Cleaning",
    "Oven Cleaning",
    "Balcony Sweep",
    "Windows Interior",
    "Deep Disinfection",
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
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Airbnb Cleaning",
          style: TextStyle(
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
            _addressField(),
            const SizedBox(height: 22),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 22),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 22),
            _title("Bedrooms"),
            _stepper(
                value: bedrooms,
                onChanged: (v) => setState(() => bedrooms = v)),
            const SizedBox(height: 22),
            _title("Bathrooms"),
            _stepper(
                value: bathrooms,
                onChanged: (v) => setState(() => bathrooms = v)),
            const SizedBox(height: 22),
            _title("Guests"),
            _stepper(
                value: guests, onChanged: (v) => setState(() => guests = v)),
            const SizedBox(height: 22),
            _title("Cleaning Type"),
            _chipSelectorSingle(cleanTypes, cleanType, (v) {
              setState(() => cleanType = v);
            }),
            const SizedBox(height: 22),
            _title("Linen & Laundry"),
            _chipSelectorMulti(linenOptions, linenTasks),
            const SizedBox(height: 22),
            _title("Restocking"),
            _chipSelectorMulti(restockOptions, restockTasks),
            const SizedBox(height: 22),
            _title("Extra Tasks"),
            _chipSelectorMulti(extraOptions, extras),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 35),
            _confirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ===============================
  //  UI COMPONENTS
  // ===============================

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      );

  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          hintText: "Enter property address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _dateSelector() {
    return _card(
      child: Wrap(
        spacing: 10,
        children: nextThreeDays.map((d) {
          final selected = selectedDate == d;
          return ChoiceChip(
            selected: selected,
            selectedColor: accent,
            backgroundColor: Colors.grey.shade200,
            label: Text(
              d,
              style: TextStyle(color: selected ? Colors.white : Colors.black),
            ),
            onSelected: (_) => setState(() => selectedDate = d),
          );
        }).toList(),
      ),
    );
  }

  Widget _timeSelector() {
    return _card(
      child: Wrap(
        spacing: 10,
        children: timeSlots.map((slot) {
          final selected = selectedTime == slot;
          return ChoiceChip(
            selected: selected,
            selectedColor: accent,
            backgroundColor: Colors.grey.shade200,
            label: Text(
              slot,
              style: TextStyle(color: selected ? Colors.white : Colors.black),
            ),
            onSelected: (_) => setState(() => selectedTime = slot),
          );
        }).toList(),
      ),
    );
  }

  Widget _stepper({required int value, required ValueChanged<int> onChanged}) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$value",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (value > 1) onChanged(value - 1);
                }),
                const SizedBox(width: 10),
                _circleBtn(Icons.add, () {
                  onChanged(value + 1);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: accent,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  Widget _chipSelectorSingle(
      List<String> options, String? active, Function(String) onSelect) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final selected = active == opt;
        return ChoiceChip(
          selected: selected,
          selectedColor: Colors.black,
          backgroundColor: Colors.grey.shade300,
          label: Text(
            opt,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
          onSelected: (_) => onSelect(opt),
        );
      }).toList(),
    );
  }

  Widget _chipSelectorMulti(List<String> options, List<String> target) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final bool selected = target.contains(opt);
        return FilterChip(
          selected: selected,
          selectedColor: Colors.black,
          backgroundColor: Colors.grey.shade300,
          label: Text(
            opt,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
            ),
          ),
          onSelected: (v) {
            setState(() {
              if (v) {
                target.add(opt);
              } else {
                target.remove(opt);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You pay the cleaner only after the job is fully completed.\n\n"
        "A small \$9.99 booking fee guarantees your appointment, locks the time slot, "
        "and ensures a trusted professional is dispatched to your property.\n\n"
        "Your Airbnb is in safe hands — we deliver quality, every single time.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: confirmGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: child,
    );
  }
}
