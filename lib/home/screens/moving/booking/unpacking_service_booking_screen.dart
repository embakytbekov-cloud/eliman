import 'package:flutter/material.dart';

class UnpackingServiceBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const UnpackingServiceBookingScreen({super.key, required this.item});

  @override
  State<UnpackingServiceBookingScreen> createState() =>
      _UnpackingServiceBookingScreenState();
}

class _UnpackingServiceBookingScreenState
    extends State<UnpackingServiceBookingScreen> {
  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();
  final TextEditingController otherCtrl = TextEditingController();

  // CATEGORIES
  final List<String> categories = [
    "Kitchen Boxes",
    "Clothes Boxes",
    "Electronics",
    "Furniture Items",
    "Bathroom Boxes",
    "Fragile Items",
    "Miscellaneous",
    "Other",
  ];

  List<String> selectedCategories = [];

  // BOX COUNT
  int boxLevel = 1;

  // ARRANGING ITEMS?
  bool arrangingNeeded = false;

  // TRASH REMOVAL?
  bool trashRemoval = false;

  // DATE & TIME
  String? selectedDate;
  String? selectedTime;

  late List<String> nextThreeDays;

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

  // TITLE
  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(top: 22, bottom: 10),
        child: Text(
          t,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      );

  // CARD
  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
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

  Widget _choice(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // TRUST BLOCK
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$70 – \$140\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and dispatches the best available professional.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }

  // CONFIRM BUTTON
  Widget _confirmBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unpacking request sent!")),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25D366),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // DATE SELECTOR
  Widget _dateButtons() {
    return _card(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              selected: selected,
              selectedColor: const Color(0xFF2B6E4F),
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TIME SELECTOR
  Widget _timeSelector() {
    return _card(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              selected: selected,
              selectedColor: const Color(0xFF2B6E4F),
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.item["title"],
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ADDRESS
            _title("Service Address"),
            _card(
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),

            // WHAT NEEDS UNPACKING
            _title("What needs unpacking?"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categories.map((c) {
                final selected = selectedCategories.contains(c);
                return ChoiceChip(
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  label: Text(
                    c,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                  onSelected: (_) {
                    setState(() {
                      if (selected) {
                        selectedCategories.remove(c);
                      } else {
                        selectedCategories.add(c);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            if (selectedCategories.contains("Other"))
              _card(
                TextField(
                  controller: otherCtrl,
                  decoration: const InputDecoration(
                    hintText: "Describe items",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(14),
                  ),
                ),
              ),

            // BOX COUNT
            _title("How many boxes?"),
            _card(
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Box Count",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (boxLevel > 1) setState(() => boxLevel--);
                          },
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFF2B6E4F),
                            radius: 16,
                            child: Icon(Icons.remove,
                                size: 18, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "$boxLevel",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => boxLevel++),
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFF2B6E4F),
                            radius: 16,
                            child:
                                Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // ARRANGING ITEMS
            _title("Need help arranging items?"),
            Row(
              children: [
                _choice("Yes", arrangingNeeded == true,
                    () => setState(() => arrangingNeeded = true)),
                const SizedBox(width: 12),
                _choice("No", arrangingNeeded == false,
                    () => setState(() => arrangingNeeded = false)),
              ],
            ),

            // TRASH REMOVAL
            _title("Need trash/box removal?"),
            Row(
              children: [
                _choice("Yes", trashRemoval == true,
                    () => setState(() => trashRemoval = true)),
                const SizedBox(width: 12),
                _choice("No", trashRemoval == false,
                    () => setState(() => trashRemoval = false)),
              ],
            ),

            // DATE
            _title("Select Date"),
            _dateButtons(),

            // TIME
            _title("Select Time"),
            _timeSelector(),

            // NOTES
            _title("Additional Notes"),
            _card(
              TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any extra details...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),

            const SizedBox(height: 25),

            _trustBlock(),
            const SizedBox(height: 30),

            _confirmBtn(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
