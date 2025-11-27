import 'package:flutter/material.dart';
import 'widgets/category_item.dart';
import 'widgets/service_item.dart';
import 'widgets/why_choose_us.dart';
import 'package:eliman/home/screens/cleaning_screen.dart';
import 'screens/handyman_screen.dart';
import 'package:eliman/home/screens/appliance_screen.dart';
import 'package:eliman/home/screens/moving_screen.dart';
import 'screens/furniture_screen.dart';
import 'screens/locksmith_screen.dart';
import 'screens/tire_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // ⭐ ДОБАВЛЕНО — выбранная категория
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---- BOTTOM NAV BAR ----
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey.shade500,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // ---- HEADER ----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 20),
                      const SizedBox(width: 6),
                      const Text(
                        "New York, NY",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                      const Spacer(),
                      const Icon(Icons.calendar_today_outlined, size: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ---- TITLE ----
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "ELIMAN",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                // ---- SUBTITLE ----
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Service pros on demand",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 20),

                // ---- SEARCH ----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 16),
                        Icon(Icons.search, color: Colors.black54),
                        SizedBox(width: 12),
                        Text(
                          "Search services...",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ---- CATEGORIES ----
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  height: 220,
                  child: GridView.count(
                    crossAxisCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.78,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      // ⭐⭐ Я СДЕЛАЛ ВСЕ КАТЕГОРИИ КЛИКАБЕЛЬНЫМИ ⭐⭐

                      CategoryItem(
                        icon: Icons.grid_view,
                        label: "Top",
                        highlighted: selectedCategory == 0,
                        onTap: () => setState(() => selectedCategory = 0),
                      ),
                      CategoryItem(
                        icon: Icons.cleaning_services,
                        label: "Cleaning",
                        highlighted: selectedCategory == 1,
                        onTap: () {
                          setState(() => selectedCategory = 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CleaningScreen()),
                          );
                        },
                      ),
                      CategoryItem(
                        icon: Icons.handyman,
                        label: "Handyman",
                        highlighted: selectedCategory == 2,
                        onTap: () {
                          setState(() => selectedCategory = 2);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HandymanScreen()),
                          );
                        },
                      ),
                      CategoryItem(
                        icon: Icons.local_shipping,
                        label: "Moving",
                        highlighted: selectedCategory == 3,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MovingScreen()),
                          );
                        },
                      ),
                      CategoryItem(
                        icon: Icons.chair,
                        label: "Furniture",
                        highlighted: selectedCategory == 4,
                        onTap: () {
                          setState(() => selectedCategory = 4);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FurnitureScreen()),
                          );
                        },
                      ),
                      CategoryItem(
                        icon: Icons.lock_outline,
                        label: "Locksmith",
                        highlighted: selectedCategory == 5,
                        onTap: () {
                          setState(() => selectedCategory = 5);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LocksmithScreen()),
                          );
                        },
                      ),
                      CategoryItem(
                        icon: Icons.settings,
                        label: "Appliance",
                        highlighted: selectedCategory == 6,
                        onTap: () {
                          setState(() => selectedCategory = 6);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ApplianceScreen()));
                        },
                      ),
                      CategoryItem(
                        icon: Icons.circle_outlined,
                        label: "Tire (Mobile)",
                        highlighted: selectedCategory == 7,
                        onTap: () => setState(() => selectedCategory = 7),
                      ),
                    ],
                  ),
                ),

                // ---- TOP SERVICES ----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Services",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "10 services",
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ---- SERVICES GRID ----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: demoServices.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) {
                      return ServiceItem(service: demoServices[index]);
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // ---- WHY CHOOSE US ----
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Why choose us?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),

                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: WhyChooseUs(),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---- SERVICES LIST ----
final List<Map<String, dynamic>> demoServices = [
  {
    "badge": "Popular",
    "title": "Tire Change (Mobile)",
    "subtitle": "Mobile tire replacement service",
    "price": "\$60 - \$120",
    "image": "assets/images/tire_change.jpg"
  },
  {
    "badge": "Emergency",
    "title": "House Lockout",
    "subtitle": "Emergency lockout service",
    "price": "\$75 - \$150",
    "image": "assets/images/house_lockout.jpg"
  },
  {
    "badge": "Popular",
    "title": "Lock Installation",
    "subtitle": "Install new locks",
    "price": "\$80 - \$200",
    "image": "assets/images/lock_installation.jpg"
  },
  {
    "badge": "Popular",
    "title": "TV Mounting",
    "subtitle": "Professional TV wall mounting",
    "price": "\$75 - \$150",
    "image": "assets/images/tv_mounting.jpg"
  },
  {
    "badge": "Popular",
    "title": "Furniture Assembly",
    "subtitle": "Assemble any furniture",
    "price": "\$60 - \$150",
    "image": "assets/images/furniture_assembly.jpg"
  },
  {
    "badge": "Popular",
    "title": "Packing",
    "subtitle": "Professional packing service",
    "price": "\$150 - \$400",
    "image": "assets/images/packing.jpg"
  },
  {
    "badge": "Popular",
    "title": "Washer Repair",
    "subtitle": "Washing machine repair",
    "price": "\$90 - \$250",
    "image": "assets/images/washer_repair.jpg"
  },
  {
    "badge": "Popular",
    "title": "Full Apartment Move",
    "subtitle": "Complete moving service",
    "price": "\$300 - \$800",
    "image": "assets/images/full_apartment_move.jpg"
  },
  {
    "badge": "Popular",
    "title": "Car Lockout",
    "subtitle": "Emergency car lockout service",
    "price": "\$60 - \$120",
    "image": "assets/images/car_lockout.jpg"
  },
  {
    "badge": "Popular",
    "title": "Standard Cleaning",
    "subtitle": "Regular home cleaning service",
    "price": "\$80 - \$150",
    "image": "assets/images/standard_cleaning.jpg"
  },
];
