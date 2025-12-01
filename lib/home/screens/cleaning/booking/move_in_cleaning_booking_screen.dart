import 'package:flutter/material.dart';

class MoveInCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const MoveInCleaningBookingScreen({super.key, required this.item});

  @override
  State<MoveInCleaningBookingScreen> createState() =>
      _MoveInCleaningBookingScreenState();
}

class _MoveInCleaningBookingScreenState
    extends State<MoveInCleaningBookingScreen> {
// CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

// VALUES
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

// DAY / TIME
  DateTime? selectedDay;
  String? selectedTime;

  final List<String> timeSlots = [
    "9:00 AM – 12:00 PM",
    "12:00 PM – 3:00 PM",
    "9:00 AM – 3:00 PM",
    "6:00 PM – 9:00 PM",
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now(); // today by default
  }

// ---- PICK DAY (ONLY 3 DAYS) ----
  Future<void> pickDay() async {
    final now = DateTime.now();
    final days = <DateTime>[
      DateTime(now.year, now.month, now.day),
      DateTime(now.year, now.month, now.day + 1),
      DateTime(now.year, now.month, now.day + 2),
    ];

    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Day",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...days.map((d) {
                return ListTile(
                  title: Text(
                    "${d.month}/${d.day}/${d.year}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    setState(() => selectedDay = d);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

// ---- PRICE CALCULATION ----
  double calculateTotal() {
    double base = 160; // base move-in cleaning

    base += bedrooms * 10; // per bedroom
    base += bathrooms * 5; // per bathroom
    if (pets) base += 10; // pets
    base += extraTasks.length * 10; // each extra

    return base;
  }

  @override
  Widget build(BuildContext context) {
    final double total = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Move-In Cleaning",
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
// ADDRESS
            _title("Service Address"),
            _whiteCard(
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
            _title("How many bedrooms?"),
            _bigNumberSelector(
              value: bedrooms,
              onChanged: (v) => setState(() => bedrooms = v),
            ),

            const SizedBox(height: 22),

// BATHROOMS
            _title("How many bathrooms?"),
            _bigNumberSelector(
              value: bathrooms,
              onChanged: (v) => setState(() => bathrooms = v),
            ),

            const SizedBox(height: 22),

// PETS
            _title("Any pets in your home?"),
            Row(
              children: [
                _bigChoice("Yes", pets == true, () {
                  setState(() => pets = true);
                }),
                const SizedBox(width: 14),
                _bigChoice("No", pets == false, () {
                  setState(() => pets = false);
                }),
              ],
            ),

            const SizedBox(height: 22),

// EXTRA TASKS
            _title("Extra Tasks"),
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

// DAY
            _title("Select Day"),
            _whiteCard(
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
            _title("Select Time"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((slot) {
                final bool isSelected = selectedTime == slot;
                return GestureDetector(
                  onTap: () => setState(() => selectedTime = slot),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF23A373)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      slot,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

// NOTES
            _title("Extra Notes"),
            _whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Any additional details...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 26),

// PRICE SUMMARY
            _title("Price Summary"),
            const SizedBox(height: 10),

            _priceItem("Move-In Cleaning", "\$160"),
            _priceItem("Bedrooms x$bedrooms", "+\$${bedrooms * 10}"),
            _priceItem("Bathrooms x$bathrooms", "+\$${bathrooms * 5}"),
            if (pets) _priceItem("Pets", "+\$10"),
            if (extraTasks.isNotEmpty)
              _priceItem(
                "Extras (${extraTasks.length})",
                "+\$${extraTasks.length * 10}",
              ),

            const Divider(height: 30),

            _priceItem(
              "Total Price (estimated)",
              "\$${total.toStringAsFixed(2)}",
              highlight: true,
            ),

            const SizedBox(height: 20),

            const Text(
              "You will pay the cleaner directly after the job is completed.\n"
              "The \$9.99 booking fee guarantees a fast & confirmed cleaner.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 22),

// BOOK BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
// TODO: later send to Telegram / Supabase
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Move-in cleaning booking sent!"),
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
                    color: Colors.white,
                    fontSize: 18,
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

// ---------- HELPERS ----------

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _whiteCard({required Widget child}) {
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

  Widget _bigChoice(String text, bool selected, VoidCallback onTap) {
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
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _bigNumberSelector({
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      children: List.generate(6, (i) {
        final int number = i + 1;
        final bool isSelected = value == number;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => onChanged(number),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF23A373) : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "$number",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _priceItem(String title, String price, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: highlight ? 17 : 15,
              fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: highlight ? 17 : 15,
              fontWeight: highlight ? FontWeight.bold : FontWeight.w600,
              color: highlight ? const Color(0xFF23A373) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
