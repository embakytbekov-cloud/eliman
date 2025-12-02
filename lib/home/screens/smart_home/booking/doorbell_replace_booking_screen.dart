import 'package:flutter/material.dart';

class DoorbellReplaceBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DoorbellReplaceBookingScreen({
    super.key,
    required this.item,
  });

  @override
  State<DoorbellReplaceBookingScreen> createState() =>
      _DoorbellReplaceBookingScreenState();
}

class _DoorbellReplaceBookingScreenState
    extends State<DoorbellReplaceBookingScreen> {
  // COLORS WiBiM STYLE
  final Color accent = const Color(0xFF23A373); // chips, titles
  final Color confirmGreen = const Color(0xFF25D366); // Confirm button
  final Color cardShadow = Colors.black.withOpacity(0.07);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // SELECTED VALUES
  String homeType = "House";
  String existingDoorbell = "Yes";
  String wiringType = "Wired";
  String chimeType = "Mechanical";

  final List<String> homeTypes = [
    "House",
    "Apartment",
    "Townhouse",
    "Condo",
  ];

  final List<String> wiringTypes = [
    "Wired",
    "Wireless",
    "Not sure",
  ];

  final List<String> chimeTypes = [
    "Mechanical",
    "Digital",
    "No existing chime",
  ];

  final List<String> extraOptions = [
    "Remove old doorbell",
    "Patch / paint old holes",
    "Connect to WiFi & app",
    "Connect to existing chime",
    "Adjust motion settings",
  ];

  List<String> selectedExtras = [];

  // DATE / TIME
  String? selectedDate;
  String? selectedTime;
  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

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
    final numMin = widget.item["minPrice"] ?? 0;
    final numMax = widget.item["maxPrice"] ?? 0;

    final int minPrice = numMin is int ? numMin : (numMin as num).toInt();
    final int maxPrice = numMax is int ? numMax : (numMax as num).toInt();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Doorbell Replace/Upgrade",
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
            const SizedBox(height: 22),
            _title("Home Type"),
            _chipSelector(
              options: homeTypes,
              selected: homeType,
              onSelect: (v) => setState(() => homeType = v),
            ),
            const SizedBox(height: 22),
            _title("Existing Doorbell"),
            Row(
              children: [
                _pillChoice(
                  label: "Yes",
                  selected: existingDoorbell == "Yes",
                  onTap: () => setState(() => existingDoorbell = "Yes"),
                ),
                const SizedBox(width: 10),
                _pillChoice(
                  label: "No",
                  selected: existingDoorbell == "No",
                  onTap: () => setState(() => existingDoorbell = "No"),
                ),
              ],
            ),
            const SizedBox(height: 22),
            _title("Wiring Type"),
            _chipSelector(
              options: wiringTypes,
              selected: wiringType,
              onSelect: (v) => setState(() => wiringType = v),
            ),
            const SizedBox(height: 22),
            _title("Chime Type"),
            _chipSelector(
              options: chimeTypes,
              selected: chimeType,
              onSelect: (v) => setState(() => chimeType = v),
            ),
            const SizedBox(height: 22),
            _title("Extra Options"),
            _multiChipSelector(),
            const SizedBox(height: 22),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 22),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 22),
            _title("Notes"),
            _notesField(),
            const SizedBox(height: 24),
            _estimatedPriceBlock(minPrice, maxPrice),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ---------- UI BLOCKS ----------

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

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

  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Any extra details for your technician...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  Widget _chipSelector({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final bool isSelected = opt == selected;
        return GestureDetector(
          onTap: () => onSelect(opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              opt,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _pillChoice({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? accent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
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

  Widget _multiChipSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: extraOptions.map((opt) {
        final bool isSelected = selectedExtras.contains(opt);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedExtras.remove(opt);
              } else {
                selectedExtras.add(opt);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              opt,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((day) {
            final bool isSelected = selectedDate == day;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                day,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              onSelected: (_) {
                setState(() => selectedDate = day);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final bool isSelected = selectedTime == slot;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              onSelected: (_) {
                setState(() => selectedTime = slot);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _estimatedPriceBlock(int minPrice, int maxPrice) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Estimated Price: \$$minPrice – \$$maxPrice\n\n"
          "You’ll never be charged until the job is completed.\n"
          "Our \$9.99 booking fee simply reserves your time slot and "
          "begins the search for the best available professional in your area.\n\n"
          "We’ll notify you as soon as someone accepts your request.",
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: send to backend / Telegram later
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Doorbell replace booking sent!"),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: confirmGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
