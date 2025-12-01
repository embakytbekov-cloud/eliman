import 'package:flutter/material.dart';

class OfficeCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const OfficeCleaningBookingScreen({super.key, required this.item});

  @override
  State<OfficeCleaningBookingScreen> createState() =>
      _OfficeCleaningBookingScreenState();
}

class _OfficeCleaningBookingScreenState
    extends State<OfficeCleaningBookingScreen> {
  // COLORS
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp green
  final Color darkGreen = const Color(0xFF2B6E4F); // accents
  final Color softGreen = const Color(0xFFDFF3E8); // info blocks

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController accessCtrl = TextEditingController();

  // VALUES
  int rooms = 1;
  int bathrooms = 1;

  String? officeSize;
  String? officeType;
  String? floorType;
  String? frequency;

  List<String> trash = [];
  List<String> extraTasks = [];

  // DATE / TIME
  String? selectedDate;
  String? selectedTime;

  final List<String> timeSlots = [
    "Morning (9 AM – 12 PM)",
    "Afternoon (12 PM – 3 PM)",
    "Evening (3 PM – 6 PM)",
  ];

  late List<String> nextThreeDays;

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
            _title("Office Address"),
            _card(TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                hintText: "Enter office address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(14),
              ),
            )),
            const SizedBox(height: 25),
            _title("Office Size"),
            _chips(
              options: [
                "Small (up to 800 sq ft)",
                "Medium (800–1500 sq ft)",
                "Large (1500–3000 sq ft)",
                "XL (3000+ sq ft)"
              ],
              selected: officeSize,
              onSelect: (v) => setState(() => officeSize = v),
            ),
            const SizedBox(height: 25),
            _title("Office Type"),
            _chips(
              options: [
                "Standard Workspace",
                "Co-working Space",
                "Medical Office",
                "Retail Store",
                "Warehouse Office",
              ],
              selected: officeType,
              onSelect: (v) => setState(() => officeType = v),
            ),
            const SizedBox(height: 25),
            _title("Floor Type"),
            _chips(
              options: ["Carpet", "Hardwood", "Tile", "Mixed"],
              selected: floorType,
              onSelect: (v) => setState(() => floorType = v),
            ),
            const SizedBox(height: 25),
            _title("Number of Rooms"),
            _stepper(
              value: rooms,
              onChanged: (v) => setState(() => rooms = v),
            ),
            const SizedBox(height: 25),
            _title("Bathrooms"),
            _stepper(
              value: bathrooms,
              onChanged: (v) => setState(() => bathrooms = v),
            ),
            const SizedBox(height: 25),
            _title("Cleaning Frequency"),
            _chips(
              options: [
                "One-time",
                "Daily",
                "Weekly",
                "Bi-weekly",
                "Monthly",
              ],
              selected: frequency,
              onSelect: (v) => setState(() => frequency = v),
            ),
            const SizedBox(height: 25),
            _title("Trash Removal"),
            _chipsMulti(
              options: [
                "Trash removal",
                "Recycle removal",
                "Shred box removal",
              ],
              selectedList: trash,
            ),
            const SizedBox(height: 25),
            _title("Extra Tasks"),
            _chipsMulti(
              options: [
                "Desk disinfection",
                "Keyboard & mouse wipe",
                "Window interior",
                "Break-room clean",
                "Fridge clean",
                "Meeting room cleaning",
                "Vacuum common areas",
                "Mop floors",
                "Supply refill",
                "Coffee station cleaning",
              ],
              selectedList: extraTasks,
            ),
            const SizedBox(height: 30),
            _title("Select Date"),
            _chips(
              options: nextThreeDays,
              selected: selectedDate,
              onSelect: (v) => setState(() => selectedDate = v),
            ),
            const SizedBox(height: 25),
            _title("Select Time"),
            _chips(
              options: timeSlots,
              selected: selectedTime,
              onSelect: (v) => setState(() => selectedTime = v),
            ),
            const SizedBox(height: 25),
            _title("Office Access Instructions"),
            _card(TextField(
              controller: accessCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Door code, front desk info, etc.",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(14),
              ),
            )),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 40),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ----------------------------
  // WIDGETS
  // ----------------------------

  Widget _title(String text) => Text(
        text,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      );

  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _chips({
    required List<String> options,
    required String? selected,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final bool active = selected == opt;
        return GestureDetector(
          onTap: () => onSelect(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: active ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _chipsMulti({
    required List<String> options,
    required List<String> selectedList,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final bool active = selectedList.contains(opt);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (active) {
                selectedList.remove(opt);
              } else {
                selectedList.add(opt);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: active ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _stepper({required int value, required Function(int) onChanged}) {
    return Row(
      children: [
        _circleBtn(Icons.remove, () {
          if (value > 1) onChanged(value - 1);
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "$value",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _circleBtn(Icons.add, () => onChanged(value + 1)),
      ],
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: darkGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // TRUST BLOCK — BRIGHT GREEN
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$90 – \$180\n\n"
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
