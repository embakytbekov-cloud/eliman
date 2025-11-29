import 'package:flutter/material.dart';

class SidewalkCleaningBookingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SidewalkCleaningBookingScreen({
    super.key,
    required this.item,
  });

  @override
  State<SidewalkCleaningBookingScreen> createState() =>
      _SidewalkCleaningBookingScreenState();
}

class _SidewalkCleaningBookingScreenState
    extends State<SidewalkCleaningBookingScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> pickTime() async {
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          item["title"] ?? "Sidewalk Cleaning",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// DATE PICKER
            buildTitle("Select Date"),
            buildCard(
              child: ListTile(
                title: Text(
                  selectedDate == null
                      ? "Choose date"
                      : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
                ),
                trailing: const Icon(Icons.calendar_today, color: Colors.green),
                onTap: pickDate,
              ),
            ),

            const SizedBox(height: 20),

            /// TIME PICKER
            buildTitle("Select Time"),
            buildCard(
              child: ListTile(
                title: Text(
                  selectedTime == null
                      ? "Choose time"
                      : selectedTime!.format(context),
                ),
                trailing: const Icon(Icons.access_time, color: Colors.green),
                onTap: pickTime,
              ),
            ),

            const SizedBox(height: 20),

            /// ADDRESS
            buildTitle("Service Address"),
            buildCard(
              child: TextField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Enter sidewalk location",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// NOTES
            buildTitle("Additional Notes"),
            buildCard(
              child: TextField(
                controller: notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText:
                      "Sidewalk size, stains, pressure wash notes, instructions...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 35),

            /// CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == null || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select date & time"),
                      ),
                    );
                    return;
                  }

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${item['title']} booked successfully!"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23A373),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Confirm Booking",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// SECTION TITLE
  Widget buildTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// WHITE CARD
  Widget buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
