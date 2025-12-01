import 'package:flutter/material.dart';

class PostConstructionBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const PostConstructionBookingScreen({
    super.key,
    required this.item,
  });

  @override
  State<PostConstructionBookingScreen> createState() =>
      _PostConstructionBookingScreenState();
}

class _PostConstructionBookingScreenState
    extends State<PostConstructionBookingScreen> {
  // COLORS
  final Color whatsappGreen = const Color(0xFF25D366);
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // STATE
  String? selectedDate;
  String? selectedTime;

  String? selectedPropertyType;
  String? selectedMessLevel;

  bool crewOnSite = false;
  bool debrisRemovalNeeded = false;

  List<String> selectedExtras = [];

  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9:00 AM - 12:00 PM",
    "12:00 PM - 3:00 PM",
    "3:00 PM - 6:00 PM",
    "6:00 PM - 9:00 PM",
  ];

  final List<String> propertyTypes = [
    "House",
    "Apartment",
    "Office",
    "Other",
  ];

  final List<String> messLevels = [
    "Light dust",
    "Medium",
    "Heavy (renovation)",
  ];

  final List<String> extraOptions = [
    "Inside windows",
    "Outside windows",
    "Cabinet interior",
    "Cabinet exterior",
    "Fridge interior",
    "Oven interior",
    "Balcony / patio",
    "Garage sweep",
    "Floor stain removal",
  ];

  @override
  void initState() {
    super.initState();

    // GENERATE 3 DAYS
    final now = DateTime.now();
    nextThreeDays = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final int minPrice = widget.item["minPrice"]?.toInt() ?? 200;
    final int maxPrice = widget.item["maxPrice"]?.toInt() ?? 400;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Address"),
            _addressField(),
            const SizedBox(height: 20),
            _title("Property type"),
            _chipSelector(propertyTypes, selectedPropertyType, (v) {
              setState(() => selectedPropertyType = v);
            }),
            const SizedBox(height: 20),
            _title("Mess level"),
            _chipSelector(messLevels, selectedMessLevel, (v) {
              setState(() => selectedMessLevel = v);
            }),
            const SizedBox(height: 20),
            _title("Construction crew on site?"),
            _yesNoRow(
              value: crewOnSite,
              onYes: () => setState(() => crewOnSite = true),
              onNo: () => setState(() => crewOnSite = false),
            ),
            const SizedBox(height: 20),
            _title("Need trash / debris removal?"),
            _yesNoRow(
              value: debrisRemovalNeeded,
              onYes: () => setState(() => debrisRemovalNeeded = true),
              onNo: () => setState(() => debrisRemovalNeeded = false),
            ),
            const SizedBox(height: 20),
            _title("Extra tasks"),
            _extraTasksChips(),
            const SizedBox(height: 20),
            _title("Select date"),
            _dateSelector(),
            const SizedBox(height: 20),
            _title("Select time"),
            _timeSelector(),
            const SizedBox(height: 20),
            _title("Notes (optional)"),
            _notesField(),
            const SizedBox(height: 25),
            _estimatedPriceBlock(minPrice, maxPrice),
            const SizedBox(height: 20),
            const SizedBox(height: 25),
            _confirmButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --------------------------
  // HEADERS
  // --------------------------
  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  // --------------------------
  // ADDRESS
  // --------------------------
  Widget _addressField() => _card(
        child: TextField(
          controller: addressCtrl,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: "Enter service address",
            contentPadding: EdgeInsets.all(14),
            border: InputBorder.none,
          ),
        ),
      );

  // --------------------------
  // CHIP SELECTOR
  // --------------------------
  Widget _chipSelector(
      List<String> options, String? selected, Function(String) onSelect) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((o) {
            final bool active = selected == o;
            return ChoiceChip(
              selected: active,
              label: Text(
                o,
                style: TextStyle(color: active ? Colors.white : Colors.black87),
              ),
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => onSelect(o),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --------------------------
  // YES / NO
  // --------------------------
  Widget _yesNoRow({
    required bool value,
    required VoidCallback onYes,
    required VoidCallback onNo,
  }) {
    return Row(
      children: [
        ChoiceChip(
          label: Text(
            "Yes",
            style: TextStyle(
              color: value ? Colors.white : Colors.black,
            ),
          ),
          selected: value,
          selectedColor: darkGreen,
          backgroundColor: Colors.grey.shade200,
          onSelected: (_) => onYes(),
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: Text(
            "No",
            style: TextStyle(
              color: !value ? Colors.white : Colors.black,
            ),
          ),
          selected: !value,
          selectedColor: darkGreen,
          backgroundColor: Colors.grey.shade200,
          onSelected: (_) => onNo(),
        ),
      ],
    );
  }

  // --------------------------
  // EXTRAS CHIPS
  // --------------------------
  Widget _extraTasksChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: extraOptions.map((task) {
            final bool active = selectedExtras.contains(task);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (active) {
                    selectedExtras.remove(task);
                  } else {
                    selectedExtras.add(task);
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? darkGreen : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task,
                  style: TextStyle(
                    color: active ? Colors.white : Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --------------------------
  // DATE SELECTOR
  // --------------------------
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final active = selectedDate == d;
            return ChoiceChip(
              selected: active,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(color: active ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --------------------------
  // TIME SELECTOR
  // --------------------------
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((t) {
            final active = selectedTime == t;
            return ChoiceChip(
              selected: active,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                t,
                style: TextStyle(color: active ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedTime = t),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --------------------------
  // NOTES
  // --------------------------
  Widget _notesField() => _card(
        child: TextField(
          controller: notesCtrl,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Any additional details…",
            contentPadding: EdgeInsets.all(14),
            border: InputBorder.none,
          ),
        ),
      );

  // --------------------------
  // PRICE BLOCK
  // --------------------------
  Widget _estimatedPriceBlock(int min, int max) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$190 – \$390\n\n"
        "Post-construction cleaning is more detailed due to dust, paint, and debris. "
        "Your final price depends on your selections and property condition.",
        style: const TextStyle(
          fontSize: 15,
          height: 1.4,
        ),
      ),
    );
  }

  // --------------------------
  // CONFIRM BUTTON
  // --------------------------
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: whatsappGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Booking sent!")),
          );
        },
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // --------------------------
  // CARD WRAPPER
  // --------------------------
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
          )
        ],
      ),
      child: child,
    );
  }
}
