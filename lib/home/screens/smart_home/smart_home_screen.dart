import 'package:flutter/material.dart';
import 'package:eliman/home/services/smart_home_service.dart'; // модель
import 'package:eliman/home/screens/smart_home/widgets/smart_home_card.dart'; // карточка

class SmartHomeScreen extends StatelessWidget {
  const SmartHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Smart Home Services",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          itemCount: smartHomeServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // ДВА В РЯД
            crossAxisSpacing: 10, // расстояние между колоннами
            mainAxisSpacing: 10, // расстояние между рядами
            mainAxisExtent: 250, // высота карточки
          ),
          itemBuilder: (context, index) {
            final item = smartHomeServices[index];
            return SmartHomeCard(item: item);
          },
        ),
      ),
    );
  }
}
