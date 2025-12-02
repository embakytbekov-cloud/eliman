import 'package:flutter/material.dart';

class SmartThermostatBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartThermostatBookingScreen({
    super.key,
    required this.item,
  });

  @override
  State<SmartThermostatBookingScreen> createState() =>
      _SmartThermostatBookingScreenState();
}

class _SmartThermostatBookingScreenState
    extends State<SmartThermostatBookingScreen> {
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String homeType = "House";
  String wiring = "Standard (C-wire)";
  String hvacType = "Central HVAC";
  String oldThermostat = "Yes";

  final List<String> homeTypes = ["House", "Apartment", "Townhouse", "Condo"];

  final List<String> wiringOptions = [
    "Standard (C-wire)",
    "No C-wire",
    "Not sure"
  ];

  final List<String> hvacOptions = [
    "Central HVAC",
    "Heat Pump",
    "Radiator Heating",
    "Mini-Split"
  ];

  final List<String> extras = [
    "Remove old thermostat",
    "Connect to WiFi",
    "App setup",
    "Custom schedule setup",
  ];

  List<String> selectedExtras = [];

  String? selectedDate;
  String? selectedTime;
  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
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
    final int minPrice = widget.item["minPrice"];
    final int maxPrice = widget.item["maxPrice"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Address"),
            _inputCard(TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                hintText: "Enter service address",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 22),
            _title("Home Type"),
            _chips(homeTypes, homeType, (v) => setState(() => homeType = v)),
            const SizedBox(height: 22),
            _title("Thermostat Wiring"),
            _chips(wiringOptions, wiring, (v) => setState(() => wiring = v)),
            const SizedBox(height: 22),
            _title("HVAC System Type"),
            _chips(hvacOptions, hvacType, (v) => setState(() => hvacType = v)),
            const SizedBox(height: 22),
            _title("Replacing old thermostat?"),
            Row(children: [
              _pill("Yes", oldThermostat == "Yes",
                  () => setState(() => oldThermostat = "Yes")),
              const SizedBox(width: 10),
              _pill("No", oldThermostat == "No",
                  () => setState(() => oldThermostat = "No")),
            ]),
            const SizedBox(height: 22),
            _title("Extra Options"),
            _multiChips(),
            const SizedBox(height: 22),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 22),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 22),
            _title("Notes"),
            _inputCard(TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Any details?",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 24),
            _price(minPrice, maxPrice),
            const SizedBox(height: 30),
            _confirm(),
          ],
        ),
      ),
    );
  }

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget _inputCard(Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ]),
      child: child,
    );
  }

  Widget _chips(List<String> opts, String selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      children: opts.map((o) {
        final bool isSel = o == selected;
        return GestureDetector(
          onTap: () => onTap(o),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
                color: isSel ? accent : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              o,
              style: TextStyle(
                  color: isSel ? Colors.white : Colors.black, fontSize: 14),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _pill(String label, bool selected, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
            color: selected ? accent : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _multiChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: extras.map((o) {
        final bool sel = selectedExtras.contains(o);
        return GestureDetector(
          onTap: () {
            setState(() {
              sel ? selectedExtras.remove(o) : selectedExtras.add(o);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
                color: sel ? accent : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)),
            child: Text(o,
                style: TextStyle(
                    color: sel ? Colors.white : Colors.black87, fontSize: 14)),
          ),
        );
      }).toList(),
    );
  }

  Widget _dateSelector() {
    return _inputCard(Wrap(
      spacing: 10,
      children: nextThreeDays.map((d) {
        final sel = selectedDate == d;
        return ChoiceChip(
          selected: sel,
          selectedColor: accent,
          backgroundColor: Colors.grey.shade200,
          label: Text(
            d,
            style: TextStyle(color: sel ? Colors.white : Colors.black),
          ),
          onSelected: (_) => setState(() => selectedDate = d),
        );
      }).toList(),
    ));
  }

  Widget _timeSelector() {
    return _inputCard(Wrap(
      spacing: 10,
      children: timeSlots.map((t) {
        final sel = selectedTime == t;
        return ChoiceChip(
          selected: sel,
          selectedColor: accent,
          backgroundColor: Colors.grey.shade200,
          label: Text(
            t,
            style: TextStyle(color: sel ? Colors.white : Colors.black),
          ),
          onSelected: (_) => setState(() => selectedTime = t),
        );
      }).toList(),
    ));
  }

  Widget _price(int min, int max) {
    return _inputCard(Text(
      "Estimated Price: \$$min – \$$max\n\n"
      "You'll never be charged until the job is completed.\n"
      "Our \$9.99 booking fee simply reserves your time slot and starts the search for the best available technician.\n\n"
      "We’ll notify you as soon as someone accepts your request.",
      style: const TextStyle(fontSize: 14, height: 1.4),
    ));
  }

  Widget _confirm() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: confirmGreen,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Thermostat booking sent!")));
        },
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
