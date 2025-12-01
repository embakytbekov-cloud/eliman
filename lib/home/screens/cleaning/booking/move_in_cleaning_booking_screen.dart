import 'package:flutter/material.dart';

class StandardCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const StandardCleaningBookingScreen({super.key, required this.item});

  @override
  State<StandardCleaningBookingScreen> createState() =>
      _StandardCleaningBookingScreen();
}

class _StandardCleaningBookingScreen
    extends State<StandardCleaningBookingScreen> {
// Цвета
  final Color buttonGreen = const Color(0xFF25D366); // Confirm button
  final Color darkGreen = const Color(0xFF2B6E4F); // акценты
  final Color softGreen = const Color(0xFFE6F4EC); // инфо-блоки
  final Color softYellow = const Color(0xFFFFF7DD); // Estimate card фон

// Адрес
  final TextEditingController addressCtrl = TextEditingController();

// Комнаты
  int bedrooms = 1;
  int bathrooms = 1;

// Extra tasks
  List<String> selectedExtras = [];

  final List<String> extraOptions = [
    "Inside Cabinets",
    "Inside Drawers",
    "Inside Fridge",
    "Inside Oven",
    "Window Interior",
    "Wall Wipe",
  ];

// Дата (3 дня)
  String? selectedDate;
  late List<String> nextThreeDays;

// Время
  String? selectedTime;
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
    nextThreeDays = List.generate(3, (i) {
      final d = now.add(Duration(days: i));
      return "${d.month}/${d.day}/${d.year}";
    });
  }

  @override
  void dispose() {
    addressCtrl.dispose();
    super.dispose();
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
          widget.item["title"] ?? "Standard Cleaning",
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
            _title("Address"),
            _addressField(),
            const SizedBox(height: 20),
            _title("Select Date"),
            _dateButtons(),
            const SizedBox(height: 20),
            _title("Select Time"),
            _timeSelector(),
            const SizedBox(height: 20),
            _title("Bedrooms"),
            _roomSelector(true),
            const SizedBox(height: 20),
            _title("Bathrooms"),
            _roomSelector(false),
            const SizedBox(height: 20),
            _title("Extra Tasks"),
            _extraTasksCard(),
            const SizedBox(height: 24),
            _estimatedPrice(),
            const SizedBox(height: 24),
            _trustInfoBlock(),
            const SizedBox(height: 28),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

// ---------------- TITLE ----------------
  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w700,
      ),
    );
  }

// ---------------- ADDRESS ----------------
  Widget _addressField() {
    return _card(
      child: TextField(
        controller: addressCtrl,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(14),
          hintText: "Enter service address",
          border: InputBorder.none,
        ),
      ),
    );
  }

// ---------------- DATE (3 кнопки) ----------------
  Widget _dateButtons() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          children: nextThreeDays.map((d) {
            final isSelected = selectedDate == d;
            return ChoiceChip(
              selected: isSelected,
              label: Text(
                d,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedDate = d),
            );
          }).toList(),
        ),
      ),
    );
  }

// ---------------- TIME ----------------
  Widget _timeSelector() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Wrap(
          spacing: 10,
          children: timeSlots.map((slot) {
            final isSelected = selectedTime == slot;
            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selected: isSelected,
              selectedColor: darkGreen,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) => setState(() => selectedTime = slot),
            );
          }).toList(),
        ),
      ),
    );
  }

// ---------------- BED / BATH ----------------
  Widget _roomSelector(bool bedroom) {
    int value = bedroom ? bedrooms : bathrooms;

    return _card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bedroom ? "Bedrooms" : "Bathrooms",
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                _circleBtn(Icons.remove, () {
                  if (value > 1) {
                    setState(() {
                      if (bedroom) {
                        bedrooms--;
                      } else {
                        bathrooms--;
                      }
                    });
                  }
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _circleBtn(Icons.add, () {
                  setState(() {
                    if (bedroom) {
                      bedrooms++;
                    } else {
                      bathrooms++;
                    }
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

// ---------------- EXTRA TASKS CARD ----------------
  Widget _extraTasksCard() {
    return _card(
      child: ListTile(
        title: const Text(
          "Extra Tasks",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          selectedExtras.isEmpty
              ? "None selected"
              : "Selected: ${selectedExtras.length}",
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Icon(Icons.expand_more, color: darkGreen),
        onTap: _openExtraTaskSheet,
      ),
    );
  }

  void _openExtraTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  const Text(
                    "Select Extra Tasks",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: extraOptions.map((title) {
                        final selected = selectedExtras.contains(title);
                        return CheckboxListTile(
                          title: Text(title),
                          value: selected,
                          onChanged: (v) {
                            setState(() {
                              if (v == true) {
                                selectedExtras.add(title);
                              } else {
                                selectedExtras.remove(title);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

// ---------------- ESTIMATED PRICE ----------------
  Widget _estimatedPrice() {
    final min = (widget.item["minPrice"] ?? 80).toInt();
    final max = (widget.item["maxPrice"] ?? 200).toInt();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: softYellow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Estimated Price: \$$min – \$$max",
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

// ---------------- TRUST INFO BLOCK ----------------
  Widget _trustInfoBlock() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "You pay the cleaner only after the job is fully completed.\n\n"
        "A small \$9.99 booking fee guarantees your appointment, locks the time slot, and ensures a trusted professional is dispatched to your address.\n\n"
        "Your home is in safe hands — we deliver quality, every single time.",
        style: TextStyle(fontSize: 14.5, height: 1.4),
      ),
    );
  }

// ---------------- CONFIRM BUTTON ----------------
  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
// Тут потом добавим переход в Telegram / оплату
        },
        child: const Text(
          "Confirm Booking — \$9.99",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

// ---------------- HELPERS ----------------
  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: darkGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
