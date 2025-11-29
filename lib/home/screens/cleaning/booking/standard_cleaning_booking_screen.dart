import 'package:flutter/material.dart';

class StandardCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const StandardCleaningBookingScreen({super.key, required this.item});

  @override
  State<StandardCleaningBookingScreen> createState() =>
      _StandardCleaningBookingScreenState();
}

class _StandardCleaningBookingScreenState
    extends State<StandardCleaningBookingScreen> {
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
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now(); // Today
  }

// -----------------------------------------------------------
// PRICE CALCULATION
// -----------------------------------------------------------
  double get basePrice => 90; // Минимальная цена стандарт клининга

  double get bedroomPrice => bedrooms * 10;
  double get bathroomPrice => bathrooms * 7;
  double get petsFee => pets ? 10 : 0;
  double get extrasPrice => extraTasks.length * 8;

  double get totalPrice =>
      basePrice + bedroomPrice + bathroomPrice + petsFee + extrasPrice;

// -----------------------------------------------------------
// PICK DAY (3 DAYS ONLY)
// -----------------------------------------------------------
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
                  title: Text("${d.month}/${d.day}/${d.year}",
                      style: const TextStyle(fontSize: 17)),
                  onTap: () {
                    setState(() => selectedDay = d);
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

// -----------------------------------------------------------
// TIME SLOTS
// -----------------------------------------------------------
  final List<String> timeSlots = [
    "9AM - 12PM",
    "12PM - 6PM",
    "9AM - 6PM",
    "6PM - 9PM",
  ];

// -----------------------------------------------------------
// UI
// -----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Standard Cleaning",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//-----------------------------------------------------------
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
//-----------------------------------------------------------
          title("How many bedrooms?"),
          bigNumberSelector(
            value: bedrooms,
            onChanged: (v) => setState(() => bedrooms = v),
          ),
          const SizedBox(height: 22),

//-----------------------------------------------------------
          title("How many bathrooms?"),
          bigNumberSelector(
            value: bathrooms,
            onChanged: (v) => setState(() => bathrooms = v),
          ),
          const SizedBox(height: 22),

//-----------------------------------------------------------
          title("Any pets in your home?"),
          Row(children: [
            bigChoice("Yes", pets == true, () => setState(() => pets = true)),
            const SizedBox(width: 14),
            bigChoice("No", pets == false, () => setState(() => pets = false)),
          ]),
          const SizedBox(height: 22),

//-----------------------------------------------------------
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
          const SizedBox(height: 25),

//-----------------------------------------------------------
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

//-----------------------------------------------------------
          title("Select Time"),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: timeSlots.map((slot) {
              bool selected = selectedTimeSlot == slot;
              return GestureDetector(
                onTap: () => setState(() => selectedTimeSlot = slot),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF23A373)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    slot,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

//-----------------------------------------------------------
          title("Extra Notes"),
          whiteCard(
            child: TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: "Any additional details...",
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(height: 32),

//-----------------------------------------------------------
          title("Price Summary"),
          const SizedBox(height: 14),

          priceItem("Standard Cleaning (Base)", "\$90"),
          priceItem(
              "Bedrooms x$bedrooms", "\$${bedroomPrice.toStringAsFixed(0)}"),
          priceItem(
              "Bathrooms x$bathrooms", "\$${bathroomPrice.toStringAsFixed(0)}"),
          priceItem("Pets", pets ? "\$10" : "\$0"),
          priceItem("Extras (${extraTasks.length})",
              "\$${extrasPrice.toStringAsFixed(0)}"),

          const Divider(height: 30),

          priceItem("Estimated Total", "\$${totalPrice.toStringAsFixed(0)}",
              bold: true),

          const SizedBox(height: 20),

          const Text(
            "You will pay the cleaner after the cleaning is completed.\n"
            "The \$9.99 booking fee guarantees priority confirmation and fast worker assignment.",
            style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 30),

//-----------------------------------------------------------
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
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }

// -----------------------------------------------------------
// COMPONENTS
// -----------------------------------------------------------
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
              offset: const Offset(0, 3))
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
            color: selected ? Colors.white : Colors.black87,
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
        bool selected = n == value;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => onChanged(n),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color:
                    selected ? const Color(0xFF23A373) : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "$n",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget priceItem(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: bold ? FontWeight.w600 : FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
