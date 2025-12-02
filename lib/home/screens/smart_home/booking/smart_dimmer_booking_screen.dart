import 'package:flutter/material.dart';

class SmartDimmerBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartDimmerBookingScreen({super.key, required this.item});

  @override
  State<SmartDimmerBookingScreen> createState() =>
      _SmartDimmerBookingScreenState();
}

class _SmartDimmerBookingScreenState extends State<SmartDimmerBookingScreen> {
  // COLORS
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // FIELDS
  int dimmerCount = 1;
  String dimmerType = "Single-Pole";
  String wiring = "Neutral Wire Available";
  List<String> extras = [];
  String? selectedDay;
  String? selectedTime;

  // OPTIONS
  final List<String> dimmerTypes = [
    "Single-Pole",
    "3-Way Dimmer",
    "Smart Touch Dimmer",
    "Rotary Dimmer",
  ];

  final List<String> wiringOptions = [
    "Neutral Wire Available",
    "Not Sure",
    "Old Wiring / No Neutral",
  ];

  final List<String> extraOptions = [
    "Remove old switch",
    "App setup",
    "WiFi pairing",
    "Smart home automation",
  ];

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
  ];

  late List<String> nextThreeDays;

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
    final min = widget.item["minPrice"];
    final max = widget.item["maxPrice"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _whiteCard(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your address",
                    contentPadding: EdgeInsets.all(14)),
              ),
            ),
            const SizedBox(height: 20),
            _title("How Many Dimmers?"),
            _countSelector(),
            const SizedBox(height: 20),
            _title("Dimmer Type"),
            _chips(
                dimmerTypes, dimmerType, (v) => setState(() => dimmerType = v)),
            const SizedBox(height: 20),
            _title("Wiring Condition"),
            _chips(wiringOptions, wiring, (v) => setState(() => wiring = v)),
            const SizedBox(height: 20),
            _title("Extras"),
            _extrasChips(),
            const SizedBox(height: 20),
            _title("Select Day"),
            _daySelector(),
            const SizedBox(height: 20),
            _title("Time Window"),
            _timeSelector(),
            const SizedBox(height: 20),
            _title("Notes"),
            _whiteCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Any extra details...",
                    contentPadding: EdgeInsets.all(14)),
              ),
            ),
            const SizedBox(height: 25),
            _estimate(min, max),
            const SizedBox(height: 25),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // UI COMPONENTS ---------------------------------------------------

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget _whiteCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.08))
        ],
      ),
      child: child,
    );
  }

  Widget _chips(List<String> options, String selected, Function(String) onTap) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((o) {
        final s = o == selected;
        return GestureDetector(
          onTap: () => onTap(o),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: s ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(o,
                style: TextStyle(color: s ? Colors.white : Colors.black87)),
          ),
        );
      }).toList(),
    );
  }

  Widget _extrasChips() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: extraOptions.map((o) {
        final s = extras.contains(o);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (s) {
                extras.remove(o);
              } else {
                extras.add(o);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: s ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              o,
              style: TextStyle(color: s ? Colors.white : Colors.black87),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _countSelector() {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Number of Dimmers", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (dimmerCount > 1) setState(() => dimmerCount--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$dimmerCount",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _circleBtn(Icons.add, () => setState(() => dimmerCount++)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData i, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        child: Icon(i, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _daySelector() {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          children: nextThreeDays.map((d) {
            final s = selectedDay == d;
            return ChoiceChip(
              selected: s,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(color: s ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedDay = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _timeSelector() {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
            spacing: 12,
            children: timeSlots.map((t) {
              final s = selectedTime == t;
              return ChoiceChip(
                selected: s,
                selectedColor: accent,
                backgroundColor: Colors.grey.shade200,
                label: Text(
                  t,
                  style: TextStyle(color: s ? Colors.white : Colors.black87),
                ),
                onSelected: (_) => setState(() => selectedTime = t),
              );
            }).toList()),
      ),
    );
  }

  Widget _estimate(min, max) {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Estimated Price: \$$min – \$$max\n\n"
          "You’ll never be charged until the job is finished.\n"
          "The \$9.99 booking fee only reserves your appointment "
          "and sends your request to the closest available technician.\n\n"
          "You’ll receive updates as soon as someone accepts.",
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: confirmGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: () {},
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
