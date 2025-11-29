import 'package:flutter/material.dart';

class CarStandardCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const CarStandardCleaningBookingScreen({super.key, required this.item});

  @override
  State<CarStandardCleaningBookingScreen> createState() =>
      _CarStandardCleaningBookingScreenState();
}

class _CarStandardCleaningBookingScreenState
    extends State<CarStandardCleaningBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

// ---- OPTIONS ----
  String vehicleType = "Sedan"; // Sedan / SUV / Minivan / Pickup / Cargo Van
  String petHair = "None"; // None / Light / Heavy
  String dirtLevel = "Light"; // Light / Medium / Heavy

  final List<String> extraOptions = [
    "Trunk cleaning",
    "Floor mats deep clean",
    "Odor removal",
  ];

  List<String> selectedExtras = [];

  DateTime? selectedDay;
  String? selectedTimeSlot; // 9–12, 12–6, 9–6, 6–9

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now(); // Today by default
  }

// ---- PRICE LOGIC ----

  double get basePrice {
    switch (vehicleType) {
      case "SUV":
        return 140;
      case "Minivan":
        return 160;
      case "Pickup":
        return 150;
      case "Cargo Van":
        return 180;
      case "Sedan":
      default:
        return 120;
    }
  }

  double get petHairPrice {
    switch (petHair) {
      case "Light":
        return 10;
      case "Heavy":
        return 20;
      default:
        return 0;
    }
  }

  double get dirtLevelPrice {
    switch (dirtLevel) {
      case "Medium":
        return 15;
      case "Heavy":
        return 30;
      default:
        return 0;
    }
  }

  double get extrasPrice {
    double total = 0;
    if (selectedExtras.contains("Trunk cleaning")) {
      total += 15;
    }
    if (selectedExtras.contains("Floor mats deep clean")) {
      total += 10;
    }
    if (selectedExtras.contains("Odor removal")) {
      total += 25;
    }
    return total;
  }

  double get serviceTotal =>
      basePrice + petHairPrice + dirtLevelPrice + extrasPrice;

// ---- DAY PICKER (3 DAYS) ----
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
              }).toList()
            ],
          ),
        );
      },
    );
  }

// ---- TIME SLOT PICKER ----
  final List<String> timeSlots = [
    "9:00 AM - 12:00 PM",
    "12:00 PM - 6:00 PM",
    "9:00 AM - 6:00 PM",
    "6:00 PM - 9:00 PM",
  ];

  Future<void> pickTimeSlot() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...timeSlots.map((slot) {
                return ListTile(
                  title: Text(
                    slot,
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    setState(() => selectedTimeSlot = slot);
                    Navigator.pop(context);
                  },
                );
              }).toList()
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String titleFromItem =
        widget.item["title"] ?? "Car Standard Cleaning";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          titleFromItem,
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
// ---- ADDRESS ----
            _title("Service Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Enter where the car will be cleaned",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

// ---- VEHICLE TYPE ----
            _title("Vehicle Type"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _bigChoice("Sedan", vehicleType == "Sedan",
                    () => setState(() => vehicleType = "Sedan")),
                _bigChoice("SUV", vehicleType == "SUV",
                    () => setState(() => vehicleType = "SUV")),
                _bigChoice("Minivan", vehicleType == "Minivan",
                    () => setState(() => vehicleType = "Minivan")),
                _bigChoice("Pickup", vehicleType == "Pickup",
                    () => setState(() => vehicleType = "Pickup")),
                _bigChoice("Cargo Van", vehicleType == "Cargo Van",
                    () => setState(() => vehicleType = "Cargo Van")),
              ],
            ),

            const SizedBox(height: 22),

// ---- PET HAIR ----
            _title("Pet hair in the car?"),
            Row(
              children: [
                _bigChoice("None", petHair == "None",
                    () => setState(() => petHair = "None")),
                const SizedBox(width: 10),
                _bigChoice("Light", petHair == "Light",
                    () => setState(() => petHair = "Light")),
                const SizedBox(width: 10),
                _bigChoice("Heavy", petHair == "Heavy",
                    () => setState(() => petHair = "Heavy")),
              ],
            ),

            const SizedBox(height: 22),

// ---- DIRT LEVEL ----
            _title("Overall dirt level"),
            Row(
              children: [
                _bigChoice("Light", dirtLevel == "Light",
                    () => setState(() => dirtLevel = "Light")),
                const SizedBox(width: 10),
                _bigChoice("Medium", dirtLevel == "Medium",
                    () => setState(() => dirtLevel = "Medium")),
                const SizedBox(width: 10),
                _bigChoice("Heavy", dirtLevel == "Heavy",
                    () => setState(() => dirtLevel = "Heavy")),
              ],
            ),

            const SizedBox(height: 22),

// ---- EXTRAS ----
            _title("Extra Tasks"),
            Column(
              children: extraOptions.map((task) {
                return CheckboxListTile(
                  activeColor: const Color(0xFF23A373),
                  value: selectedExtras.contains(task),
                  title: Text(task, style: const TextStyle(fontSize: 16)),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
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

// ---- DAY ----
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

// ---- TIME ----
            _title("Select Time"),
            _card(
              child: ListTile(
                title: Text(
                  selectedTimeSlot ?? "Choose a time window",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing:
                    const Icon(Icons.access_time, color: Color(0xFF23A373)),
                onTap: pickTimeSlot,
              ),
            ),

            const SizedBox(height: 22),

// ---- NOTES ----
            _title("Extra Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Parking details, gate code, special requests…",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

// ---- PRICE SUMMARY ----
            _title("Price summary"),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Car Standard Cleaning – inside only",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _priceRow("Base (${vehicleType})",
                      "\$${basePrice.toStringAsFixed(0)}"),
                  _priceRow(
                    "Pet hair",
                    petHairPrice == 0
                        ? "\$0"
                        : "+\$${petHairPrice.toStringAsFixed(0)}",
                  ),
                  _priceRow(
                    "Dirt level",
                    dirtLevelPrice == 0
                        ? "\$0"
                        : "+\$${dirtLevelPrice.toStringAsFixed(0)}",
                  ),
                  _priceRow(
                    "Extras",
                    extrasPrice == 0
                        ? "\$0"
                        : "+\$${extrasPrice.toStringAsFixed(0)}",
                  ),
                  const Divider(height: 18),
                  _priceRow(
                    "Service total",
                    "\$${serviceTotal.toStringAsFixed(0)}",
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "You will pay your car cleaner directly after the job is completed.\n"
              "Today you only pay a small booking fee of \$9.99 to secure your appointment.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 24),

// ---- BOOK BUTTON (9.99) ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (addressCtrl.text.trim().isEmpty ||
                      selectedTimeSlot == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Please enter address and select time slot"),
                      ),
                    );
                    return;
                  }

// Later: send to Telegram + Supabase
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Car Standard Cleaning booked. Booking fee \$9.99."),
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23A373),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Confirm booking for \$9.99",
                  style: TextStyle(
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

// ---- HELPERS ----

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
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

  Widget _bigChoice(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
