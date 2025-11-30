class ApplianceService {
  final String title;
  final String subtitle;
  final double minPrice;
  final double maxPrice;
  final String image;
  final String? badge;

  const ApplianceService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<ApplianceService> applianceServices = [
  ApplianceService(
    title: "Washer Repair",
    subtitle: "Fix washing machine issues",
    minPrice: 90,
    maxPrice: 250,
    image: "assets/images/washer_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Dryer Repair",
    subtitle: "Dryer heating & drum issues",
    minPrice: 80,
    maxPrice: 230,
    image: "assets/images/dryer_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Refrigerator Repair",
    subtitle: "Cooling, leaking, noise issues",
    minPrice: 120,
    maxPrice: 350,
    image: "assets/images/refrigerator_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Dishwasher Repair",
    subtitle: "Leaks, pump, sensor issues",
    minPrice: 100,
    maxPrice: 300,
    image: "assets/images/dishwasher_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Oven Repair",
    subtitle: "Heating & electrical issues",
    minPrice: 90,
    maxPrice: 250,
    image: "assets/images/oven_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Stove Repair",
    subtitle: "Gas or electric stove fix",
    minPrice: 90,
    maxPrice: 220,
    image: "assets/images/stove_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Microwave Repair",
    subtitle: "Microwave repair service",
    minPrice: 70,
    maxPrice: 150,
    image: "assets/images/microwave_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Garbage Disposal",
    subtitle: "Fix garbage disposal",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/garbage_disposal.jpg",
  ),
  ApplianceService(
    title: "Ice Maker Repair",
    subtitle: "Repair ice maker",
    minPrice: 90,
    maxPrice: 220,
    image: "assets/images/ice_maker_repair.jpg",
  ),
  ApplianceService(
    title: "Range Hood Repair",
    subtitle: "Range hood repair",
    minPrice: 90,
    maxPrice: 220,
    image: "assets/images/rage_hood_repair.jpg",
  ),
];