import 'package:flutter/material.dart';

class WifiRouterBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const WifiRouterBookingScreen({super.key, required this.item});

  @override
  State<WifiRouterBookingScreen> createState() =>
      _WifiRouterBookingScreenState();
}

class _WifiRouterBookingScreenState extends State<WifiRouterBookingScreen> {
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String homeType = "Apartment";
  int floors = 1;

  List<String> routerBrand = [];
  String? selectedDay;
  String? selectedTime;

  final List<String> brands = [
    "Xfinity",
    "AT&T",
    "Spectrum",
    "Google Nest",
    "TP-Link",
    "Netgear",
    "Eero",
  ];

  final List<String> homeStyles = [
    "Apartment",
    "Townhouse",
    "House",
    "Basement Coverage",
  ];

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
  ];

  late List<String> nextDays;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    nextDays = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
    double min = (widget.item["minPrice"] as num).toDouble();
    double max = (widget.item["maxPrice"] as num).toDouble();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _inputCard(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your address",
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _title("Home Type"),
            _chips(homeStyles, homeType, (v) => setState(() => homeType = v)),
            const SizedBox(height: 20),
            _title("Floors"),
            _floorSelector(),
            const SizedBox(height: 20),
            _title("Router Brand"),
            _multiChips(brands, routerBrand),
            const SizedBox(height: 20),
            _title("Select Day"),
            _daySelector(),
            const SizedBox(height: 20),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 20),
            _title("Notes"),
            _inputCard(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Example: Need help with setup + WiFi optimization",
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            const SizedBox(height: 25),
            _estimate(min, max),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------
  //  HELPERS UI
  // -----------------------------------------------------------

  Widget _title(String text) => Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget _inputCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.07),
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _chips(List<String> list, String selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: list.map((item) {
        final active = selected == item;
        return GestureDetector(
          onTap: () => onTap(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: active ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _multiChips(List<String> list, List<String> selected) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: list.map((item) {
        final active = selected.contains(item);
        return GestureDetector(
          onTap: () => setState(() {
            active ? selected.remove(item) : selected.add(item);
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: active ? accent : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _floorSelector() {
    return Row(
      children: List.generate(3, (index) {
        final num = index + 1;
        final active = num == floors;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => setState(() => floors = num),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: active ? accent : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "$num Floor${num > 1 ? 's' : ''}",
                style: TextStyle(color: active ? Colors.white : Colors.black87),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _daySelector() {
    return _inputCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          children: nextDays.map((d) {
            final active = selectedDay == d;
            return ChoiceChip(
              selected: active,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style: TextStyle(color: active ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedDay = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _timeSelector() {
    return _inputCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          children: timeSlots.map((t) {
            final active = selectedTime == t;
            return ChoiceChip(
              selected: active,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                t,
                style: TextStyle(color: active ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedTime = t),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _estimate(double min, double max) {
    return _inputCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Text(
          "Estimated Price: \$${min.toStringAsFixed(0)} – \$${max.toStringAsFixed(0)}\n\n"
          "You'll never be charged until the job is completed.\n"
          "Our \$9.99 booking fee simply reserves your time slot and assigns the best available technician.\n\n"
          "We’ll notify you once your request is accepted.",
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("WiFi router setup request sent!"),
            ),
          );
        },
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
