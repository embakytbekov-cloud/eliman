import 'package:flutter/material.dart';

class DeepCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DeepCleaningBookingScreen({super.key, required this.item});

  @override
  State<DeepCleaningBookingScreen> createState() =>
      _DeepCleaningBookingScreenState();
}

class _DeepCleaningBookingScreenState extends State<DeepCleaningBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  int bedrooms = 1;
  int bathrooms = 1;
  bool pets = false;

  List<String> extraTasks = [];

  final List<String> extras = [
    "Windows cleaning",
    "Fridge cleaning",
    "Oven cleaning",
    "Laundry",
    "Interior cabinet cleaning",
    "Basement cleaning",
  ];

  DateTime? selectedDay;
  TimeOfDay? selectedTime;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 6 PM",
    "9 AM – 6 PM",
    "6 PM – 9 PM",
  ];

  String? selectedSlot;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
  }

// -------- DAY PICKER (3 days only) --------
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
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Day",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...days.map((d) {
                return ListTile(
                  title: Text(
                    "${d.month}/${d.day}/${d.year}",
                    style: const TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    setState(() => selectedDay = d);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

// -------- PRICE CALCULATION --------
  double calculateTotal() {
    double base = 150; // минимальная deep cleaning цена
    double bedroomCost = bedrooms * 20;
    double bathroomCost = bathrooms * 15;

    double petsCost = pets ? 15 : 0;
    double extrasCost = extraTasks.length * 10;

    double total = base + bedroomCost + bathroomCost + petsCost + extrasCost;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.item["title"] ?? "Deep Cleaning",
          style: const TextStyle(
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
// ADDRESS
            title("Service Address"),
            whiteCard(
              child: TextField(
                controller: addressCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 22),

// BEDROOMS
            title("How many bedrooms?"),
            bigNumberSelector(
              value: bedrooms,
              onChanged: (v) => setState(() => bedrooms = v),
            ),
            const SizedBox(height: 22),

// BATHROOMS
            title("How many bathrooms?"),
            bigNumberSelector(
              value: bathrooms,
              onChanged: (v) => setState(() => bathrooms = v),
            ),
            const SizedBox(height: 22),

// PETS
            title("Any pets in your home?"),
            Row(
              children: [
                bigChoice("Yes", pets == true, () {
                  setState(() => pets = true);
                }),
                const SizedBox(width: 14),
                bigChoice("No", pets == false, () {
                  setState(() => pets = false);
                }),
              ],
            ),
            const SizedBox(height: 22),

// EXTRA TASKS
            title("Extra Tasks"),
            Column(
              children: extras.map((task) {
                return CheckboxListTile(
                  activeColor: const Color(0xFF23A373),
                  value: extraTasks.contains(task),
                  title: Text(task, style: const TextStyle(fontSize: 16)),
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

// Select Day
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

// Select Time
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
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      slot,
                      style: TextStyle(
                        fontSize: 15,
                        color: selected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
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
            const SizedBox(height: 8),

            Text("Deep Cleaning (base price): \$150",
                style: const TextStyle(fontSize: 15)),
            Text("Bedrooms: $bedrooms × \$20 = \$${bedrooms * 20}",
                style: const TextStyle(fontSize: 15)),
            Text("Bathrooms: $bathrooms × \$15 = \$${bathrooms * 15}",
                style: const TextStyle(fontSize: 15)),
            Text("Pets: ${pets ? "\$15" : "\$0"}",
                style: const TextStyle(fontSize: 15)),
            Text("Extras: \$${extraTasks.length * 10}",
                style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 10),
            Text(
              "Total (pay to worker): \$${total.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            const Text(
              "You will pay this total amount directly to the cleaner after the job is completed.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            const Text(
              "Booking fee you pay now: \$9.99",
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

// HELPERS -------------------------------------------------

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

  Widget bigChoice(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget bigNumberSelector({
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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: (value == number)
                    ? const Color(0xFF23A373)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "$number",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (value == number) ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
