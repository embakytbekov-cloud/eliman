import 'package:flutter/material.dart';

class TruckCabinRefreshBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const TruckCabinRefreshBookingScreen({super.key, required this.item});

  @override
  State<TruckCabinRefreshBookingScreen> createState() =>
      _TruckCabinRefreshBookingScreenState();
}

class _TruckCabinRefreshBookingScreenState
    extends State<TruckCabinRefreshBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

// OPTIONS
  bool petHair = false;
  String trashLevel = "Low";
  String smellLevel = "Light";

  List<String> extraTasks = [];

  final List<String> extras = [
    "Dashboard deep clean",
    "Seat stain removal",
    "Floor mat wash",
    "Interior wipe down",
    "Window cleaning",
  ];

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 6 PM",
    "9 AM – 6 PM",
    "6 PM – 9 PM",
  ];

  String? selectedSlot;
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
  }

// ONLY 3 DAYS
  Future<void> pickDay() async {
    final now = DateTime.now();
    final days = [
      now,
      now.add(const Duration(days: 1)),
      now.add(const Duration(days: 2)),
    ];

    await showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Select Day",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...days.map(
              (d) => ListTile(
                title: Text(
                  "${d.month}/${d.day}/${d.year}",
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  setState(() => selectedDay = d);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// PRICE
  double calculateTotal() {
    double base = 60;

    double petCost = petHair ? 15 : 0;

    double trashCost = switch (trashLevel) {
      "Low" => 0,
      "Medium" => 10,
      "High" => 20,
      _ => 0,
    };

    double smellCost = switch (smellLevel) {
      "Light" => 0,
      "Medium" => 10,
      "Strong" => 20,
      _ => 0,
    };

    double extrasCost = extraTasks.length * 10;

    return base + petCost + trashCost + smellCost + extrasCost;
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Truck Cabin Refresh",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title("Service Address"),
            whiteCard(
              child: TextField(
                controller: addressCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: "Enter your address", border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 22),

// PET HAIR
            title("Pet Hair Inside?"),
            Row(
              children: [
                bigChoice("Yes", petHair == true,
                    () => setState(() => petHair = true)),
                const SizedBox(width: 12),
                bigChoice("No", petHair == false,
                    () => setState(() => petHair = false)),
              ],
            ),
            const SizedBox(height: 22),

// TRASH LEVEL
            title("Trash Level"),
            Wrap(
              spacing: 12,
              children: [
                trashChip("Low"),
                trashChip("Medium"),
                trashChip("High"),
              ],
            ),
            const SizedBox(height: 22),

// SMELL LEVEL
            title("Smell Level"),
            Wrap(
              spacing: 12,
              children: [
                smellChip("Light"),
                smellChip("Medium"),
                smellChip("Strong"),
              ],
            ),
            const SizedBox(height: 22),

// EXTRAS
            title("Extra Tasks"),
            Column(
              children: extras.map((task) {
                return CheckboxListTile(
                  activeColor: const Color(0xFF23A373),
                  value: extraTasks.contains(task),
                  title: Text(task),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        extraTasks.add(task);
                      } else {
                        extraTasks.remove(task);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

// DAY
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
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: timeSlots.map((slot) {
                bool selected = selectedSlot == slot;
                return GestureDetector(
                  onTap: () => setState(() => selectedSlot = slot),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF23A373)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      slot,
                      style: TextStyle(
                        fontSize: 15,
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),

// NOTES
            title("Extra Notes"),
            whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Any additional details...",
                ),
              ),
            ),

            const SizedBox(height: 30),

// PRICE SUMMARY
            title("Price Summary"),
            const SizedBox(height: 10),
            Text("Base Price: \$60"),
            Text("Pet Hair: ${petHair ? "\$15" : "\$0"}"),
            Text("Trash Level: $trashLevel"),
            Text("Smell Level: $smellLevel"),
            Text("Extras: \$${extraTasks.length * 10}"),

            const SizedBox(height: 8),
            Text(
              "Total (pay to worker): \$${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You will pay this amount directly to the worker after the job is completed.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            const Text(
              "Booking Fee: \$9.99 (paid now)",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 25),

// BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23A373),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text(
                  "Confirm Booking for \$9.99",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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

// HELPERS ----------------------------------------------

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
          ),
        ],
      ),
      child: child,
    );
  }

  Widget bigChoice(String t, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          t,
          style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget trashChip(String t) {
    bool selected = trashLevel == t;
    return GestureDetector(
      onTap: () => setState(() => trashLevel = t),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          t,
          style: TextStyle(
              fontSize: 15, color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget smellChip(String t) {
    bool selected = smellLevel == t;
    return GestureDetector(
      onTap: () => setState(() => smellLevel = t),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          t,
          style: TextStyle(
              fontSize: 15, color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
