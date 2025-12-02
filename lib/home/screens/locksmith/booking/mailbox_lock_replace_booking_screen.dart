import 'package:flutter/material.dart';

class MailboxLockReplaceBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const MailboxLockReplaceBookingScreen({super.key, required this.item});

  @override
  State<MailboxLockReplaceBookingScreen> createState() =>
      _MailboxLockReplaceBookingScreenState();
}

class _MailboxLockReplaceBookingScreenState
    extends State<MailboxLockReplaceBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  String? selectedTime;
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Mailbox Lock Replace",
          style: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _title("Address"),
          _card(TextField(
            controller: addressCtrl,
            decoration: const InputDecoration(
              hintText: "Enter service address",
              border: InputBorder.none,
            ),
          )),
          const SizedBox(height: 22),
          _title("Select Day"),
          _card(
            ListTile(
              title: Text(
                "${selectedDay.month}/${selectedDay.day}/${selectedDay.year}",
                style: const TextStyle(fontSize: 16),
              ),
              trailing:
                  const Icon(Icons.calendar_today, color: Color(0xFF23A373)),
              onTap: _pickDay,
            ),
          ),
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
          const SizedBox(height: 22),
          _title("Additional Notes"),
          _card(TextField(
            controller: notesCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
                hintText: "Mailbox type, access details…",
                border: InputBorder.none),
          )),
          const SizedBox(height: 30),
          _trust(),
          const SizedBox(height: 28),
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
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text("Select Day",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...days.map((d) {
                return ListTile(
                  title: Text("${d.month}/${d.day}/${d.year}"),
                  onTap: () {
                    setState(() => selectedDay = d);
                    Navigator.pop(context);
                  },
                );
              })
            ]),
          );
        });
  }

  Widget _title(String t) => Text(t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600));

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ]),
      child: child,
    );
  }

  Widget _trust() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$40 – \$90\n"
        "You'll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee reserves your time slot and sends your request to the best available technician.\n"
        "We’ll notify you as soon as someone accepts.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _button() {
    return SizedBox(
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
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
