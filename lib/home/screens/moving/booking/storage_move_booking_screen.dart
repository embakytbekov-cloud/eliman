import 'package:flutter/material.dart';

class StorageMoveBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const StorageMoveBookingScreen({super.key, required this.item});

  @override
  State<StorageMoveBookingScreen> createState() =>
      _StorageMoveBookingScreenState();
}

class _StorageMoveBookingScreenState extends State<StorageMoveBookingScreen> {
  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // STORAGE MOVE TYPE
  final List<String> moveTypes = [
    "Move TO storage",
    "Move FROM storage",
    "Move BETWEEN storage units",
    "Move IN & OUT (both)"
  ];
  String? selectedMoveType;

  // STORAGE SIZE
  final List<String> storageSizes = [
    "5×5",
    "5×10",
    "10×10",
    "10×15",
    "10×20",
    "10×30",
  ];
  String? selectedStorageSize;

  // ITEM COUNT
  int itemLevel = 1;

  // OPTIONS
  bool disassembly = false;
  bool packingSupplies = false;
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
        padding: const EdgeInsets.only(top: 20, bottom: 8),
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
              color: Colors.black.withOpacity(0.07))
        ],
      ),
      child: child,
    );
  }

  // CHOICE BUTTON
  Widget _choice(String t, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          t,
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
        "Estimated Price: \$150 – \$350\n\n"
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
            const SnackBar(content: Text("Storage move request sent!")),
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
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                ),
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
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
                  contentPadding: EdgeInsets.all(14),
                  border: InputBorder.none,
                ),
              ),
            ),

            // MOVE TYPE
            _title("Type of Storage Move"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: moveTypes.map((m) {
                final selected = selectedMoveType == m;
                return _choice(m, selected, () {
                  setState(() => selectedMoveType = m);
                });
              }).toList(),
            ),

            // STORAGE SIZE
            _title("Storage Unit Size"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: storageSizes.map((s) {
                final selected = selectedStorageSize == s;
                return _choice(s, selected, () {
                  setState(() => selectedStorageSize = s);
                });
              }).toList(),
            ),

            // ITEM COUNT
            _title("How many items?"),
            _card(
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Item Count",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (itemLevel > 1) setState(() => itemLevel--);
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
                            "$itemLevel",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => itemLevel++),
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

            // DISASSEMBLY
            _title("Require disassembly?"),
            Row(
              children: [
                _choice("Yes", disassembly == true,
                    () => setState(() => disassembly = true)),
                const SizedBox(width: 12),
                _choice("No", disassembly == false,
                    () => setState(() => disassembly = false)),
              ],
            ),

            // PACKING SUPPLIES
            _title("Need packing supplies?"),
            Row(
              children: [
                _choice("Yes", packingSupplies == true,
                    () => setState(() => packingSupplies = true)),
                const SizedBox(width: 12),
                _choice("No", packingSupplies == false,
                    () => setState(() => packingSupplies = false)),
              ],
            ),

            // TRASH REMOVAL
            _title("Need trash removal?"),
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
                  hintText: "Any more details...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),

            const SizedBox(height: 28),

            _trustBlock(),
            const SizedBox(height: 35),

            _confirmBtn(),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
