import 'package:flutter/material.dart';

class SmartAssistantBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartAssistantBookingScreen({super.key, required this.item});

  @override
  State<SmartAssistantBookingScreen> createState() =>
      _SmartAssistantBookingScreenState();
}

class _SmartAssistantBookingScreenState
    extends State<SmartAssistantBookingScreen> {
  // COLORS
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // FIELDS
  String assistant = "Alexa";
  int deviceCount = 1;
  List<String> goals = [];
  String wifiStatus = "WiFi is OK";
  String? selectedDay;
  String? selectedTime;

  // OPTIONS
  final List<String> assistantOptions = [
    "Alexa",
    "Google Home",
    "Both Alexa & Google",
  ];

  final List<int> deviceOptions = [1, 2, 3, 4, 5, 6];

  final List<String> goalOptions = [
    "Smart home control (lights, plugs, locks)",
    "Routines & automations",
    "Multi-room music",
    "TV / streaming voice control",
    "Help with account & skills",
  ];

  final List<String> wifiOptions = [
    "WiFi is OK",
    "Sometimes unstable",
    "Need help checking WiFi",
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
          widget.item["title"] ?? "Alexa / Google Home Setup",
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
            _title("Which assistant do you use?"),
            _chips(assistantOptions, assistant,
                (v) => setState(() => assistant = v)),
            const SizedBox(height: 20),
            _title("How many smart speakers / displays?"),
            _deviceSelector(),
            const SizedBox(height: 20),
            _title("What do you want to set up?"),
            _goalsChips(),
            const SizedBox(height: 20),
            _title("WiFi status"),
            _chips(
                wifiOptions, wifiStatus, (v) => setState(() => wifiStatus = v)),
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
                  hintText: "Example: connect living room TV, bedroom lights, "
                      "create \"Goodnight\" routine...",
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

  Widget _deviceSelector() {
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: deviceOptions.map((n) {
            final bool isSelected = deviceCount == n;
            return GestureDetector(
              onTap: () => setState(() => deviceCount = n),
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

  Widget _goalsChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: goalOptions.map((g) {
        final bool isSelected = goals.contains(g);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                goals.remove(g);
              } else {
                goals.add(g);
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
              g,
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
          "Our \$9.99 booking fee simply reserves your time slot and begins the search "
          "for the best available smart home expert in your area.\n\n"
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
          // TODO: later: connect with Supabase / Telegram
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Smart assistant setup booking sent!"),
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
