import 'package:flutter/material.dart';

class DeepCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DeepCleaningBookingScreen({super.key, required this.item});

  @override
  State<DeepCleaningBookingScreen> createState() =>
      _DeepCleaningBookingScreenState();
}

class _DeepCleaningBookingScreenState extends State<DeepCleaningBookingScreen> {
  final Color accent = const Color(0xFF1C6E54);

// ADDRESS
  final TextEditingController addressCtrl = TextEditingController();

// BEDROOM / BATHROOM
  int bedrooms = 1;
  int bathrooms = 1;

// EXTRA TASKS
  List<String> selectedExtras = [];

  final List<Map<String, dynamic>> extraOptions = [
    {"title": "Fridge Deep Clean"},
    {"title": "Oven Deep Clean"},
    {"title": "Window Interior"},
    {"title": "Cabinet Interior"},
    {"title": "Baseboard Scrub"},
    {"title": "Wall Spot Cleaning"},
  ];

// DATE — only 3 days
  String? selectedDate;
  late List<String> nextThreeDays;

// TIME SLOTS
  String? selectedTime;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM"
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
            const SizedBox(height: 20),
            _title("Select Date"),
            _dateButtons(),
            const SizedBox(height: 20),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 20),
            _title("Bedrooms"),
            _roomSelector(isBedroom: true),
            const SizedBox(height: 20),
            _title("Bathrooms"),
            _roomSelector(isBedroom: false),
            const SizedBox(height: 20),
            _title("Extra Tasks"),
            _extraTasksCard(),
            const SizedBox(height: 25),
            _estimatedPrice(),
            const SizedBox(height: 25),
            _marketingBox(),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

// ----------------------------------------------------
  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(14),
          hintText: "Enter service address",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _dateButtons() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final isSelected = selectedDate == d;

            return ChoiceChip(
              selected: isSelected,
              label: Text(
                d,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final isSelected = selectedTime == slot;

            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selected: isSelected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _roomSelector({required bool isBedroom}) {
    int value = isBedroom ? bedrooms : bathrooms;

    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(isBedroom ? "Bedrooms" : "Bathrooms",
                style: const TextStyle(fontSize: 16)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (value > 1) {
                    setState(() {
                      if (isBedroom)
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
                    if (isBedroom)
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
        trailing: Icon(Icons.expand_more, color: accent),
        onTap: _openExtraTaskSheet,
      ),
    );
  }

  void _openExtraTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Extra Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 18),
              ...extraOptions.map((opt) {
                final title = opt["title"];
                final selected = selectedExtras.contains(title);

                return CheckboxListTile(
                  title: Text(title),
                  value: selected,
                  onChanged: (v) {
                    setState(() {
                      if (v == true) {
                        selectedExtras.add(title);
                      } else {
                        selectedExtras.remove(title);
                      }
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
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

  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$150 – \$400",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _marketingBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        "You pay the cleaner only after the job is fully completed.\n\n"
        "A small \$9.99 booking fee guarantees your appointment, locks the time slot, "
        "and ensures a trusted professional is dispatched to your address.\n\n"
        "Deep cleaning is thorough, detailed, and handled by experts — your home will feel brand new.",
        style: TextStyle(
          fontSize: 15,
          height: 1.45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
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

// ----------------------------------------------------
  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
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
}
