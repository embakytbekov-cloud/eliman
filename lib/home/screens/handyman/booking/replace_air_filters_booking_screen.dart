import 'package:flutter/material.dart';

class ReplaceAirFiltersBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const ReplaceAirFiltersBookingScreen({super.key, required this.item});

  @override
  State<ReplaceAirFiltersBookingScreen> createState() =>
      _ReplaceAirFiltersBookingScreenState();
}

class _ReplaceAirFiltersBookingScreenState
    extends State<ReplaceAirFiltersBookingScreen> {
  final Color green = const Color(0xFF23A373);

  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();

  // Filter Type
  String? filterType;

  final List<String> filterTypes = [
    "HVAC Air Filter",
    "Furnace Filter",
    "Refrigerator Filter",
    "Water Filter",
    "Bathroom Vent Filter",
    "Not sure — diagnose",
  ];

  // Filter Quantity
  int filterCount = 1;

  // Do you have the filters?
  bool? hasFilters;

  // Date + Time
  String? selectedDay;
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
      "${now.month}/${now.day + 1}/${now.year}",
      "${now.month}/${now.day + 2}/${now.year}",
    ];
  }

  @override
  Widget build(BuildContext context) {
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
                  border: InputBorder.none,
                  hintText: "Enter your address",
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Filter Type"),
            _card(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: filterTypes.map((t) {
                  final selected = filterType == t;

                  return ChoiceChip(
                    label: Text(t),
                    selected: selected,
                    selectedColor: green,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) => setState(() => filterType = t),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("How many filters?"),
            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Quantity", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      _circleBtn(Icons.remove, () {
                        if (filterCount > 1) {
                          setState(() => filterCount--);
                        }
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "$filterCount",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                      ),
                      _circleBtn(Icons.add, () {
                        setState(() => filterCount++);
                      }),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            _title("Do you already have the filters?"),
            Row(
              children: [
                _bigChoice("Yes", hasFilters == true, () {
                  setState(() => hasFilters = true);
                }),
                const SizedBox(width: 12),
                _bigChoice("No", hasFilters == false, () {
                  setState(() => hasFilters = false);
                }),
              ],
            ),
            const SizedBox(height: 25),
            _title("Extra Notes"),
            _card(
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Optional...",
                ),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Day"),
            _card(
              child: Wrap(
                spacing: 10,
                children: nextThreeDays.map((d) {
                  final selected = selectedDay == d;

                  return ChoiceChip(
                    label: Text(
                      d,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: selected,
                    selectedColor: green,
                    backgroundColor: Colors.grey.shade200,
                    onSelected: (_) => setState(() => selectedDay = d),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("Select Time"),
            _card(
              child: Wrap(
                spacing: 10,
                children: timeSlots.map((slot) {
                  final selected = selectedTime == slot;

                  return ChoiceChip(
                    label: Text(
                      slot,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: selected,
                    selectedColor: green,
                    backgroundColor: Colors.grey.shade200,
                    onSelected: (_) => setState(() => selectedTime = slot),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            _title("Estimated Price"),
            _card(
              child: Text(
                "\$${widget.item['minPrice']} – \$${widget.item['maxPrice']}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 25),
            _trustBlock(),
            const SizedBox(height: 25),
            _confirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------ UI HELPERS ------------------

  Widget _title(String t) {
    return Text(
      t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(.08),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: green, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _bigChoice(String text, bool selected, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _trustBlock() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: green.withOpacity(.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Estimated Price: \$XX – \$XX\n"
        "You'll never be charged until the job is completed.\n\n"
        "The \$9.99 booking fee simply reserves your time slot and sends your request to the best available professional.\n\n"
        "We’ll notify you as soon as someone accepts your request.",
        style: TextStyle(fontSize: 15, height: 1.4),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: green,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
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
}
