import 'package:flutter/material.dart';

class TvMountingBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const TvMountingBookingScreen({super.key, required this.item});

  @override
  State<TvMountingBookingScreen> createState() =>
      _TvMountingBookingScreenState();
}

class _TvMountingBookingScreenState extends State<TvMountingBookingScreen> {
  // COLORS
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();

  // TVs
  int tvCount = 1;

  // TV sizes
  final List<String> sizes = [
    "32\" – 43\"",
    "55\"",
    "65\"",
    "75\"+",
  ];
  String? selectedSize;

  // Mount type
  final List<String> mountTypes = [
    "Fixed",
    "Tilting",
    "Full-Motion",
  ];
  String? selectedMount;

  // Wall types
  final List<String> wallTypes = [
    "Drywall",
    "Concrete",
    "Brick",
  ];
  String? selectedWall;

  // EXTRA OPTIONS
  final List<String> extras = [
    "Hide wires inside wall",
    "Provide TV mount",
    "Soundbar install",
    "Cable management",
    "Remove old TV",
  ];
  List<String> selectedExtras = [];

  // DATE (3 days)
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
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.year}",
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
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
            _title("How many TVs?"),
            _tvCountSelector(),
            const SizedBox(height: 25),
            _title("TV Size"),
            _chipSelector(
                sizes, selectedSize, (v) => setState(() => selectedSize = v)),
            const SizedBox(height: 25),
            _title("Mount Type"),
            _chipSelector(mountTypes, selectedMount,
                (v) => setState(() => selectedMount = v)),
            const SizedBox(height: 25),
            _title("Wall Type"),
            _chipSelector(wallTypes, selectedWall,
                (v) => setState(() => selectedWall = v)),
            const SizedBox(height: 25),
            _title("Extra Options"),
            _multiChipSelector(),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
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

  // TITLE
  Widget _title(String txt) => Text(
        txt,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
      );

  // ADDRESS FIELD
  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          hintText: "Enter full address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // TV COUNT
  Widget _tvCountSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("TVs", style: TextStyle(fontSize: 17)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (tvCount > 1) setState(() => tvCount--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$tvCount",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _circleBtn(Icons.add, () => setState(() => tvCount++)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // SINGLE SELECT CHIPS
  Widget _chipSelector(
      List<String> list, String? selected, Function(String) onSelect) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: list.map((item) {
        final bool active = selected == item;
        return GestureDetector(
          onTap: () => onSelect(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: active ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              item,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black, fontSize: 14),
            ),
          ),
        );
      }).toList(),
    );
  }

  // MULTI SELECT CHIPS
  Widget _multiChipSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: extras.map((txt) {
        final active = selectedExtras.contains(txt);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (active) {
                selectedExtras.remove(txt);
              } else {
                selectedExtras.add(txt);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: active ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              txt,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black, fontSize: 14),
            ),
          ),
        );
      }).toList(),
    );
  }

  // DATE SELECTOR
  Widget _dateSelector() {
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
              label: Text(
                d,
                style: TextStyle(color: selected ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TIME
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style: TextStyle(color: selected ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ESTIMATED PRICE
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$75 – \$150\n(TV size & mount type may affect price)",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  // TRUST BLOCK
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
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // CARD WRAPPER
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

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: darkGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
