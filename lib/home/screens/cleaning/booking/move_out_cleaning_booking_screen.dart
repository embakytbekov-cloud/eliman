import 'package:flutter/material.dart';

class MoveOutCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const MoveOutCleaningBookingScreen({super.key, required this.item});

  @override
  State<MoveOutCleaningBookingScreen> createState() =>
      _MoveOutCleaningBookingScreenState();
}

class _MoveOutCleaningBookingScreenState
    extends State<MoveOutCleaningBookingScreen> {
  // COLORS
  final Color buttonGreen = const Color(0xFF25D366);
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();

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

  // ROOMS
  int bedrooms = 1;
  int bathrooms = 1;

  // EXTRA TASKS (Airbnb Style)
  List<String> selectedExtras = [];

  final List<String> extraOptions = [
    "Inside Oven",
    "Inside Fridge",
    "Cabinet Wipe",
    "Closet Cleaning",
    "Window Interior",
    "Wall Wipe",
    "Baseboard Scrub",
    "Patio/Balcony clean",
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
            _title("Select Date"),
            _dateButtons(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("Bedrooms"),
            _roomSelector(true),
            const SizedBox(height: 25),
            _title("Bathrooms"),
            _roomSelector(false),
            const SizedBox(height: 25),
            _title("Extra Tasks"),
            _extraTasksChips(),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 40),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // =====================
  // REUSABLE WIDGETS
  // =====================

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
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
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.07),
          ),
        ],
      ),
      child: child,
    );
  }

  // ADDRESS FIELD
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

  // DATE SELECTOR (3 days)
  Widget _dateButtons() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final isSelected = selectedDate == d;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TIME SELECTOR
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final isSelected = selectedTime == slot;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // BEDROOM / BATHROOM SELECTOR
  Widget _roomSelector(bool bedroom) {
    int value = bedroom ? bedrooms : bathrooms;

    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(bedroom ? "Bedrooms" : "Bathrooms",
                style: const TextStyle(fontSize: 16)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (value > 1) {
                    setState(() {
                      if (bedroom)
                        bedrooms--;
                      else
                        bathrooms--;
                    });
                  }
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _circleBtn(Icons.add, () {
                  setState(() {
                    if (bedroom)
                      bedrooms++;
                    else
                      bathrooms++;
                  });
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
          color: darkGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // EXTRA TASKS (CHIPS)
  Widget _extraTasksChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: extraOptions.map((task) {
            final selected = selectedExtras.contains(task);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selected) {
                    selectedExtras.remove(task);
                  } else {
                    selectedExtras.add(task);
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? darkGreen : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  task,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TRUST BLOCK
  // TRUST BLOCK — BRIGHT GREEN
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$50 – \$110\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search "
        "for the best available professional in your area.\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(
          fontSize: 15,
          height: 1.4,
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // CONFIRM BUTTON
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
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
