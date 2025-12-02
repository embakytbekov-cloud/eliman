import 'package:flutter/material.dart';

class DryerRepairBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DryerRepairBookingScreen({super.key, required this.item});

  @override
  State<DryerRepairBookingScreen> createState() =>
      _DryerRepairBookingScreenState();
}

class _DryerRepairBookingScreenState extends State<DryerRepairBookingScreen> {
  // COLORS WiBi STYLE
  final Color accent = const Color(0xFF23A373); // основной зелёный
  final Color buttonGreen = const Color(0xFF25D366); // WhatsApp зелёный
  final Color softGreen = const Color(0xFFDFF3E8); // фон инфо-блоков

  // CONTROLLERS
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController brandCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // DATE / TIME
  late List<String> nextThreeDays;
  String? selectedDate;

  final List<String> timeSlots = const [
    "9:00 AM – 12:00 PM",
    "12:00 PM – 3:00 PM",
    "3:00 PM – 6:00 PM",
    "6:00 PM – 9:00 PM",
  ];
  String? selectedTime;

  // DRYER TYPE & LOCATION
  String? dryerType; // Electric / Gas
  String? dryerLocation; // Laundry room / Basement / Closet / Garage / Other

  // ISSUES (AIRBNB TAG-CHIPS STYLE)
  final List<String> issueOptions = const [
    "No heat",
    "Not spinning",
    "Very loud noise",
    "Won't start",
    "Stops mid-cycle",
    "Burning smell",
    "Takes too long to dry",
    "Other issue"
  ];
  final Set<String> selectedIssues = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    nextThreeDays = [
      "${now.month}/${now.day}/${now.year}",
      "${now.add(const Duration(days: 1)).month}/${now.add(const Duration(days: 1)).day}/${now.add(const Duration(days: 1)).year}",
      "${now.add(const Duration(days: 2)).month}/${now.add(const Duration(days: 2)).day}/${now.add(const Duration(days: 2)).year}",
    ];
    selectedDate = nextThreeDays.first;
  }

  @override
  Widget build(BuildContext context) {
    final num minPriceNum = (widget.item["minPrice"] ?? 0) as num;
    final num maxPriceNum = (widget.item["maxPrice"] ?? 0) as num;
    final int minPrice = minPriceNum.toInt();
    final int maxPrice = maxPriceNum.toInt();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.item["title"] ?? "Dryer Repair",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Service address"),
            _addressField(),
            const SizedBox(height: 22),
            _title("Appliance details"),
            _applianceDetailsCard(),
            const SizedBox(height: 22),
            _title("What’s wrong with the dryer?"),
            _issuesChips(),
            const SizedBox(height: 22),
            _title("Select day"),
            _dateChips(),
            const SizedBox(height: 22),
            _title("Select time"),
            _timeChips(),
            const SizedBox(height: 22),
            _title("Extra notes (optional)"),
            _notesField(),
            const SizedBox(height: 26),
            _estimatedPriceBlock(minPrice, maxPrice),
            const SizedBox(height: 24),
            _trustBlock(),
            const SizedBox(height: 32),
            _confirmButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // TITLES
  // ------------------------------
  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ------------------------------
  // ADDRESS
  // ------------------------------
  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        maxLines: 2,
        decoration: const InputDecoration(
          hintText: "Enter service address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ------------------------------
  // APPLIANCE DETAILS (BRAND + TYPE + LOCATION)
  // ------------------------------
  Widget _applianceDetailsCard() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dryer brand / model (optional)",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: brandCtrl,
              decoration: const InputDecoration(
                hintText: "Example: Samsung, LG, Whirlpool...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              "Dryer type",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: [
                _pillChoice("Electric", dryerType == "Electric", () {
                  setState(() => dryerType = "Electric");
                }),
                _pillChoice("Gas", dryerType == "Gas", () {
                  setState(() => dryerType = "Gas");
                }),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              "Dryer location",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _pillChoice("Laundry room", dryerLocation == "Laundry room",
                    () {
                  setState(() => dryerLocation = "Laundry room");
                }),
                _pillChoice("Basement", dryerLocation == "Basement", () {
                  setState(() => dryerLocation = "Basement");
                }),
                _pillChoice("Closet", dryerLocation == "Closet", () {
                  setState(() => dryerLocation = "Closet");
                }),
                _pillChoice("Garage", dryerLocation == "Garage", () {
                  setState(() => dryerLocation = "Garage");
                }),
                _pillChoice("Other", dryerLocation == "Other", () {
                  setState(() => dryerLocation = "Other");
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillChoice(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? accent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // ISSUES CHIPS
  // ------------------------------
  Widget _issuesChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: issueOptions.map((issue) {
            final bool selected = selectedIssues.contains(issue);
            return ChoiceChip(
              label: Text(
                issue,
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (v) {
                setState(() {
                  if (v) {
                    selectedIssues.add(issue);
                  } else {
                    selectedIssues.remove(issue);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // DATE CHIPS (3 DAYS)
  // ------------------------------
  Widget _dateChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final bool selected = selectedDate == d;
            return ChoiceChip(
              label: Text(
                d,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) {
                setState(() => selectedDate = d);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // TIME CHIPS
  // ------------------------------
  Widget _timeChips() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: timeSlots.map((slot) {
            final bool selected = selectedTime == slot;
            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              selected: selected,
              selectedColor: accent,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) {
                setState(() => selectedTime = slot);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------------------
  // NOTES
  // ------------------------------
  Widget _notesField() {
    return _card(
      child: TextField(
        controller: notesCtrl,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Any extra details (sounds, errors, age of dryer)...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  // ------------------------------
  // ESTIMATED PRICE + BOOKING TEXT
  // ------------------------------
  Widget _estimatedPriceBlock(int minPrice, int maxPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$$minPrice – \$$maxPrice\n\n"
        "You’ll never be charged until the job is completed.\n\n"
        "Our \$9.99 booking fee simply reserves your time slot and begins "
        "the search for the best available professional in your area.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: const TextStyle(
          fontSize: 14,
          height: 1.45,
        ),
      ),
    );
  }

  // ------------------------------
  // TRUST BLOCK (ЗЕЛЁНЫЙ ТЕКСТ)
  // ------------------------------
  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: softGreen),
      ),
      child: Text(
        "You pay the technician only after the repair is fully completed "
        "and you’re satisfied with the work.",
        style: TextStyle(
          fontSize: 14,
          height: 1.4,
          color: accent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ------------------------------
  // CONFIRM BUTTON
  // ------------------------------
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: позже — отправка в Telegram / Supabase
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Dryer repair booking sent!"),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
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

  // ------------------------------
  // CARD WRAPPER
  // ------------------------------
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
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: child,
    );
  }
}
