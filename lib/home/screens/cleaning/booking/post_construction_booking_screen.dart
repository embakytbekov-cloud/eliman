import 'package:flutter/material.dart';

class PostConstructionBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const PostConstructionBookingScreen({super.key, required this.item});

  @override
  State<PostConstructionBookingScreen> createState() =>
      _PostConstructionBookingScreenState();
}

class _PostConstructionBookingScreenState
    extends State<PostConstructionBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  int bedrooms = 1;
  int bathrooms = 1;

  String debrisLevel = "Light";
  bool heavyDust = false;
  bool paintSpots = false;
  bool pets = false;

  List<String> extraTasks = [];

  final List<String> extras = [
    "Window detailing",
    "Fridge cleaning",
    "Oven cleaning",
    "Cabinet interior cleaning",
    "Garage sweeping",
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

// DAY PICKER — only 3 days
  Future<void> pickDay() async {
    DateTime now = DateTime.now();
    List<DateTime> days = [
      now,
      now.add(const Duration(days: 1)),
      now.add(const Duration(days: 2)),
    ];

    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
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
        );
      },
    );
  }

// PRICE CALCULATION
  double calculateTotal() {
    double base = 180; // минимальная цена post-construction

    double bedroomCost = bedrooms * 15;
    double bathroomCost = bathrooms * 12;

    double debrisCost = 0;
    if (debrisLevel == "Medium") debrisCost = 30;
    if (debrisLevel == "Heavy") debrisCost = 60;

    double dustCost = heavyDust ? 25 : 0;
    double paintCost = paintSpots ? 20 : 0;
    double petsCost = pets ? 10 : 0;

    double extrasCost = extraTasks.length * 10;

    return base +
        bedroomCost +
        bathroomCost +
        debrisCost +
        dustCost +
        paintCost +
        petsCost +
        extrasCost;
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
          widget.item["title"] ?? "Post-Construction Cleaning",
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

// DEBRIS LEVEL
            title("Debris Level"),
            Wrap(
              spacing: 12,
              children: [
                debrisOption("Light"),
                debrisOption("Medium"),
                debrisOption("Heavy"),
              ],
            ),
            const SizedBox(height: 22),

// HEAVY DUST
            title("Any heavy dust?"),
            Row(
              children: [
                bigChoice("Yes", heavyDust == true,
                    () => setState(() => heavyDust = true)),
                const SizedBox(width: 12),
                bigChoice("No", heavyDust == false,
                    () => setState(() => heavyDust = false)),
              ],
            ),
            const SizedBox(height: 22),

// PAINT SPOTS
            title("Any paint spots?"),
            Row(
              children: [
                bigChoice("Yes", paintSpots == true,
                    () => setState(() => paintSpots = true)),
                const SizedBox(width: 12),
                bigChoice("No", paintSpots == false,
                    () => setState(() => paintSpots = false)),
              ],
            ),

            const SizedBox(height: 22),

// PETS
            title("Any pets in your home?"),
            Row(
              children: [
                bigChoice(
                    "Yes", pets == true, () => setState(() => pets = true)),
                const SizedBox(width: 12),
                bigChoice(
                    "No", pets == false, () => setState(() => pets = false)),
              ],
            ),

            const SizedBox(height: 22),

// EXTRA TASKS
            title("Extra Tasks"),
            Column(
              children: extras.map((t) {
                return CheckboxListTile(
                  activeColor: const Color(0xFF23A373),
                  value: extraTasks.contains(t),
                  title: Text(t),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        extraTasks.add(t);
                      } else {
                        extraTasks.remove(t);
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
                bool sel = selectedSlot == slot;
                return GestureDetector(
                  onTap: () => setState(() => selectedSlot = slot),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          sel ? const Color(0xFF23A373) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      slot,
                      style: TextStyle(
                        fontSize: 15,
                        color: sel ? Colors.white : Colors.black,
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
                  hintText: "Any additional details...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

// PRICE SUMMARY
            title("Price Summary"),
            const SizedBox(height: 10),
            Text("Post-Construction Base: \$180"),
            Text("Bedrooms: $bedrooms × \$15 = \$${bedrooms * 15}"),
            Text("Bathrooms: $bathrooms × \$12 = \$${bathrooms * 12}"),
            Text("Debris: $debrisLevel"),
            Text("Heavy Dust: ${heavyDust ? "\$25" : "\$0"}"),
            Text("Paint Spots: ${paintSpots ? "\$20" : "\$0"}"),
            Text("Pets: ${pets ? "\$10" : "\$0"}"),
            Text("Extras: \$${extraTasks.length * 10}"),

            const SizedBox(height: 10),
            Text(
              "Total (pay to worker): \$${total.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Text(
              "You will pay this total directly to the cleaner after the job is completed.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 14),
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
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

// HELPERS ------------------------------------------------------

  Widget title(String t) => Text(
        t,
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
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget debrisOption(String text) {
    bool selected = debrisLevel == text;
    return GestureDetector(
      onTap: () => setState(() => debrisLevel = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
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
        int n = i + 1;
        bool selected = value == n;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => onChanged(n),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color:
                    selected ? const Color(0xFF23A373) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "$n",
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
