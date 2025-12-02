import 'package:flutter/material.dart';

class BrokenKeyExtractionBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const BrokenKeyExtractionBookingScreen({super.key, required this.item});

  @override
  State<BrokenKeyExtractionBookingScreen> createState() =>
      _BrokenKeyExtractionBookingScreenState();
}

class _BrokenKeyExtractionBookingScreenState
    extends State<BrokenKeyExtractionBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  bool isKeyVisible = false; // part visible outside?

  String? selectedTime;
  DateTime selectedDay = DateTime.now();

  final timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Broken Key Extraction",
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _title("Service Address"),
          _card(TextField(
            controller: addressCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
                hintText: "Enter address", border: InputBorder.none),
          )),
          const SizedBox(height: 22),
          _title("Is any part of the key visible?"),
          SwitchListTile(
            activeColor: const Color(0xFF23A373),
            value: isKeyVisible,
            title: const Text("Key is partly visible"),
            onChanged: (v) => setState(() => isKeyVisible = v),
          ),
          const SizedBox(height: 22),
          _title("Select Day"),
          _card(ListTile(
            title: Text(
                "${selectedDay.month}/${selectedDay.day}/${selectedDay.year}"),
            trailing:
                const Icon(Icons.calendar_today, color: Color(0xFF23A373)),
            onTap: _pickDay,
          )),
          const SizedBox(height: 22),
          _title("Select Time"),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: timeSlots.map((slot) {
              final selected = selectedTime == slot;
              return GestureDetector(
                onTap: () => setState(() => selectedTime = slot),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF23A373)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(slot,
                      style: TextStyle(
                        fontSize: 14,
                        color: selected ? Colors.white : Colors.black87,
                      )),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 25),
          _trust(),
          const SizedBox(height: 30),
          _button(),
        ]),
      ),
    );
  }

  Future<void> _pickDay() async {
    final now = DateTime.now();
    final days = [
      now,
      now.add(const Duration(days: 1)),
      now.add(const Duration(days: 2))
    ];

    await showModalBottomSheet(
        context: context,
        builder: (_) => Padding(
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text("Select Day",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...days.map((d) => ListTile(
                      title: Text("${d.month}/${d.day}/${d.year}"),
                      onTap: () {
                        setState(() => selectedDay = d);
                        Navigator.pop(context);
                      },
                    ))
              ]),
            ));
  }

  Widget _title(String t) => Text(t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600));

  Widget _card(Widget child) => Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(top: 10),
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

  Widget _trust() => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFDFF3E8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Text(
          "Estimated Price: \$70 – \$150\n"
          "You'll never be charged until the job is completed.\n\n"
          "A small \$9.99 booking fee reserves your slot and sends your request "
          "to a verified locksmith. We'll notify you once accepted.",
          style: TextStyle(fontSize: 15, height: 1.4),
        ),
      );

  Widget _button() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          child: const Text(
            "Confirm Booking — \$9.99",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      );
}
