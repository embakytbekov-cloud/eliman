import 'package:flutter/material.dart';

class LockInstallationBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const LockInstallationBookingScreen({super.key, required this.item});

  @override
  State<LockInstallationBookingScreen> createState() =>
      _LockInstallationBookingScreenState();
}

class _LockInstallationBookingScreenState
    extends State<LockInstallationBookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  final Color wibiGreen = const Color(0xFF23A373);

  String? selectedLockType;

  final List<String> lockTypes = [
    "Standard lock",
    "Deadbolt",
    "High-security lock",
    "Smart lock",
    "Keypad lock",
  ];

  bool needRemoval = false;
  bool needMultiple = false;

  int lockCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Lock Installation",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Your Address"),
            _card(
              child: TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter installation address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Lock Type"),
            Wrap(
              spacing: 10,
              children: lockTypes.map((e) {
                final selected = selectedLockType == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: wibiGreen,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => selectedLockType = e),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            _title("Do you need old lock removed?"),
            SwitchListTile(
              value: needRemoval,
              activeColor: wibiGreen,
              title: const Text("Remove existing lock"),
              onChanged: (v) => setState(() => needRemoval = v),
            ),
            const SizedBox(height: 20),
            _title("How many locks?"),
            Row(
              children: [
                _stepBtn(Icons.remove, () {
                  if (lockCount > 1) setState(() => lockCount--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "$lockCount",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _stepBtn(Icons.add, () => setState(() => lockCount++)),
              ],
            ),
            const SizedBox(height: 30),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _stepBtn(IconData icon, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: wibiGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.06),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$80 – \$200\n\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee reserves your time slot and begins matchmaking with the best available locksmith.\n\n"
        "We’ll notify you as soon as your request is accepted.",
        style: TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: wibiGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
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
