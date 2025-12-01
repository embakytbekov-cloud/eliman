import 'package:flutter/material.dart';

class VehicleCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const VehicleCleaningBookingScreen({super.key, required this.item});

  @override
  State<VehicleCleaningBookingScreen> createState() =>
      _VehicleCleaningBookingScreenState();
}

class _VehicleCleaningBookingScreenState
    extends State<VehicleCleaningBookingScreen> {
  // COLORS
  final Color mainGreen = const Color(0xFF23A373);
  final Color tagGreen = const Color(0xFF2B6E4F);
  final Color lightGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // VEHICLE TYPE
  final List<String> vehicleTypes = [
    "Sedan",
    "SUV",
    "Minivan",
    "Pickup",
    "Semi-truck",
  ];
  String? selectedVehicle;

  // CLEANING TYPE
  final List<String> cleaningTypes = [
    "Standard",
    "Deep",
    "Premium",
  ];
  String? selectedCleaning;

  // AREA TYPE
  final List<String> areaTypes = [
    "Interior Only",
    "Exterior Only",
    "Full Detail",
  ];
  String? selectedArea;

  // EXTRA TASKS (CHIPS WIBI STYLE)
  final List<String> extraTasks = [
    "Interior Deep Shampoo",
    "Pet Hair Removal",
    "Stain Removal",
    "Odor Treatment",
    "Dashboard Polishing",
    "Floor Shampoo",
    "Trunk Deep Cleaning",
    "Window Interior Cleaning",
  ];
  List<String> selectedExtras = [];

  // DATE — 3 DAYS
  String? selectedDate;
  late List<String> nextThreeDays;

  // TIME SLOTS
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];
  String? selectedTime;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    nextThreeDays = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.item["title"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Address"),
            _addressField(),
            const SizedBox(height: 25),
            _title("Vehicle Type"),
            _chipSelector(vehicleTypes, selectedVehicle,
                (v) => setState(() => selectedVehicle = v)),
            const SizedBox(height: 25),
            _title("Cleaning Type"),
            _chipSelector(cleaningTypes, selectedCleaning,
                (v) => setState(() => selectedCleaning = v)),
            const SizedBox(height: 25),
            _title("Area"),
            _chipSelector(areaTypes, selectedArea,
                (v) => setState(() => selectedArea = v)),
            const SizedBox(height: 25),
            _title("Extra Tasks"),
            _multiChipSelector(extraTasks, selectedExtras),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _title("Notes"),
            _notesField(),
            const SizedBox(height: 30),
            _estimatedPrice(),
            const SizedBox(height: 25),
            const SizedBox(height: 35),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // TITLE
  // ------------------------------
  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
    );
  }

  // ------------------------------
  // ADDRESS
  // ------------------------------
  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          hintText: "Enter service address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ------------------------------
  // NOTES
  // ------------------------------
  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Any additional details…",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ------------------------------
  // CHIPS SELECTOR (Single)
  // ------------------------------
  Widget _chipSelector(
      List<String> options, String? selected, Function(String) onSelect) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final active = selected == opt;
        return ChoiceChip(
          selected: active,
          selectedColor: tagGreen,
          backgroundColor: Colors.grey.shade200,
          label: Text(
            opt,
            style: TextStyle(color: active ? Colors.white : Colors.black),
          ),
          onSelected: (_) => onSelect(opt),
        );
      }).toList(),
    );
  }

  // ------------------------------
  // MULTI CHIP SELECTOR
  // ------------------------------
  Widget _multiChipSelector(List<String> options, List<String> selectedList) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final selected = selectedList.contains(opt);
        return FilterChip(
          selected: selected,
          selectedColor: tagGreen,
          checkmarkColor: Colors.white,
          backgroundColor: Colors.grey.shade200,
          label: Text(
            opt,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
          onSelected: (v) {
            setState(() {
              if (v) {
                selectedList.add(opt);
              } else {
                selectedList.remove(opt);
              }
            });
          },
        );
      }).toList(),
    );
  }

  // ------------------------------
  // DATE SELECTOR
  // ------------------------------
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((day) {
            final active = selectedDate == day;
            return ChoiceChip(
              selected: active,
              selectedColor: tagGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                day,
                style: TextStyle(color: active ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedDate = day),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // TIME SELECTOR
  // ------------------------------
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final active = selectedTime == slot;
            return ChoiceChip(
              selected: active,
              selectedColor: tagGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style: TextStyle(color: active ? Colors.white : Colors.black),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // ESTIMATED PRICE (WIBI TEXT)
  // ------------------------------
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$60 – \$300\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  // ------------------------------
  // CONFIRM BUTTON
  // ------------------------------
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: mainGreen, // WhatsApp color
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // ------------------------------
  // CARD
  // ------------------------------
  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.07),
          ),
        ],
      ),
      child: child,
    );
  }
}
