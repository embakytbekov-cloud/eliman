import 'package:flutter/material.dart';

class RefrigeratorRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const RefrigeratorRepairBookingScreen({
    super.key,
    required this.item,
  });

  @override
  State<RefrigeratorRepairBookingScreen> createState() =>
      _RefrigeratorRepairBookingScreenState();
}

class _RefrigeratorRepairBookingScreenState
    extends State<RefrigeratorRepairBookingScreen> {
  // COLORS WIBI STYLE
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp style
  final Color darkGreen = const Color(0xFF2B6E4F); // accents
  final Color softGreen = const Color(0xFFDFF3E8); // info blocks

  // ADDRESS / NOTES
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // FRIDGE TYPE
  String? fridgeType;
  final List<String> fridgeTypes = [
    "Top freezer",
    "Bottom freezer",
    "Side-by-side",
    "French door",
    "Mini fridge",
  ];

  // ISSUE TYPE
  String? issueType;
  final List<String> issueTypes = [
    "Not cooling",
    "Freezing food",
    "Ice maker issue",
    "Leaking water",
    "Loud / strange noise",
    "Door seal problem",
    "Other",
  ];

  // AGE RANGE
  String? ageRange;
  final List<String> ageRanges = [
    "0–3 years",
    "3–7 years",
    "7+ years",
  ];

  // BUILT-IN OR FREESTANDING
  bool isBuiltIn = false;

  // EXTRA APPLIANCES (same visit)
  int extraAppliances = 0;

  // DATE / TIME
  String? selectedDate;
  late List<String> nextThreeDays;

  String? selectedTime;
  final List<String> timeSlots = const [
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
    // Достаём min/max из item (на всякий случай приводим к num -> double)
    final double minPrice = (widget.item["minPrice"] as num?)?.toDouble() ?? 90;
    final double maxPrice =
        (widget.item["maxPrice"] as num?)?.toDouble() ?? 220;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Refrigerator Repair",
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
            _title("Service Address"),
            _addressField(),
            const SizedBox(height: 22),
            _title("Refrigerator Type"),
            _chipWrap(
              options: fridgeTypes,
              selectedValue: fridgeType,
              onSelected: (val) => setState(() => fridgeType = val),
            ),
            const SizedBox(height: 22),
            _title("What’s the main issue?"),
            _chipWrap(
              options: issueTypes,
              selectedValue: issueType,
              onSelected: (val) => setState(() => issueType = val),
            ),
            const SizedBox(height: 22),
            _title("Approximate Age of Fridge"),
            _chipWrap(
              options: ageRanges,
              selectedValue: ageRange,
              onSelected: (val) => setState(() => ageRange = val),
            ),
            const SizedBox(height: 22),
            _title("Installation Type"),
            _card(
              child: SwitchListTile(
                title: const Text(
                  "Built-in refrigerator",
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: const Text(
                  "Turn this ON if your fridge is built into cabinetry.",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                value: isBuiltIn,
                activeColor: darkGreen,
                onChanged: (v) => setState(() => isBuiltIn = v),
              ),
            ),
            const SizedBox(height: 22),
            _title("Additional Appliances (same visit)"),
            _card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "How many extra appliances should the technician check?\n"
                        "(Washer, dryer, dishwasher, etc.)",
                        style: TextStyle(fontSize: 14, height: 1.3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        _circleBtn(Icons.remove, () {
                          if (extraAppliances > 0) {
                            setState(() => extraAppliances--);
                          }
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "$extraAppliances",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _circleBtn(Icons.add, () {
                          setState(() => extraAppliances++);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 22),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 22),
            _title("Extra Notes (optional)"),
            _notesField(),
            const SizedBox(height: 26),
            _priceBlock(minPrice, maxPrice),
            const SizedBox(height: 30),
            _confirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // BASIC TITLE
  // ------------------------------
  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ------------------------------
  // ADDRESS FIELD
  // ------------------------------
  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        maxLines: 2,
        decoration: const InputDecoration(
          hintText: "Enter service address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ------------------------------
  // NOTES FIELD
  // ------------------------------
  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Describe the issue, error codes, or noises...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ------------------------------
  // GENERIC CHIP WRAP (single select)
  // ------------------------------
  Widget _chipWrap({
    required List<String> options,
    required String? selectedValue,
    required void Function(String value) onSelected,
  }) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: options.map((opt) {
            final bool isSelected = selectedValue == opt;
            return ChoiceChip(
              label: Text(
                opt,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selected: isSelected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => onSelected(opt),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // DATE SELECTOR (3 DAYS)
  // ------------------------------
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              label: Text(
                d,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontSize: 13,
                ),
              ),
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // TIME SELECTOR
  // ------------------------------
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // PRICE BLOCK (WIBI STYLE)
  // ------------------------------
  Widget _priceBlock(double minPrice, double maxPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$${minPrice.toInt()} – \$${maxPrice.toInt()}\n\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and starts the search "
        "for the best available technician in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  // ------------------------------
  // CONFIRM BUTTON
  // ------------------------------
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Refrigerator repair booking sent!"),
            ),
          );
        },
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

  // ------------------------------
  // CARD + CIRCLE BUTTON HELPERS
  // ------------------------------
  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
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
          color: darkGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
