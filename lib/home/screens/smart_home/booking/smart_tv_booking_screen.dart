import 'package:flutter/material.dart';

class SmartTvBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartTvBookingScreen({super.key, required this.item});

  @override
  State<SmartTvBookingScreen> createState() => _SmartTvBookingScreenState();
}

class _SmartTvBookingScreenState extends State<SmartTvBookingScreen> {
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String tvType = "Smart TV Setup";
  List<String> apps = [];
  String? selectedDay;
  String? selectedTime;

  final List<String> tvOptions = [
    "Smart TV Setup",
    "Fire TV / Roku Setup",
    "Apple TV Setup",
    "Streaming Apps Configuration",
    "Soundbar Setup",
    "Wall-mount + Setup",
  ];

  final List<String> appList = [
    "Netflix",
    "HBO Max",
    "Hulu",
    "Prime Video",
    "Disney+",
    "YouTube TV",
    "ESPN",
    "Tubi",
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
        title: Text(widget.item["title"],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _title("Service Address"),
          _inputCard(
            child: TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter address",
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _title("Select Setup Type"),
          _chips(tvOptions, tvType, (v) => setState(() => tvType = v)),
          const SizedBox(height: 20),
          _title("Which apps to install?"),
          _multiChips(appList, apps),
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
                hintText: "Example: mount + soundbar setup",
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(height: 25),
          _estimate(min, max),
          const SizedBox(height: 30),
          _confirmButton(),
        ]),
      ),
    );
  }

  // ----------------- HELPERS -----------------

  Widget _title(String t) => Text(t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700));

  Widget _inputCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.07),
                offset: const Offset(0, 4))
          ]),
      child: child,
    );
  }

  Widget _chips(List<String> list, String selected, Function(String) onTap) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: list.map((item) {
        bool active = selected == item;
        return GestureDetector(
          onTap: () => onTap(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
                color: active ? accent : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)),
            child: Text(item,
                style:
                    TextStyle(color: active ? Colors.white : Colors.black87)),
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
        bool active = selected.contains(item);
        return GestureDetector(
          onTap: () {
            setState(() => active ? selected.remove(item) : selected.add(item));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
                color: active ? accent : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)),
            child: Text(item,
                style:
                    TextStyle(color: active ? Colors.white : Colors.black87)),
          ),
        );
      }).toList(),
    );
  }

  Widget _daySelector() {
    return _inputCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          children: nextDays.map((d) {
            bool active = selectedDay == d;
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
            bool active = selectedTime == t;
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
          "Our \$9.99 booking fee simply reserves your time slot and "
          "notifies the best-smart home technician in your area.\n\n"
          "We'll notify you once a technician accepts your request.",
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))),
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Smart TV setup request sent!"))),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
