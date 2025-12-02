import 'package:flutter/material.dart';

class OfficeMoveBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const OfficeMoveBookingScreen({super.key, required this.item});

  @override
  State<OfficeMoveBookingScreen> createState() =>
      _OfficeMoveBookingScreenState();
}

class _OfficeMoveBookingScreenState extends State<OfficeMoveBookingScreen> {
  // COLORS
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color softGreen = const Color(0xFFDFF3E8);
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp green

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // VALUES
  String? officeSize;
  int workstations = 1;
  List<String> largeItems = [];
  bool packing = false;
  bool reassembly = false;
  bool elevatorOrigin = false;
  bool elevatorDestination = false;

  String? parking;
  String? distance;

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
            _title("Office Address"),
            _card(TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                hintText: "Enter office address",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 25),
            _title("Office Size"),
            _chips(
              options: [
                "Small (1–3 rooms)",
                "Medium (3–6 rooms)",
                "Large (6–12 rooms)",
                "Full Office Floor"
              ],
              selected: officeSize,
              onSelect: (v) => setState(() => officeSize = v),
            ),
            const SizedBox(height: 25),
            _title("Workstations / Desks"),
            _numberSelector(
              value: workstations,
              onChange: (v) => setState(() => workstations = v),
            ),
            const SizedBox(height: 25),
            _title("Large Items"),
            _multiChips(
              list: largeItems,
              options: [
                "Printers",
                "Conference Table",
                "Filing Cabinets",
                "Safes",
                "Server Racks",
              ],
            ),
            const SizedBox(height: 25),
            _title("Packing Service Needed?"),
            _chips(
              options: ["Yes", "No"],
              selected: packing ? "Yes" : "No",
              onSelect: (v) => setState(() => packing = (v == "Yes")),
            ),
            const SizedBox(height: 25),
            _title("Disassembly/Reassembly Needed?"),
            _chips(
              options: ["Yes", "No"],
              selected: reassembly ? "Yes" : "No",
              onSelect: (v) => setState(() => reassembly = (v == "Yes")),
            ),
            const SizedBox(height: 25),
            _title("Elevator (Origin)"),
            _chips(
              options: ["Yes", "No"],
              selected: elevatorOrigin ? "Yes" : "No",
              onSelect: (v) => setState(() => elevatorOrigin = (v == "Yes")),
            ),
            const SizedBox(height: 25),
            _title("Elevator (Destination)"),
            _chips(
              options: ["Yes", "No"],
              selected: elevatorDestination ? "Yes" : "No",
              onSelect: (v) =>
                  setState(() => elevatorDestination = (v == "Yes")),
            ),
            const SizedBox(height: 25),
            _title("Parking Situation"),
            _chips(
              options: [
                "Free Parking",
                "Paid Parking",
                "Loading Dock",
                "Street Parking Only",
              ],
              selected: parking,
              onSelect: (v) => setState(() => parking = v),
            ),
            const SizedBox(height: 25),
            _title("Distance Between Locations"),
            _chips(
              options: [
                "Same Building",
                "< 5 miles",
                "5–20 miles",
                "20+ miles",
              ],
              selected: distance,
              onSelect: (v) => setState(() => distance = v),
            ),
            const SizedBox(height: 25),
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
            _title("Extra Notes"),
            _card(TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Any additional instructions...",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 25),
            _estimatedPrice(),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 40),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // COMPONENTS
  // ------------------------------

  Widget _title(String t) => Text(t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700));

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  Widget _chips(
      {required List<String> options,
      required String? selected,
      required Function(String) onSelect}) {
    return Wrap(
      spacing: 10,
      children: options.map((o) {
        final bool isSel = (selected == o);
        return GestureDetector(
          onTap: () => onSelect(o),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSel ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              o,
              style: TextStyle(
                color: isSel ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _multiChips(
      {required List<String> list, required List<String> options}) {
    return Wrap(
      spacing: 10,
      children: options.map((o) {
        final bool isSel = list.contains(o);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSel)
                list.remove(o);
              else
                list.add(o);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSel ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              o,
              style: TextStyle(
                color: isSel ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _numberSelector(
      {required int value, required Function(int) onChange}) {
    return Row(
      children: List.generate(50, (i) {
        final int number = i + 1;
        final bool isSel = (value == number);
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => onChange(number),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSel ? darkGreen : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "$number",
                style: TextStyle(
                  color: isSel ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$XX – \$XX\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You pay the mover only after the job is fully completed.\n\n"
        "Your office move is 100% protected with our trusted WiBIM system.",
        style: TextStyle(fontSize: 15, height: 1.4),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
}
