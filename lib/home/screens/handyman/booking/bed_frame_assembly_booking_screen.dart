import 'package:flutter/material.dart';

class BedFrameAssemblyBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const BedFrameAssemblyBookingScreen({super.key, required this.item});

  @override
  State<BedFrameAssemblyBookingScreen> createState() =>
      _BedFrameAssemblyBookingScreenState();
}

class _BedFrameAssemblyBookingScreenState
    extends State<BedFrameAssemblyBookingScreen> {
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp Green
  final Color darkGreen = const Color(0xFF2B6E4F); // WiBIM Dark
  final Color softGreen = const Color(0xFFDFF3E8); // Info block bg

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // COUNTS
  int beds = 1;

  // BED TYPES
  String? bedType;

  final List<String> bedTypes = [
    "Twin",
    "Full",
    "Queen",
    "King",
    "Bunk Bed",
    "Daybed / Futon",
  ];

  // DATE
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

  // EXTRAS
  List<String> selectedExtras = [];

  final List<String> extras = [
    "Remove old bed",
    "Move bed to another room",
    "Heavy lifting help",
    "Box disposal",
    "Add small repair",
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
            _title("Service Address"),
            _addressField(),
            const SizedBox(height: 25),
            _title("Number of Beds"),
            _bedCounter(),
            const SizedBox(height: 25),
            _title("Bed Type"),
            _bedTypeChips(),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateButtons(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeButtons(),
            const SizedBox(height: 25),
            _title("Extra Options"),
            _extraChips(),
            const SizedBox(height: 30),
            _infoBlock(),
            const SizedBox(height: 35),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // --------------------------
  // UI HELPERS
  // --------------------------

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
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  // ADDRESS
  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        maxLines: 2,
        decoration: const InputDecoration(
          hintText: "Enter full address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // COUNTER
  Widget _bedCounter() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Beds", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (beds > 1) setState(() => beds--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$beds",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                _circleBtn(Icons.add, () => setState(() => beds++)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback action) {
    return InkWell(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(color: darkGreen, shape: BoxShape.circle),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  // BED TYPE
  Widget _bedTypeChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: bedTypes.map((type) {
            final selected = bedType == type;
            return FilterChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                type,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              onSelected: (_) => setState(() => bedType = type),
            );
          }).toList(),
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
              label: Text(d,
                  style: TextStyle(
                      color: selected ? Colors.white : Colors.black87)),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TIME
  Widget _timeButtons() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((t) {
            final selected = selectedTime == t;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(t,
                  style: TextStyle(
                      color: selected ? Colors.white : Colors.black87)),
              onSelected: (_) => setState(() => selectedTime = t),
            );
          }).toList(),
        ),
      ),
    );
  }

  // EXTRAS
  Widget _extraChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: extras.map((e) {
            final selected = selectedExtras.contains(e);
            return FilterChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(e,
                  style: TextStyle(
                      color: selected ? Colors.white : Colors.black87)),
              onSelected: (v) {
                setState(() {
                  if (v) {
                    selectedExtras.add(e);
                  } else {
                    selectedExtras.remove(e);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // WIBIM TRUST BLOCK
  Widget _infoBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$XX – \$XX\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
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
}
