import 'package:flutter/material.dart';

class FullApartmentMoveBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const FullApartmentMoveBookingScreen({
    super.key,
    required this.item,
  });

  @override
  State<FullApartmentMoveBookingScreen> createState() =>
      _FullApartmentMoveBookingScreenState();
}

class _FullApartmentMoveBookingScreenState
    extends State<FullApartmentMoveBookingScreen> {
  // COLORS WiBIM STYLE
  final Color buttonGreen =
      const Color(0xFF25D366); // Confirm button (WhatsApp)
  final Color darkGreen = const Color(0xFF2B6E4F); // selectors, chips
  final Color softGreen = const Color(0xFFDFF3E8); // info blocks

  // CONTROLLERS
  final TextEditingController fromAddressCtrl = TextEditingController();
  final TextEditingController toAddressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // APARTMENT SIZE
  String? apartmentSize;
  final List<String> apartmentSizes = [
    "Studio",
    "1 Bedroom",
    "2 Bedroom",
    "3 Bedroom",
    "4+ Bedroom",
    "House",
  ];

  // FLOOR + ELEVATOR
  int floorNumber = 1;
  bool elevatorAvailable = false;

  // TRUCK / PACKING
  bool needTruck = true;
  bool needPacking = false;

  // HEAVY ITEMS
  final List<String> heavyOptions = [
    "Piano",
    "Safe",
    "Treadmill",
    "Large couch",
    "Refrigerator",
    "Washer/Dryer",
  ];
  List<String> selectedHeavyItems = [];

  // MOVERS COUNT
  int moversCount = 2;

  // DATE (3 days only)
  String? selectedDate;
  late List<String> nextThreeDays;

  // TIME
  String? selectedTime;
  final List<String> timeSlots = [
    "9:00 AM – 12:00 PM",
    "12:00 PM – 3:00 PM",
    "3:00 PM – 6:00 PM",
    "6:00 PM – 9:00 PM",
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

    // По умолчанию — сегодня
    selectedDate = nextThreeDays.first;
  }

  @override
  Widget build(BuildContext context) {
    // Берём цены из item, если пришли
    final double minPrice =
        (widget.item["minPrice"] ?? 300).toDouble(); // fallback 300
    final double maxPrice =
        (widget.item["maxPrice"] ?? 800).toDouble(); // fallback 800

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Full Apartment Move",
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
            // FROM ADDRESS
            _title("From address"),
            _whiteCard(
              child: TextField(
                controller: fromAddressCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Where are we moving from?",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 22),

            // TO ADDRESS
            _title("To address"),
            _whiteCard(
              child: TextField(
                controller: toAddressCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Where are we moving to?",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 22),

            // APARTMENT SIZE
            _title("Apartment size"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: apartmentSizes.map((size) {
                    final bool selected = apartmentSize == size;
                    return GestureDetector(
                      onTap: () => setState(() => apartmentSize = size),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? darkGreen : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // FLOOR + ELEVATOR
            _title("Floor & elevator"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Which floor?",
                          style: TextStyle(fontSize: 16),
                        ),
                        _smallNumberSelector(
                          value: floorNumber,
                          min: 1,
                          max: 10,
                          onChanged: (v) => setState(() => floorNumber = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        "Elevator available",
                        style: TextStyle(fontSize: 15),
                      ),
                      activeColor: darkGreen,
                      value: elevatorAvailable,
                      onChanged: (v) => setState(() => elevatorAvailable = v),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            // TRUCK NEEDED
            _title("Do you need our truck?"),
            const SizedBox(height: 8),
            Row(
              children: [
                _bigChoice(
                  "Yes, bring a truck",
                  needTruck == true,
                  () => setState(() => needTruck = true),
                ),
                const SizedBox(width: 10),
                _bigChoice(
                  "No, I have my own",
                  needTruck == false,
                  () => setState(() => needTruck = false),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // PACKING
            _title("Packing service"),
            const SizedBox(height: 8),
            Row(
              children: [
                _bigChoice(
                  "Include packing",
                  needPacking == true,
                  () => setState(() => needPacking = true),
                ),
                const SizedBox(width: 10),
                _bigChoice(
                  "No packing needed",
                  needPacking == false,
                  () => setState(() => needPacking = false),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // HEAVY ITEMS
            _title("Any heavy items?"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: heavyOptions.map((h) {
                    final bool selected = selectedHeavyItems.contains(h);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selected) {
                            selectedHeavyItems.remove(h);
                          } else {
                            selectedHeavyItems.add(h);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? darkGreen : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (selected)
                              const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              ),
                            if (selected) const SizedBox(width: 4),
                            Text(
                              h,
                              style: TextStyle(
                                fontSize: 13,
                                color: selected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // MOVERS COUNT
            _title("How many movers do you need?"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Movers",
                      style: TextStyle(fontSize: 16),
                    ),
                    _smallNumberSelector(
                      value: moversCount,
                      min: 2,
                      max: 4,
                      onChanged: (v) => setState(() => moversCount = v),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            // DATE
            _title("Select day"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  children: nextThreeDays.map((d) {
                    final bool selected = selectedDate == d;
                    return ChoiceChip(
                      selected: selected,
                      selectedColor: darkGreen,
                      backgroundColor: Colors.grey.shade200,
                      label: Text(
                        d,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                        ),
                      ),
                      onSelected: (_) => setState(() => selectedDate = d),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // TIME
            _title("Select time"),
            const SizedBox(height: 8),
            _whiteCard(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: timeSlots.map((slot) {
                    final bool selected = selectedTime == slot;
                    return GestureDetector(
                      onTap: () => setState(() => selectedTime = slot),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? darkGreen : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          slot,
                          style: TextStyle(
                            fontSize: 14,
                            color: selected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // NOTES
            _title("Extra notes (optional)"),
            _whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Building rules, elevator code, parking details...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 26),

            // ESTIMATED PRICE BLOCK
            _estimatedPriceBlock(minPrice, maxPrice),

            const SizedBox(height: 26),

            // CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // later: send to Supabase / Telegram
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Full apartment move request sent!"),
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
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------- HELPERS ----------

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
      margin: const EdgeInsets.only(top: 8),
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

  Widget _bigChoice(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? darkGreen : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _smallNumberSelector({
    required int value,
    required int min,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      children: [
        _circleIconButton(
          Icons.remove,
          onTap: () {
            if (value > min) {
              onChanged(value - 1);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "$value",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _circleIconButton(
          Icons.add,
          onTap: () {
            if (value < max) {
              onChanged(value + 1);
            }
          },
        ),
      ],
    );
  }

  Widget _circleIconButton(IconData icon, {required VoidCallback onTap}) {
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

  Widget _estimatedPriceBlock(double min, double max) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$${min.toInt()} – \$${max.toInt()}\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and starts the search "
        "for the best available moving team in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: const TextStyle(
          fontSize: 15,
          height: 1.4,
        ),
      ),
    );
  }
}
