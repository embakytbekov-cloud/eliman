import 'package:flutter/material.dart';

class CarpetCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const CarpetCleaningBookingScreen({super.key, required this.item});

  @override
  State<CarpetCleaningBookingScreen> createState() =>
      _CarpetCleaningBookingScreenState();
}

class _CarpetCleaningBookingScreenState
    extends State<CarpetCleaningBookingScreen> {
  // COLORS
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp-style
  final Color darkGreen = const Color(0xFF2B6E4F); // accents
  final Color softGreen = const Color(0xFFDFF3E8); // info blocks

  // ADDRESS / NOTES
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // DATE
  String? selectedDate;
  late List<String> nextThreeDays;

  // TIME
  String? selectedTime;
  final List<String> timeSlots = const [
    "9:00 AM – 12:00 PM",
    "12:00 PM – 3:00 PM",
    "3:00 PM – 6:00 PM",
    "6:00 PM – 9:00 PM",
  ];

  // CARPET AREAS (multi-select)
  final List<String> carpetAreas = const [
    "Living room carpet",
    "Bedroom carpet",
    "Hallway runner",
    "Stairs carpet",
    "Small area rug",
    "Medium area rug",
    "Large area rug",
  ];
  List<String> selectedAreas = [];

  // CONDITION (single-select)
  final List<String> conditions = const [
    "Light dirt",
    "Moderate dirt",
    "Heavy soil",
    "Pet stains",
    "Odor removal needed",
  ];
  String? selectedCondition;

  // SIZE (single-select)
  final List<String> areaSizes = const [
    "< 200 sq ft",
    "200 – 400 sq ft",
    "400 – 600 sq ft",
    "600+ sq ft",
  ];
  String? selectedAreaSize;

  // FURNITURE MOVING
  bool? moveFurniture; // null = not selected yet

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
  void dispose() {
    addressCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // берем цены из item, если есть
    final numMin = (widget.item["minPrice"] as num?) ?? 110;
    final numMax = (widget.item["maxPrice"] as num?) ?? 240;
    final String priceRange =
        "\$${numMin.toInt()} – \$${numMax.toInt()}"; // Estimated Price: $XX – $XX

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Carpet Cleaning",
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
                  hintText: "Enter service address",
                  contentPadding: EdgeInsets.all(14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 22),
            _title("Select Date"),
            _dateChips(),
            const SizedBox(height: 22),
            _title("Select Time"),
            _timeChips(),
            const SizedBox(height: 22),
            _title("Carpet Areas"),
            _areaChips(),
            const SizedBox(height: 22),
            _title("Carpet Condition"),
            _conditionChips(),
            const SizedBox(height: 22),
            _title("Approx. Area"),
            _sizeChips(),
            const SizedBox(height: 22),
            _title("Furniture Moving"),
            _furnitureChoice(),
            const SizedBox(height: 22),
            _title("Extra Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any stains, odors, or details…",
                  contentPadding: EdgeInsets.all(14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 26),
            _estimatedPriceBlock(priceRange),
            const SizedBox(height: 30),
            _confirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // COMMON TITLE
  // ------------------------------
  Widget _title(String t) {
    return Text(
      t,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ------------------------------
  // DATE CHIPS (3 days)
  // ------------------------------
  Widget _dateChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              onSelected: (_) {
                setState(() => selectedDate = d);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // TIME CHIPS
  // ------------------------------
  Widget _timeChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              onSelected: (_) {
                setState(() => selectedTime = slot);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // CARPET AREAS (multi-select chips)
  // ------------------------------
  Widget _areaChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: carpetAreas.map((area) {
            final selected = selectedAreas.contains(area);
            return FilterChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              checkmarkColor: Colors.white,
              label: Text(
                area,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              onSelected: (v) {
                setState(() {
                  if (v) {
                    selectedAreas.add(area);
                  } else {
                    selectedAreas.remove(area);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // CONDITION (single-select chips)
  // ------------------------------
  Widget _conditionChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: conditions.map((c) {
            final selected = selectedCondition == c;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                c,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              onSelected: (_) {
                setState(() => selectedCondition = c);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // AREA SIZE (single-select chips)
  // ------------------------------
  Widget _sizeChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: areaSizes.map((s) {
            final selected = selectedAreaSize == s;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                s,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              onSelected: (_) {
                setState(() => selectedAreaSize = s);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // FURNITURE MOVING (Yes / No)
  // ------------------------------
  Widget _furnitureChoice() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                "Should we move light furniture?",
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                _choicePill(
                  label: "Yes",
                  selected: moveFurniture == true,
                  onTap: () => setState(() => moveFurniture = true),
                ),
                const SizedBox(width: 8),
                _choicePill(
                  label: "No",
                  selected: moveFurniture == false,
                  onTap: () => setState(() => moveFurniture = false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _choicePill({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? darkGreen : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // ESTIMATED PRICE BLOCK (WIBI TEXT)
  // ------------------------------
  Widget _estimatedPriceBlock(String priceRange) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: $priceRange\n\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search "
        "for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: const TextStyle(
          fontSize: 15,
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
          if (addressCtrl.text.trim().isEmpty ||
              selectedDate == null ||
              selectedTime == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill address, date and time."),
              ),
            );
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Carpet cleaning booking sent!"),
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
  // CARD WRAPPER
  // ------------------------------
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
