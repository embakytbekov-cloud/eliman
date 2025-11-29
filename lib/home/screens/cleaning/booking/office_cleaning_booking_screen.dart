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
  final TextEditingController notesCtrl = TextEditingController();

// ---- MAIN QUESTIONS ----
  String officeSize = "Small (up to 1000 sq ft)";
  int bathrooms = 1;

// Extra tasks
  List<String> extras = [];
  final List<String> extraOptions = [
    "Trash removal",
    "Vacuum & mop floors",
    "Desk wipe-down",
    "Windows interior cleaning",
    "Meeting rooms cleaning",
  ];

// Date & time
  DateTime? selectedDay;
  String? selectedTimeSlot;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
  }

  List<DateTime> getAvailableDays() {
    DateTime now = DateTime.now();
    return [
      now,
      now.add(const Duration(days: 1)),
      now.add(const Duration(days: 2)),
    ];
  }

// ---- PRICE CALCULATION ----
  double getOfficeSizePrice() {
    switch (officeSize) {
      case "Small (up to 1000 sq ft)":
        return 160;
      case "Medium (1000–3000)":
        return 220;
      case "Large (3000–5000)":
        return 300;
      case "Extra large (5000+)":
        return 380;
      default:
        return 160;
    }
  }

  double getBathroomPrice() => bathrooms * 10;

  double getExtrasPrice() => extras.length * 10;

  double getTotalPrice() {
    return getOfficeSizePrice() + getBathroomPrice() + getExtrasPrice();
  }

// ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Office Cleaning",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// ---- OFFICE SIZE ----
            sectionTitle("Office Size"),
            Wrap(
              spacing: 10,
              children: [
                officeChip("Small (up to 1000 sq ft)"),
                officeChip("Medium (1000–3000)"),
                officeChip("Large (3000–5000)"),
                officeChip("Extra large (5000+)"),
              ],
            ),

            const SizedBox(height: 22),

// ---- BATHROOMS ----
            sectionTitle("Bathrooms"),
            numberSelector(
              value: bathrooms,
              onChanged: (v) => setState(() => bathrooms = v),
            ),

            const SizedBox(height: 22),

// ---- EXTRAS ----
            sectionTitle("Extra Tasks"),
            Column(
              children: extraOptions.map((task) {
                return CheckboxListTile(
                  value: extras.contains(task),
                  activeColor: const Color(0xFF23A373),
                  title: Text(task, style: const TextStyle(fontSize: 16)),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        extras.add(task);
                      } else {
                        extras.remove(task);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

// ---- DAY ----
            sectionTitle("Select Day"),
            whiteCard(
              child: ListTile(
                title: Text(
                  "${selectedDay!.month}/${selectedDay!.day}/${selectedDay!.year}",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing:
                    const Icon(Icons.calendar_today, color: Color(0xFF23A373)),
                onTap: () {
                  _pickDay();
                },
              ),
            ),

            const SizedBox(height: 22),

// ---- TIME ----
            sectionTitle("Select Time"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((slot) {
                return timeChip(slot);
              }).toList(),
            ),

            const SizedBox(height: 22),

// ---- NOTES ----
            sectionTitle("Extra Notes"),
            whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Any additional details..."),
              ),
            ),

            const SizedBox(height: 26),

// ---- PRICE SUMMARY ----
            sectionTitle("Price Summary"),
            whiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  priceRow("Base (Office size)", getOfficeSizePrice()),
                  priceRow("Bathrooms", getBathroomPrice()),
                  priceRow("Extra tasks", getExtrasPrice()),
                  const Divider(),
                  priceRow("Estimated total", getTotalPrice(),
                      bold: true, green: true),
                ],
              ),
            ),

            const SizedBox(height: 26),

// ---- BOOKING FEE ----
            Text(
              "Booking fee: \$9.99\nThis small fee guarantees priority service and a verified cleaning team.",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14.5,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 22),

// ---- CONFIRM BUTTON ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Office cleaning booked! A cleaner will contact you soon."),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23A373),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Confirm Booking for \$9.99",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

// ============================================================
// HELPERS
// ============================================================

  Widget sectionTitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget whiteCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
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

// Office Size Chips
  Widget officeChip(String text) {
    bool selected = officeSize == text;
    return GestureDetector(
      onTap: () => setState(() => officeSize = text),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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

// Time Chips
  Widget timeChip(String text) {
    bool selected = selectedTimeSlot == text;
    return GestureDetector(
      onTap: () {
        setState(() => selectedTimeSlot = text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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

  Widget numberSelector({
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      children: List.generate(6, (i) {
        int number = i + 1;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => onChanged(number),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: value == number
                    ? const Color(0xFF23A373)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "$number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: value == number ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget priceRow(String label, double value,
      {bool bold = false, bool green = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              )),
          Text(
            "\$${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: green ? const Color(0xFF23A373) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _pickDay() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: getAvailableDays().map((day) {
            return ListTile(
              title: Text(
                "${day.month}/${day.day}/${day.year}",
                style: const TextStyle(fontSize: 17),
              ),
              onTap: () {
                setState(() => selectedDay = day);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
