import 'package:flutter/material.dart';

class MeshWifiBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const MeshWifiBookingScreen({super.key, required this.item});

  @override
  State<MeshWifiBookingScreen> createState() => _MeshWifiBookingScreenState();
}

class _MeshWifiBookingScreenState extends State<MeshWifiBookingScreen> {
  final Color accent = const Color(0xFF23A373);
  final Color confirmGreen = const Color(0xFF25D366);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String homeType = "Apartment";
  int floors = 1;
  String meshSize = "2-pack";
  List<String> problemAreas = [];

  String? selectedDay;
  String? selectedTime;

  final List<String> meshKits = [
    "2-pack (small home)",
    "3-pack (medium home)",
    "4-pack (large home)",
    "Custom configuration",
  ];

  final List<String> homeStyles = [
    "Apartment",
    "Townhouse",
    "House",
    "Basement coverage",
  ];

  final List<String> deadZones = [
    "Bedroom is weak",
    "Living room is weak",
    "Basement no signal",
    "Garage weak WiFi",
    "Office weak WiFi",
    "Whole home weak",
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
        elevation: 0,
        backgroundColor: Colors.white,
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
                  hintText: "Enter your address",
                  contentPadding: EdgeInsets.all(12)),
            ),
          ),
          const SizedBox(height: 20),
          _title("Home Type"),
          _chips(homeStyles, homeType, (v) => setState(() => homeType = v)),
          const SizedBox(height: 20),
          _title("How many floors?"),
          _floorSelector(),
          const SizedBox(height: 20),
          _title("Mesh WiFi Kit"),
          _chips(meshKits, meshSize, (v) => setState(() => meshSize = v)),
          const SizedBox(height: 20),
          _title("Where is WiFi weak?"),
          _multiChips(deadZones, problemAreas),
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
                hintText: "Example: no WiFi in basement & garage",
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

  Widget _floorSelector() {
    return Row(
      children: List.generate(3, (i) {
        int number = i + 1;
        bool selected = number == floors;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => setState(() => floors = number),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: BoxDecoration(
                  color: selected ? accent : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                "$number Floor${number > 1 ? 's' : ''}",
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
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
            bool active = selectedDay == d;
            return ChoiceChip(
              selected: active,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              label: Text(d,
                  style:
                      TextStyle(color: active ? Colors.white : Colors.black87)),
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
              label: Text(t,
                  style:
                      TextStyle(color: active ? Colors.white : Colors.black87)),
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
          "notifies the best available technician.\n\n"
          "We'll message you once someone accepts your request.",
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
            const SnackBar(
                content: Text("Mesh WiFi installation request sent!"))),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
