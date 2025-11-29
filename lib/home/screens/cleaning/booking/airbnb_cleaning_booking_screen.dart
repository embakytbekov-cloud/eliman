import 'package:flutter/material.dart';

class AirbnbCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const AirbnbCleaningBookingScreen({super.key, required this.item});

  @override
  State<AirbnbCleaningBookingScreen> createState() =>
      _AirbnbCleaningBookingScreenState();
}

class _AirbnbCleaningBookingScreenState
    extends State<AirbnbCleaningBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  int bedrooms = 1;
  int bathrooms = 1;
  bool pets = false;

// ---- EXTRAS ----
  List<String> selectedExtras = [];

  final List<Map<String, dynamic>> extras = [
    {"title": "Laundry service", "price": 10},
    {"title": "Linen change", "price": 8},
    {"title": "Fridge cleaning", "price": 7},
    {"title": "Oven cleaning", "price": 7},
    {"title": "Balcony cleaning", "price": 6},
  ];

// ---- PRICE SETTINGS ----
  final int basePrice = 110; // Airbnb min price
  final double bookingFee = 9.99;

// ---- DAY / TIME ----
  late DateTime today;
  late DateTime selectedDay;

  String selectedTimeSlot = "9 AM – 12 PM";

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    selectedDay = today;
  }

// ----- DATE PICKER (ONLY 3 DAYS) -----
  Future<void> _pickDay() async {
    final List<DateTime> days = [
      today,
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2)),
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
              const SizedBox(height: 12),
              ...days.map((d) {
                final label = _formatDayLabel(d);
                return ListTile(
                  title: Text(
                    label,
                    style: const TextStyle(fontSize: 16),
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

  String _formatDayLabel(DateTime day) {
    final onlyDate =
        DateTime(day.year, day.month, day.day); // убираем часы для сравнения
    final onlyToday = DateTime(today.year, today.month, today.day);
    final tomorrow = onlyToday.add(const Duration(days: 1));
    final afterTomorrow = onlyToday.add(const Duration(days: 2));

    if (onlyDate == onlyToday) {
      return "Today (${day.month}/${day.day}/${day.year})";
    } else if (onlyDate == tomorrow) {
      return "Tomorrow (${day.month}/${day.day}/${day.year})";
    } else if (onlyDate == afterTomorrow) {
      return "Day after tomorrow (${day.month}/${day.day}/${day.year})";
    }
    return "${day.month}/${day.day}/${day.year}";
  }

// ----- PRICE CALC -----
  int get bedroomsPrice => bedrooms * 10;
  int get bathroomsPrice => bathrooms * 5;
  int get petsPrice => pets ? 15 : 0;

  int get extrasPrice {
    int sum = 0;
    for (final e in extras) {
      if (selectedExtras.contains(e["title"])) {
        sum += e["price"] as int;
      }
    }
    return sum;
  }

  int get totalForWorker =>
      basePrice + bedroomsPrice + bathroomsPrice + petsPrice + extrasPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Airbnb Cleaning",
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
// ---- ADDRESS ----
            _title("Property Address"),
            _whiteCard(
              child: TextField(
                controller: addressCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Enter the Airbnb address",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

// ---- BEDROOMS ----
            _title("How many bedrooms?"),
            _bigNumberSelector(
              value: bedrooms,
              onChanged: (v) => setState(() => bedrooms = v),
            ),

            const SizedBox(height: 22),

// ---- BATHROOMS ----
            _title("How many bathrooms?"),
            _bigNumberSelector(
              value: bathrooms,
              onChanged: (v) => setState(() => bathrooms = v),
            ),

            const SizedBox(height: 22),

// ---- PETS ----
            _title("Any pets stay in this property?"),
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

// ---- EXTRAS ----
            _title("Extra Tasks"),
            Column(
              children: extras.map((task) {
                final title = task["title"] as String;
                final price = task["price"] as int;
                return CheckboxListTile(
                  activeColor: const Color(0xFF23A373),
                  value: selectedExtras.contains(title),
                  title: Text(
                    "$title (+\$$price)",
                    style: const TextStyle(fontSize: 16),
                  ),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        selectedExtras.add(title);
                      } else {
                        selectedExtras.remove(title);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

// ---- DAY ----
            _title("Select Day"),
            _whiteCard(
              child: ListTile(
                title: Text(
                  _formatDayLabel(selectedDay),
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF23A373),
                ),
                onTap: _pickDay,
              ),
            ),

            const SizedBox(height: 22),

// ---- TIME ----
            _title("Select Time"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _timeChip("9 AM – 12 PM"),
                _timeChip("12 PM – 6 PM"),
                _timeChip("9 AM – 6 PM"),
                _timeChip("6 PM – 9 PM"),
              ],
            ),

            const SizedBox(height: 22),

// ---- NOTES ----
            _title("Extra Notes"),
            _whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Access code, parking, special instructions…",
                ),
              ),
            ),

            const SizedBox(height: 26),

// ---- PRICE SUMMARY ----
            const Text(
              "Price Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            Text(
              "Airbnb Cleaning (base price):  \$${basePrice.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "Bedrooms: $bedrooms × \$10 = \$${bedroomsPrice.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "Bathrooms: $bathrooms × \$5 = \$${bathroomsPrice.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "Pets fee: \$${petsPrice.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "Extras (${selectedExtras.length}): \$${extrasPrice.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              "Estimated total (pay to worker):  \$${totalForWorker.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23A373),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "You will pay this total amount directly to the cleaner after the job is completed.",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 6),

            Text(
              "Booking fee (\$${bookingFee.toStringAsFixed(2)}) reserves your cleaner and gives you priority support.",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 24),

// ---- BUTTON ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Airbnb cleaning booking created!"),
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
                child: Text(
                  "Confirm Booking for \$${bookingFee.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

// ====== HELPERS ======

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
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
        final number = i + 1;
        final bool isSelected = value == number;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => onChanged(number),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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

  Widget _timeChip(String label) {
    final bool selected = selectedTimeSlot == label;
    return GestureDetector(
      onTap: () {
        setState(() => selectedTimeSlot = label);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
