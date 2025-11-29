import 'package:flutter/material.dart';

class CarDeepCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const CarDeepCleaningBookingScreen({super.key, required this.item});

  @override
  State<CarDeepCleaningBookingScreen> createState() =>
      _CarDeepCleaningBookingScreenState();
}

class _CarDeepCleaningBookingScreenState
    extends State<CarDeepCleaningBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

// Vehicle Type
  String vehicleType = "Sedan";

  final List<String> extraOptions = [
    "Deep seat shampoo",
    "Floor mats shampoo",
    "Engine bay cleaning",
    "Pet hair removal",
    "Stain removal",
    "Ozone odor treatment",
  ];

  List<String> selectedExtras = [];

  DateTime? selectedDay;
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
  }

// PRICE LOGIC
  double get basePrice {
    switch (vehicleType) {
      case "SUV":
        return 120;
      case "Minivan":
        return 140;
      case "Pickup":
        return 130;
      case "Cargo Van":
        return 160;
      default:
        return 100; // Sedan
    }
  }

  double get extrasPrice {
    double price = 0;

    if (selectedExtras.contains("Deep seat shampoo")) price += 30;
    if (selectedExtras.contains("Floor mats shampoo")) price += 20;
    if (selectedExtras.contains("Engine bay cleaning")) price += 25;
    if (selectedExtras.contains("Pet hair removal")) price += 25;
    if (selectedExtras.contains("Stain removal")) price += 30;
    if (selectedExtras.contains("Ozone odor treatment")) price += 40;

    return price;
  }

  double get totalPrice => basePrice + extrasPrice;

// DATE PICKER (3 DAYS)
  Future<void> pickDay() async {
    DateTime now = DateTime.now();
    List<DateTime> allowed = [
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
              ...allowed.map((d) {
                return ListTile(
                  title: Text("${d.month}/${d.day}/${d.year}",
                      style: const TextStyle(fontSize: 16)),
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

// TIME SLOTS
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 6 PM",
    "9 AM – 6 PM",
    "6 PM – 9 PM",
  ];

  Future<void> pickTime() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...timeSlots.map((slot) {
                return ListTile(
                  title: Text(slot),
                  onTap: () {
                    setState(() => selectedTimeSlot = slot);
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

  @override
  Widget build(BuildContext context) {
    String titleFromItem = widget.item["title"] ?? "Car Deep Cleaning";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          titleFromItem,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
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
            _card(
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

// VEHICLE TYPE
            _title("Vehicle Type"),
            Wrap(
              spacing: 10,
              children: [
                _chip("Sedan"),
                _chip("SUV"),
                _chip("Minivan"),
                _chip("Pickup"),
                _chip("Cargo Van"),
              ],
            ),

            const SizedBox(height: 22),

// EXTRA DEEP TASKS
            _title("Deep Cleaning Extras"),
            Column(
              children: extraOptions.map((task) {
                return CheckboxListTile(
                  value: selectedExtras.contains(task),
                  activeColor: const Color(0xFF23A373),
                  title: Text(task),
                  onChanged: (checked) {
                    setState(() {
                      if (checked!) {
                        selectedExtras.add(task);
                      } else {
                        selectedExtras.remove(task);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

// DAY
            _title("Select Day"),
            _card(
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
            _card(
              child: ListTile(
                title: Text(
                  selectedTimeSlot ?? "Choose time",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing:
                    const Icon(Icons.access_time, color: Color(0xFF23A373)),
                onTap: pickTime,
              ),
            ),

            const SizedBox(height: 22),

// NOTES
            _title("Extra Notes"),
            _card(
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
            _title("Price Summary"),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _row("Base (${vehicleType})",
                      "\$${basePrice.toStringAsFixed(0)}"),
                  _row("Extras", "+\$${extrasPrice.toStringAsFixed(0)}"),
                  const Divider(height: 20),
                  _row("Total (pay to worker)",
                      "\$${totalPrice.toStringAsFixed(0)}",
                      bold: true),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "You will pay the total amount directly to the worker after the job is completed.\n"
              "Today you only pay a small booking fee of \$9.99 to secure your appointment.",
              style: TextStyle(
                  height: 1.4, color: Colors.grey.shade700, fontSize: 13),
            ),

            const SizedBox(height: 25),

// BOOKING BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (addressCtrl.text.isEmpty || selectedTimeSlot == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Car Deep Cleaning successfully booked!")),
                  );
                },
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

// HELPERS
  Widget _title(String text) {
    return Text(text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600));
  }

  Widget _card({required Widget child}) {
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

  Widget _chip(String text) {
    bool selected = (vehicleType == text);
    return GestureDetector(
      onTap: () => setState(() => vehicleType = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
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

  Widget _row(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w600)),
        ],
      ),
    );
  }
}
