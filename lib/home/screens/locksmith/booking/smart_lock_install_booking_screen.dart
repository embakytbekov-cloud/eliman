import 'package:flutter/material.dart';

class SmartLockInstallBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SmartLockInstallBookingScreen({super.key, required this.item});

  @override
  State<SmartLockInstallBookingScreen> createState() =>
      _SmartLockInstallBookingScreenState();
}

class _SmartLockInstallBookingScreenState
    extends State<SmartLockInstallBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  bool removeOldLock = false;
  bool needDoorAdjustment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.item["title"],
          style: const TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
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
            _title("Options"),
            _checkbox("Remove old lock", removeOldLock,
                (v) => setState(() => removeOldLock = v)),
            _checkbox("Door alignment/adjustment needed", needDoorAdjustment,
                (v) => setState(() => needDoorAdjustment = v)),
            const SizedBox(height: 22),
            _title("Notes"),
            _field(notesCtrl, "Any additional details..."),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmBtn(),
          ],
        ),
      ),
    );
  }

  Widget _checkbox(String t, bool v, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(t),
      activeColor: const Color(0xFF2B6E4F),
      value: v,
      onChanged: (val) => onChanged(val ?? false),
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

  BoxDecoration _box() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.07),
                offset: const Offset(0, 4))
          ]);

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _box().copyWith(color: const Color(0xFFDFF3E8)),
      child: const Text(
        "You’ll never be charged until the job is completed.\n\n"
        "The \$9.99 booking fee secures your time slot and dispatches a trusted pro.\n\n"
        "Reliable, fast and secure — every time.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _confirmBtn() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25D366),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: () {},
          child: const Text(
            "Confirm Booking — \$9.99",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      );
}
