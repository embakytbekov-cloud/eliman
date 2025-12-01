import 'package:flutter/material.dart';

class GutterCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const GutterCleaningBookingScreen({super.key, required this.item});

  @override
  State<GutterCleaningBookingScreen> createState() =>
      _GutterCleaningBookingScreenState();
}

class _GutterCleaningBookingScreenState
    extends State<GutterCleaningBookingScreen> {
  // COLORS (WIBI)
  final Color accent = const Color(0xFF23A373); // Dark Green
  final Color confirmGreen = const Color(0xFF25D366); // WhatsApp Button
  final Color softGreen = const Color(0xFFDFF3E8); // Light Green Background

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // HOME TYPE
  String? homeType;
  final List<String> homeTypes = [
    "Single-family house",
    "Townhouse",
    "2–3 unit building",
    "Small apartment building",
    "Other",
  ];

  // STORIES
  int stories = 1;

  // GUTTER DIRT LEVEL
  String? dirtLevel;
  final List<String> dirtLevels = [
    "Light debris",
    "Medium debris",
    "Heavy / clogged",
  ];

  // ROOF ACCESS
  String? roofAccess;
  final List<String> accessTypes = [
    "Easy access",
    "Medium",
    "Hard / steep roof",
  ];

  // EXTRA TASKS
  List<String> selectedExtras = [];
  final List<String> extraTasks = [
    "Downspout flushing",
    "Gutter guards cleaning",
    "Haul away debris",
    "Roof edge blow-off",
    "Minor gutter leak check",
    "Before/after photos",
  ];

  // DATE — 3 days
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
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _addressField(),
            const SizedBox(height: 25),
            _title("Home Type"),
            _chips(homeTypes, homeType, (v) => setState(() => homeType = v)),
            const SizedBox(height: 25),
            _title("How many stories?"),
            _storySelector(),
            const SizedBox(height: 25),
            _title("Gutter Condition"),
            _chips(dirtLevels, dirtLevel, (v) => setState(() => dirtLevel = v)),
            const SizedBox(height: 25),
            _title("Roof Access"),
            _chips(
                accessTypes, roofAccess, (v) => setState(() => roofAccess = v)),
            const SizedBox(height: 25),
            _title("Extra Tasks"),
            _multiChips(extraTasks),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("Additional Notes"),
            _notesField(),
            const SizedBox(height: 30),
            _estimatedPriceBlock(),
            const SizedBox(height: 30),
            const SizedBox(height: 35),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // TITLE
  // ------------------------------
  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  // ------------------------------
  // ADDRESS FIELD
  // ------------------------------
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

  // ------------------------------
  // CHIPS — single select
  // ------------------------------
  Widget _chips(
      List<String> options, String? selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final bool isSelected = opt == selected;
        return GestureDetector(
          onTap: () => onTap(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ------------------------------
  // MULTIPLE CHIPS
  // ------------------------------
  Widget _multiChips(List<String> options) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((task) {
        final bool selected = selectedExtras.contains(task);
        return GestureDetector(
          onTap: () {
            setState(() {
              selected ? selectedExtras.remove(task) : selectedExtras.add(task);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              task,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ------------------------------
  // STORY SELECTOR (1–4)
  // ------------------------------
  Widget _storySelector() {
    return Row(
      children: List.generate(4, (i) {
        final number = i + 1;
        final isSelected = stories == number;

        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => setState(() => stories = number),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? accent : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "$number",
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ------------------------------
  // DATE SELECTOR (3 days)
  // ------------------------------
  Widget _dateSelector() {
    return Wrap(
      spacing: 10,
      children: nextThreeDays.map((d) {
        final selected = selectedDate == d;
        return GestureDetector(
          onTap: () => setState(() => selectedDate = d),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: selected ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              d,
              style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ------------------------------
  // TIME SELECTOR
  // ------------------------------
  Widget _timeSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: timeSlots.map((slot) {
        final isSelected = selectedTime == slot;

        return GestureDetector(
          onTap: () => setState(() => selectedTime = slot),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              slot,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ------------------------------
  // NOTES
  // ------------------------------
  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
            hintText: "Gate code, trees, parking, roof access…",
            border: InputBorder.none),
      ),
    );
  }

  // ------------------------------
  // ESTIMATED PRICE BLOCK
  // ------------------------------
  Widget _estimatedPriceBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$80 – \$250\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.45),
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
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }

  // ------------------------------
  // CARD HELPER
  // ------------------------------
  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
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
}
