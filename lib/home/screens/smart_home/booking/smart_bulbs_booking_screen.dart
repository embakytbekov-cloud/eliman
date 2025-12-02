import 'package:flutter/material.dart';

class SmartBulbsBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartBulbsBookingScreen({super.key, required this.item});

  @override
  State<SmartBulbsBookingScreen> createState() =>
      _SmartBulbsBookingScreenState();
}

class _SmartBulbsBookingScreenState extends State<SmartBulbsBookingScreen> {
  // COLORS
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // FIELDS
  int bulbsCount = 4;
  String hubStatus = "I already have a hub";
  String brand = "Philips Hue";
  List<String> extras = [];
  String? selectedDay;
  String? selectedTime;

  // OPTIONS
  final List<int> bulbsOptions = [1, 2, 4, 6, 8, 10, 15, 20];

  final List<String> hubOptions = [
    "I already have a hub",
    "I need a new hub",
    "Not sure / need advice",
  ];

  final List<String> brandOptions = [
    "Philips Hue",
    "Wyze",
    "Govee",
    "Kasa / TP-Link",
    "Mix of brands",
  ];

  final List<String> extraOptions = [
    "Set up scenes & moods",
    "Voice control (Alexa / Google)",
    "Outdoor smart lights",
    "Fix existing setup",
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
    final double min = (widget.item["minPrice"] as num).toDouble();
    final double max = (widget.item["maxPrice"] as num).toDouble();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Smart Bulbs & Hubs Setup",
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
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _title("How many smart bulbs?"),
            _bulbCountSelector(),
            const SizedBox(height: 20),
            _title("Smart hub status"),
            _chips(hubOptions, hubStatus, (v) => setState(() => hubStatus = v)),
            const SizedBox(height: 20),
            _title("Main brand (or closest match)"),
            _chips(brandOptions, brand, (v) => setState(() => brand = v)),
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
                  hintText:
                      "Any special preferences (rooms, colors, scenes)...",
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _estimate(min, max),
            const SizedBox(height: 28),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

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
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _bulbCountSelector() {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: bulbsOptions.map((n) {
            final bool isSelected = bulbsCount == n;
            return GestureDetector(
              onTap: () => setState(() => bulbsCount = n),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? accent : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$n",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _chips(List<String> options, String selected, Function(String) onTap) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((o) {
        final bool isSelected = o == selected;
        return GestureDetector(
          onTap: () => onTap(o),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              o,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _extrasChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: extraOptions.map((o) {
        final bool isSelected = extras.contains(o);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                extras.remove(o);
              } else {
                extras.add(o);
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
              o,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _daySelector() {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          children: nextThreeDays.map((d) {
            final bool isSelected = selectedDay == d;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
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
            final bool isSelected = selectedTime == t;
            return ChoiceChip(
              selected: isSelected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                t,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              onSelected: (_) => setState(() => selectedTime = t),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _estimate(double min, double max) {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Estimated Price: \$${min.toStringAsFixed(0)} – \$${max.toStringAsFixed(0)}\n\n"
          "You’ll never be charged until the job is completed.\n"
          "Our \$9.99 booking fee simply reserves your time slot and sends your request "
          "to the best available technician in your area.\n\n"
          "We’ll notify you as soon as someone accepts your request.",
          style: const TextStyle(fontSize: 14, height: 1.45),
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
        onPressed: () {
          // TODO: send to Supabase / Telegram later
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Smart bulbs setup booking sent!"),
            ),
          );
        },
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
}
