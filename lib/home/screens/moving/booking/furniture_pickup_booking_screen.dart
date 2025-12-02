import 'package:flutter/material.dart';

class FurniturePickupBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const FurniturePickupBookingScreen({super.key, required this.item});

  @override
  State<FurniturePickupBookingScreen> createState() =>
      _FurniturePickupBookingScreenState();
}

class _FurniturePickupBookingScreenState
    extends State<FurniturePickupBookingScreen> {
  // COLORS WIBIM STYLE
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp green
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController pickupCtrl = TextEditingController();
  final TextEditingController dropoffCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // WHAT NEEDS TO BE DELIVERED — TAGS
  final List<String> itemTypes = [
    "Couch",
    "Mattress",
    "Bed frame",
    "Dining table",
    "Chairs",
    "Desk",
    "Dresser",
    "Wardrobe",
    "TV",
    "Boxes",
    "Other",
  ];
  final Set<String> selectedItemTypes = {};

  // HOW MANY ITEMS
  final List<String> itemCountOptions = [
    "1 item",
    "2 items",
    "3–5 items",
    "6–10 items",
    "10+ items",
  ];
  String? selectedItemCount;

  // STAIRS
  final List<String> stairOptions = [
    "No stairs",
    "1 flight",
    "2+ flights",
    "Elevator available",
  ];
  String? selectedStairs;

  // ASSEMBLY / DISASSEMBLY
  final List<String> assemblyOptions = [
    "No",
    "Assembly only",
    "Disassembly only",
    "Both",
  ];
  String? selectedAssembly;

  // DAY / TIME
  late List<DateTime> nextThreeDays;
  DateTime? selectedDay;

  final List<String> timeSlots = [
    "9:00 AM – 12:00 PM",
    "12:00 PM – 3:00 PM",
    "3:00 PM – 6:00 PM",
    "6:00 PM – 9:00 PM",
  ];
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    nextThreeDays = [
      DateTime(now.year, now.month, now.day),
      DateTime(now.year, now.month, now.day + 1),
      DateTime(now.year, now.month, now.day + 2),
    ];
    selectedDay = nextThreeDays.first;
  }

  String _formatDate(DateTime d) => "${d.month}/${d.day}/${d.year}";

  String _buildPriceRange() {
    final min = widget.item["minPrice"];
    final max = widget.item["maxPrice"];
    if (min is num && max is num) {
      return "\$${min.toInt()} – \$${max.toInt()}";
    }
    return "\$XX – \$XX";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Furniture Pickup & Delivery",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Pickup Address"),
            _whiteCard(
              child: TextField(
                controller: pickupCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Where should we pick up the item(s)?",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _title("Drop-off Address"),
            _whiteCard(
              child: TextField(
                controller: dropoffCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Where should we deliver the item(s)?",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _title("What needs to be delivered?"),
            const SizedBox(height: 8),
            _chipsWrap(
              options: itemTypes,
              selected: selectedItemTypes,
              onTap: (value) {
                setState(() {
                  if (selectedItemTypes.contains(value)) {
                    selectedItemTypes.remove(value);
                  } else {
                    selectedItemTypes.add(value);
                  }
                });
              },
              multiSelect: true,
            ),
            const SizedBox(height: 24),
            _title("How many items?"),
            const SizedBox(height: 8),
            _singleSelectChips(
              options: itemCountOptions,
              selectedValue: selectedItemCount,
              onChanged: (v) => setState(() => selectedItemCount = v),
            ),
            const SizedBox(height: 24),
            _title("Any stairs at pickup or drop-off?"),
            const SizedBox(height: 8),
            _singleSelectChips(
              options: stairOptions,
              selectedValue: selectedStairs,
              onChanged: (v) => setState(() => selectedStairs = v),
            ),
            const SizedBox(height: 24),
            _title("Assembly / Disassembly needed?"),
            const SizedBox(height: 8),
            _singleSelectChips(
              options: assemblyOptions,
              selectedValue: selectedAssembly,
              onChanged: (v) => setState(() => selectedAssembly = v),
            ),
            const SizedBox(height: 24),
            _title("Select Day"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Row(
                children: nextThreeDays.map((day) {
                  final bool isSelected =
                      selectedDay != null && _isSameDay(selectedDay!, day);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() => selectedDay = day);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? darkGreen : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              _formatDate(day),
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            _title("Select Time"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: timeSlots.map((slot) {
                  final bool isSelected = selectedTime == slot;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTime = slot),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? darkGreen : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        slot,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            _title("Extra Notes"),
            _whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText:
                      "Gate code, building instructions, contact person...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 26),
            _estimatedPriceBlock(),
            const SizedBox(height: 20),
            _trustBlock(),
            const SizedBox(height: 26),
            _confirmButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ---------- HELPERS ----------

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _whiteCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  // MULTISELECT CHIPS (What needs to be delivered)
  Widget _chipsWrap({
    required List<String> options,
    required Set<String> selected,
    required Function(String) onTap,
    bool multiSelect = true,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final bool isSelected = selected.contains(opt);
        return GestureDetector(
          onTap: () => onTap(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isSelected ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              opt,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // SINGLE SELECT CHIPS
  Widget _singleSelectChips({
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String> onChanged,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final bool isSelected = selectedValue == opt;
        return GestureDetector(
          onTap: () => onChanged(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isSelected ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              opt,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ESTIMATED PRICE BLOCK
  Widget _estimatedPriceBlock() {
    final rangeText = _buildPriceRange();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: $rangeText\n\n"
        "You'll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and starts "
        "searching for the best available movers in your area.\n\n"
        "We'll notify you as soon as someone accepts your request.",
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  // TRUST BLOCK (ярко зелёный)
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: darkGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You pay the movers only after the job is fully completed.\n\n"
        "Your belongings stay safe — WiBIM sends only trusted, background-"
        "checked professionals.\n\n"
        "Fast. Reliable. Protected.",
        style: TextStyle(
          fontSize: 14,
          height: 1.4,
          color: Colors.white,
        ),
      ),
    );
  }

  // CONFIRM BUTTON
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Furniture pickup booking sent!"),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonGreen,
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
}
