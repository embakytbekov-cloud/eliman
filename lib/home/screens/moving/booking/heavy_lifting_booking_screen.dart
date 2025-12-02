import 'package:flutter/material.dart';

class HeavyLiftingBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const HeavyLiftingBookingScreen({super.key, required this.item});

  @override
  State<HeavyLiftingBookingScreen> createState() =>
      _HeavyLiftingBookingScreenState();
}

class _HeavyLiftingBookingScreenState extends State<HeavyLiftingBookingScreen> {
  // CONTROLLERS
  final TextEditingController pickupCtrl = TextEditingController();
  final TextEditingController dropoffCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();
  final TextEditingController otherCtrl = TextEditingController();

  // Item Types
  final List<String> itemTypes = [
    "Couch",
    "Safe",
    "Dresser",
    "Refrigerator",
    "Washer/Dryer",
    "Bed Frame",
    "Boxes",
    "Gym Equipment",
    "Other"
  ];

  String? selectedItem;
  int weightLevel = 1;
  int movers = 2;

  bool needStairs = false;
  bool needTruck = false;

  // DATE / TIME
  String? selectedDate;
  String? selectedTime;

  late List<String> nextThreeDays;

  final List<String> timeSlots = [
    "9 AM – 12 PM",
    "12 PM – 3 PM",
    "3 PM – 6 PM",
    "6 PM – 9 PM",
  ];

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

  // -------------------------------------------------------
  // UI HELPERS
  // -------------------------------------------------------
  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          t,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      );

  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
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

  Widget _yesNo(bool value, Function(bool) onSelect) {
    return Row(
      children: [
        _choice("Yes", value == true, () => onSelect(true)),
        const SizedBox(width: 12),
        _choice("No", value == false, () => onSelect(false)),
      ],
    );
  }

  Widget _choice(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23A373) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
        "Estimated Price: \$120 – \$260\n\n"
        "You’ll never be charged until the job is completed.\n"
        "Our \$9.99 booking fee simply reserves your time slot and dispatches the nearest available movers.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }

  Widget _confirmBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Heavy Lifting booking sent!")),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25D366),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // -------------------------------------------------------
  // UI BUILD
  // -------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.item["title"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pickup
            _title("Pickup Address"),
            _card(
              TextField(
                controller: pickupCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter pickup location",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),

            // Dropoff
            _title("Drop-off Address"),
            _card(
              TextField(
                controller: dropoffCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter drop-off location",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),

            // Item Type
            _title("What item needs lifting?"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: itemTypes.map((type) {
                final selected = selectedItem == type;
                return ChoiceChip(
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  label: Text(
                    type,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                  onSelected: (_) {
                    setState(() => selectedItem = type);
                  },
                );
              }).toList(),
            ),

            if (selectedItem == "Other") ...[
              const SizedBox(height: 12),
              _card(
                TextField(
                  controller: otherCtrl,
                  decoration: const InputDecoration(
                      hintText: "Describe the item",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(14)),
                ),
              ),
            ],

            // Weight Level
            _title("How heavy is the item?"),
            _card(
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Weight Level",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (weightLevel > 1) {
                              setState(() => weightLevel--);
                            }
                          },
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFF2B6E4F),
                            radius: 16,
                            child: Icon(Icons.remove,
                                color: Colors.white, size: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "$weightLevel",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => weightLevel++),
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFF2B6E4F),
                            radius: 16,
                            child:
                                Icon(Icons.add, color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Movers count
            _title("How many movers do you need?"),
            Wrap(
              spacing: 10,
              children: [1, 2, 3].map((n) {
                final selected = movers == n;
                return ChoiceChip(
                  selected: selected,
                  selectedColor: const Color(0xFF2B6E4F),
                  backgroundColor: Colors.grey.shade200,
                  label: Text(
                    "$n Movers",
                    style: TextStyle(
                        color: selected ? Colors.white : Colors.black87),
                  ),
                  onSelected: (_) {
                    setState(() => movers = n);
                  },
                );
              }).toList(),
            ),

            // Stairs
            _title("Stairs involved?"),
            _yesNo(needStairs, (v) => setState(() => needStairs = v)),

            // Truck
            _title("Truck required?"),
            _yesNo(needTruck, (v) => setState(() => needTruck = v)),

            // Date
            _title("Select Date"),
            _dateButtons(),

            // Time
            _title("Select Time"),
            _timeSelector(),

            // Notes
            _title("Extra Notes"),
            _card(
              TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: "Any additional details...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(14)),
              ),
            ),

            const SizedBox(height: 25),

            _trustBlock(),
            const SizedBox(height: 30),

            _confirmBtn(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ---------------- DATE / TIME WIDGETS ----------------

  Widget _dateButtons() {
    return _card(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final selected = selectedDate == d;
            return ChoiceChip(
              selected: selected,
              selectedColor: const Color(0xFF2B6E4F),
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

  Widget _timeSelector() {
    return _card(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final selected = selectedTime == slot;
            return ChoiceChip(
              selected: selected,
              selectedColor: const Color(0xFF2B6E4F),
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
}
