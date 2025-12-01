import 'package:flutter/material.dart';

class SmallPaintingBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmallPaintingBookingScreen({super.key, required this.item});

  @override
  State<SmallPaintingBookingScreen> createState() =>
      _SmallPaintingBookingScreenState();
}

class _SmallPaintingBookingScreenState
    extends State<SmallPaintingBookingScreen> {
  // COLORS
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color whatsAppGreen = const Color(0xFF25D366);
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // VALUES
  String? roomType;
  int wallCount = 1;

  List<String> selectedAreas = [];
  List<String> selectedColors = [];

  bool needMaterials = false;

  // OPTIONS
  final List<String> areaOptions = [
    "Touch-up spots",
    "1 Wall",
    "2 Walls",
    "Accent wall",
    "Trim/Baseboards",
    "Door painting",
    "Window frame painting",
  ];

  final List<String> roomOptions = [
    "Living room",
    "Bedroom",
    "Kitchen",
    "Bathroom",
    "Hallway",
    "Office",
  ];

  final List<String> colorOptions = [
    "White",
    "Beige",
    "Gray",
    "Dark Gray",
    "Blue",
    "Custom color",
  ];

  // DAY / TIME
  String? selectedDay;
  String? selectedTime;

  List<String> nextThreeDays = [];

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

  // ---------------------------------------------------------
  // UI
  // ---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("Room Type"),
            _chipSingle(roomOptions, roomType, (v) {
              setState(() => roomType = v);
            }),
            const SizedBox(height: 25),
            _title("How Many Walls?"),
            _wallSelector(),
            const SizedBox(height: 25),
            _title("Painting Area"),
            _chipMulti(areaOptions, selectedAreas),
            const SizedBox(height: 25),
            _title("Color Choice"),
            _chipMulti(colorOptions, selectedColors),
            const SizedBox(height: 25),
            _title("Do you need us to bring paint & materials?"),
            _materialsSelector(),
            const SizedBox(height: 25),
            _title("Extra Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any extra details...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _estimatedPrice(),
            const SizedBox(height: 25),
            _trustBlock(),
            const SizedBox(height: 35),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // COMPONENTS
  // ---------------------------------------------------------

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
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  // ---------------- DATE SELECTOR -------------------
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDay == d;
            return ChoiceChip(
              label: Text(
                d,
                style: TextStyle(color: selected ? Colors.white : Colors.black),
              ),
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedDay = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------------- TIME SELECTOR -------------------
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(color: selected ? Colors.white : Colors.black),
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

  // ---------------- WALL COUNT SELECTOR -------------------
  Widget _wallSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Walls", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (wallCount > 1) setState(() => wallCount--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    wallCount.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                _circleBtn(Icons.add, () {
                  setState(() => wallCount++);
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
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  // ---------------- CHIP SELECTORS -------------------
  Widget _chipMulti(List<String> items, List<String> selectedList) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((v) {
        final selected = selectedList.contains(v);
        return GestureDetector(
          onTap: () {
            setState(() {
              selected ? selectedList.remove(v) : selectedList.add(v);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              v,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _chipSingle(
      List<String> items, String? selectedValue, void Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((v) {
        final selected = selectedValue == v;
        return GestureDetector(
          onTap: () => onTap(v),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              v,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ---------------- MATERIALS -------------------
  Widget _materialsSelector() {
    return Row(
      children: [
        _materialBtn("Yes", needMaterials == true, () {
          setState(() => needMaterials = true);
        }),
        const SizedBox(width: 12),
        _materialBtn("No", needMaterials == false, () {
          setState(() => needMaterials = false);
        }),
      ],
    );
  }

  Widget _materialBtn(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? darkGreen : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ---------------- PRICE -------------------
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$${widget.item["minPrice"]} – \$${widget.item["maxPrice"]}",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  // ---------------- TRUST -------------------
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You pay the handyman only after the job is fully completed.\n\n"
        "A small \$9.99 booking fee guarantees your appointment, locks the time slot, "
        "and ensures a trusted professional is dispatched to your address.\n\n"
        "Your home is in safe hands — we deliver quality every single time.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  // ---------------- CONFIRM BUTTON -------------------
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: whatsAppGreen,
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
}
