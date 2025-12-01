import 'package:flutter/material.dart';

class FaucetRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const FaucetRepairBookingScreen({super.key, required this.item});

  @override
  State<FaucetRepairBookingScreen> createState() =>
      _FaucetRepairBookingScreenState();
}

class _FaucetRepairBookingScreenState extends State<FaucetRepairBookingScreen> {
  // COLORS
  final Color buttonGreen = const Color(0xFF25D366);
  final Color darkGreen = const Color(0xFF2B6E4F);
  final Color softGreen = const Color(0xFFDFF3E8);

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();

  // TYPES OF FAUCET
  final List<String> faucetTypes = [
    "Kitchen faucet",
    "Bathroom faucet",
    "Shower faucet",
    "Bathtub faucet",
    "Outdoor faucet",
  ];
  String? selectedFaucet;

  // ISSUES
  final List<String> issues = [
    "Leaking faucet",
    "Low water pressure",
    "Loose / broken handle",
    "Cartridge replacement",
    "Full faucet replacement",
    "Water dripping under sink",
  ];
  String? selectedIssue;

  // Water shut-off
  final List<String> shutoff = ["Yes", "No", "Not sure"];
  String? selectedShutoff;

  // Extras
  final List<String> extras = [
    "Install new faucet (I have it)",
    "Pick up faucet from store",
    "Seal/Caulk faucet area",
    "Check sink plumbing",
    "Replace supply lines",
  ];
  List<String> selectedExtras = [];

  // DATE — 3 DAYS
  String? selectedDate;
  late List<String> nextThreeDays;

  // TIME SLOTS
  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];
  String? selectedTime;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    nextThreeDays = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service Address"),
            _addressField(),
            const SizedBox(height: 25),
            _title("Type of Faucet"),
            _singleChipSelector(faucetTypes, selectedFaucet,
                (v) => setState(() => selectedFaucet = v)),
            const SizedBox(height: 25),
            _title("What is the issue?"),
            _singleChipSelector(issues, selectedIssue,
                (v) => setState(() => selectedIssue = v)),
            const SizedBox(height: 25),
            _title("Is water shut-off working?"),
            _singleChipSelector(shutoff, selectedShutoff,
                (v) => setState(() => selectedShutoff = v)),
            const SizedBox(height: 25),
            _title("Extra Options"),
            _multiChipSelector(),
            const SizedBox(height: 25),
            _title("Select Date"),
            _dateSelector(),
            const SizedBox(height: 25),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 25),
            _estimatedPrice(),
            const SizedBox(height: 25),
            _trustBlock(),
            const SizedBox(height: 30),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  // TITLE
  Widget _title(String t) => Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );

  // ADDRESS
  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          hintText: "Enter full address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // SINGLE SELECTOR
  Widget _singleChipSelector(
      List<String> list, String? selected, Function(String) onSelect) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: list.map((txt) {
        final bool active = selected == txt;
        return GestureDetector(
          onTap: () => onSelect(txt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: active ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              txt,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // MULTI SELECTOR
  Widget _multiChipSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: extras.map((txt) {
        final active = selectedExtras.contains(txt);
        return GestureDetector(
          onTap: () {
            setState(() {
              active ? selectedExtras.remove(txt) : selectedExtras.add(txt);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: active ? darkGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              txt,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black87, fontSize: 14),
            ),
          ),
        );
      }).toList(),
    );
  }

  // DATE SELECTOR
  Widget _dateSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                d,
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

  // TIME SELECTOR
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              selected: selected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              label: Text(
                slot,
                style:
                    TextStyle(color: selected ? Colors.white : Colors.black87),
              ),
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ESTIMATED PRICE
  Widget _estimatedPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$70 – \$150\n(Depends on faucet type & complexity)",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  // TRUST BLOCK
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You pay the handyman only after the job is fully completed.\n\n"
        "A small \$9.99 booking fee guarantees your appointment, locks the time slot, "
        "and ensures a trusted professional is dispatched to your address.\n\n"
        "Your home is in safe hands — we deliver quality every single time.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  // CONFIRM BUTTON
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonGreen,
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

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.07),
          ),
        ],
      ),
      child: child,
    );
  }
}
