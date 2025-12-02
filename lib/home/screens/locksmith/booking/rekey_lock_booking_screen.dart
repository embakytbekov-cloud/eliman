import 'package:flutter/material.dart';

class RekeyLocksBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const RekeyLocksBookingScreen({super.key, required this.item});

  @override
  State<RekeyLocksBookingScreen> createState() =>
      _RekeyLocksBookingScreenState();
}

class _RekeyLocksBookingScreenState extends State<RekeyLocksBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  int locksCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
            _field(addressCtrl, "Enter your address"),
            const SizedBox(height: 22),
            _title("How many locks need rekeying?"),
            _stepper(
              value: locksCount,
              onChanged: (v) => setState(() => locksCount = v),
            ),
            const SizedBox(height: 22),
            _title("Additional Notes"),
            _field(notesCtrl, "Any extra details..."),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmBtn(),
          ],
        ),
      ),
    );
  }

  Widget _title(String t) => Text(t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700));

  Widget _field(TextEditingController c, String h) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _box(),
      child: TextField(
        controller: c,
        maxLines: 2,
        decoration: InputDecoration(
          hintText: h,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _stepper({required int value, required ValueChanged<int> onChanged}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _box(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Locks", style: TextStyle(fontSize: 16)),
          Row(children: [
            _btn(Icons.remove, () {
              if (value > 1) onChanged(value - 1);
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("$value",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600)),
            ),
            _btn(Icons.add, () => onChanged(value + 1)),
          ])
        ],
      ),
    );
  }

  Widget _btn(IconData i, VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color(0xFF2B6E4F),
            shape: BoxShape.circle,
          ),
          child: Icon(i, color: Colors.white, size: 18),
        ),
      );

  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.07),
            offset: const Offset(0, 4),
          )
        ],
      );

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _box().copyWith(color: const Color(0xFFDFF3E8)),
      child: const Text(
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee reserves your time slot and dispatches a trusted technician.\n\n"
        "You're in safe hands — quality every time.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _confirmBtn() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF25D366),
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
