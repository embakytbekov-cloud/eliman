import 'package:flutter/material.dart';

class StandardCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const StandardCleaningBookingScreen({super.key, required this.item});

  @override
  State<StandardCleaningBookingScreen> createState() =>
      _StandardCleaningBookingScreen();
}

class _StandardCleaningBookingScreen
    extends State<StandardCleaningBookingScreen> {
// Colors
  final Color buttonGreen = const Color(0xFF25D366); // Confirm button
  final Color darkGreen = const Color(0xFF2B6E4F); // selectors, accents
  final Color softGreen = const Color(0xFFDFF3E8); // info blocks

  final TextEditingController addressCtrl = TextEditingController();

  int bedrooms = 1;
  int bathrooms = 1;

  List<String> selectedExtras = [];

  final List<String> extraOptions = [
    "Fridge Cleaning",
    "Oven Cleaning",
    "Window Interior",
    "Cabinet Exterior",
    "Balcony Sweep",
    "Baseboard Wipe",
  ];

  String? selectedDate;
  late List<String> nextThreeDays;

  String? selectedTime;

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
            _extraTasksCard(),
            const SizedBox(height: 30),
            _estimatedPrice(),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 40),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      );

  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          hintText: "Enter service address",
          contentPadding: EdgeInsets.all(14),
          border: InputBorder.none,
        ),
      ),
    );
  }

// DATE
  Widget _dateButtons() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
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

// TIME
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
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

// BED / BATH
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
                        fontSize: 17, fontWeight: FontWeight.w600),
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
        decoration: BoxDecoration(
          color: darkGreen,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

// EXTRA TASKS
  Widget _extraTasksCard() {
    return _card(
      child: ListTile(
        title: const Text(
          "Extra Tasks",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          selectedExtras.isEmpty
              ? "None selected"
              : "Selected: ${selectedExtras.length}",
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Icon(Icons.expand_more, color: darkGreen),
        onTap: _openExtrasSheet,
      ),
    );
  }

  void _openExtrasSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Extra Tasks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 15),
              ...extraOptions.map((title) {
                return CheckboxListTile(
                  title: Text(title),
                  value: selectedExtras.contains(title),
                  activeColor: darkGreen,
                  onChanged: (v) {
                    setState(() {
                      if (v == true)
                        selectedExtras.add(title);
                      else
                        selectedExtras.remove(title);
                    });
                  },
                );
              }),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// PRICE
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$80 – \$190",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
        "You pay the cleaner only after the job is fully completed.\n\n"
        "A small \$9.99 booking fee guarantees your appointment, locks the time slot, "
        "and ensures a trusted professional is dispatched to your address.\n\n"
        "Your home is in safe hands — we deliver quality every single time.",
        style: TextStyle(fontSize: 15, height: 1.4),
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
