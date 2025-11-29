import 'package:flutter/material.dart';

class CarpetCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const CarpetCleaningBookingScreen({super.key, required this.item});

  @override
  State<CarpetCleaningBookingScreen> createState() =>
      _CarpetCleaningBookingScreenState();
}

class _CarpetCleaningBookingScreenState
    extends State<CarpetCleaningBookingScreen> {
  final TextEditingController notesCtrl = TextEditingController();

// -----------------------------
// PRICE MODEL
// -----------------------------
  int basePrice = 80; // min price
  int rooms = 1;
  bool hallway = false;

  String stairs = "No stairs";
  List<String> stainLevel = [
    "No stains",
    "Small stains",
    "Multiple stains",
    "Heavy stains",
    "Pet odor removal"
  ];
  String selectedStain = "No stains";

  List<String> extras = [];
  List<String> extraList = [
    "Steam cleaning",
    "Deep extraction",
    "Deodorizing",
    "Protector spray",
  ];

// DATE / TIME
  DateTime? selectedDay;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
  }

// -----------------------------
// DATE PICKER (3 days only)
// -----------------------------
  Future<void> pickDay() async {
    DateTime now = DateTime.now();
    List<DateTime> days = [
      now,
      now.add(const Duration(days: 1)),
      now.add(const Duration(days: 2)),
    ];

    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Day",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...days.map((day) {
                return ListTile(
                  title: Text("${day.month}/${day.day}/${day.year}",
                      style: const TextStyle(fontSize: 17)),
                  onTap: () {
                    setState(() => selectedDay = day);
                    Navigator.pop(context);
                  },
                );
              })
            ],
          ),
        );
      },
    );
  }

// -----------------------------
// PRICE CALCULATION
// -----------------------------
  int calculatePrice() {
    int total = basePrice;

    total += (rooms - 1) * 20;

    if (hallway) total += 20;

    if (stairs == "1–10 steps") total += 25;
    if (stairs == "10–20 steps") total += 40;
    if (stairs == "20+ steps") total += 60;

    if (selectedStain == "Small stains") total += 15;
    if (selectedStain == "Multiple stains") total += 30;
    if (selectedStain == "Heavy stains") total += 50;
    if (selectedStain == "Pet odor removal") total += 70;

    total += extras.length * 15;

    return total;
  }

// -----------------------------
// WIDGET BUILD
// -----------------------------
  @override
  Widget build(BuildContext context) {
    final price = calculatePrice();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Carpet Cleaning",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// ROOMS
            title("How many rooms need carpet cleaning?"),
            numberSelector(
              value: rooms,
              onChanged: (v) => setState(() => rooms = v),
            ),

            const SizedBox(height: 22),

// HALLWAY
            title("Do you need hallway carpet cleaned?"),
            rowOptions([
              option("Yes", hallway == true, () {
                setState(() => hallway = true);
              }),
              option("No", hallway == false, () {
                setState(() => hallway = false);
              }),
            ]),

            const SizedBox(height: 22),

// STAIRS
            title("Stairs cleaning?"),
            wrapOptions([
              "No stairs",
              "1–10 steps",
              "10–20 steps",
              "20+ steps",
            ], stairs, (v) {
              setState(() => stairs = v);
            }),

            const SizedBox(height: 22),

// STAINS
            title("Any stains or pet odor issues?"),
            wrapOptions(stainLevel, selectedStain, (v) {
              setState(() => selectedStain = v);
            }),

            const SizedBox(height: 22),

// EXTRAS
            title("Extra tasks"),
            Column(
              children: extraList.map((task) {
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

// DATE
            title("Select Day"),
            whiteCard(
              child: ListTile(
                title: Text(
                  "${selectedDay!.month}/${selectedDay!.day}/${selectedDay!.year}",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing:
                    const Icon(Icons.calendar_today, color: Color(0xFF23A373)),
                onTap: pickDay,
              ),
            ),

            const SizedBox(height: 22),

// TIME
            title("Select Time"),
            wrapOptions([
              "9 AM – 12 PM",
              "12 PM – 3 PM",
              "3 PM – 6 PM",
              "6 PM – 9 PM",
            ], selectedTime, (v) {
              setState(() => selectedTime = v);
            }),

            const SizedBox(height: 22),

// NOTES
            title("Extra Notes"),
            whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any additional details...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

// PRICE SUMMARY
            title("Price Summary"),
            const SizedBox(height: 10),

            summaryRow("Base price", "\$80"),
            summaryRow("Rooms", "+\$${(rooms - 1) * 20}"),
            if (hallway) summaryRow("Hallway", "+\$20"),
            if (stairs != "No stairs") summaryRow("Stairs", "+ extra"),
            if (selectedStain != "No stains")
              summaryRow("Stain removal", "+ extra"),
            if (extras.isNotEmpty)
              summaryRow("Extras (${extras.length})", "+ extra"),
            const Divider(),
            summaryRow("Estimated Total", "\$$price"),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "You only pay the cleaner after the job is completed.\nBooking fee 9.99 ensures guaranteed arrival.",
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, height: 1.4),
              ),
            ),

            const SizedBox(height: 25),

// BOOK BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23A373),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text(
                  "Confirm Booking for 9.99",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

// HELPERS -------------------------------

  Widget title(String text) => Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          )
        ],
      ),
      child: child,
    );
  }

  Widget numberSelector({
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      children: List.generate(6, (i) {
        int n = i + 1;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: option(n.toString(), value == n, () {
            onChanged(n);
          }),
        );
      }),
    );
  }

  Widget option(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget rowOptions(List<Widget> widgets) {
    return Row(children: widgets);
  }

  Widget wrapOptions(
      List<String> items, String? selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((t) {
        return option(t, selected == t, () => onTap(t));
      }).toList(),
    );
  }

  Widget summaryRow(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: const TextStyle(fontSize: 15)),
          Text(right,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
