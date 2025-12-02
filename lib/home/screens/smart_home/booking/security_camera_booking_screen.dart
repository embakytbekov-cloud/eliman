import 'package:flutter/material.dart';

class SecurityCameraBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SecurityCameraBookingScreen({super.key, required this.item});

  @override
  State<SecurityCameraBookingScreen> createState() =>
      _SecurityCameraBookingScreenState();
}

class _SecurityCameraBookingScreenState
    extends State<SecurityCameraBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  int cameras = 1;
  String locationType = "Indoor";

  final List<String> locationOptions = [
    "Indoor",
    "Outdoor",
    "Indoor & Outdoor",
  ];

  String? selectedDate;
  String? selectedTime;
  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  final List<String> extraOptions = [
    "Run hidden cables",
    "Wall/ceiling mounting",
    "App & remote access setup",
    "Connect to NVR / recorder",
    "Connect to Alexa / Google",
  ];

  List<String> selectedExtras = [];

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
    final minPrice = widget.item["minPrice"];
    final maxPrice = widget.item["maxPrice"];

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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 22),
            _title("How many cameras?"),
            _countSelector(
              value: cameras,
              label: "camera",
              onChanged: (v) => setState(() => cameras = v),
            ),
            const SizedBox(height: 22),
            _title("Where will cameras be installed?"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: locationOptions.map((opt) {
                final selected = locationType == opt;
                return GestureDetector(
                  onTap: () => setState(() => locationType = opt),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF23A373)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      opt,
                      style: TextStyle(
                        fontSize: 14,
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            _title("Extra Options"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: extraOptions.map((opt) {
                final selected = selectedExtras.contains(opt);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected
                          ? selectedExtras.remove(opt)
                          : selectedExtras.add(opt);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF23A373)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      opt,
                      style: TextStyle(
                        fontSize: 14,
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            _title("Select Date"),
            _card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  children: nextThreeDays.map((d) {
                    final selected = selectedDate == d;
                    return ChoiceChip(
                      selected: selected,
                      selectedColor: const Color(0xFF23A373),
                      backgroundColor: Colors.grey.shade200,
                      label: Text(
                        d,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                        ),
                      ),
                      onSelected: (_) => setState(() => selectedDate = d),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 22),
            _title("Select Time"),
            _card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  children: timeSlots.map((slot) {
                    final selected = selectedTime == slot;
                    return ChoiceChip(
                      selected: selected,
                      selectedColor: const Color(0xFF23A373),
                      backgroundColor: Colors.grey.shade200,
                      label: Text(
                        slot,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                        ),
                      ),
                      onSelected: (_) => setState(() => selectedTime = slot),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 22),
            _title("Notes for your pro (optional)"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText:
                      "Access info, ladder needed, ceiling height, parking notes...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 26),
            _title("Estimated Price"),
            _card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  "Estimated Price: \$$minPrice – \$$maxPrice\n\n"
                  "You’ll never be charged until the job is completed.\n"
                  "Our \$9.99 booking fee simply reserves your time slot and begins the search for the best available professional in your area.\n\n"
                  "We’ll notify you as soon as someone accepts your request.",
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: later connect to backend/Telegram
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Confirm Booking — \$9.99",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // helpers
  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          t,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      );

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _countSelector({
    required int value,
    required String label,
    required ValueChanged<int> onChanged,
  }) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$value $label${value > 1 ? 's' : ''}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (value > 1) onChanged(value - 1);
                }),
                const SizedBox(width: 10),
                _circleBtn(Icons.add, () {
                  onChanged(value + 1);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFF23A373),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
