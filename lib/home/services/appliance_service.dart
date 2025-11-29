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
    subtitle: "Washer not draining, spinning or starting",
    minPrice: 90,
    maxPrice: 250,
    image: "assets/images/washer_repair.jpg",
    badge: "Popular",
  ),
  ApplianceService(
    title: "Dryer Repair",
    subtitle: "Dryer not heating or tumbling",
    minPrice: 90,
    maxPrice: 250,
    image: "assets/images/dryer_repair.jpg",
  ),
  ApplianceService(
    title: "Fridge Repair",
    subtitle: "Fridge not cooling or leaking",
    minPrice: 120,
    maxPrice: 350,
    image: "assets/images/fridge_repair.jpg",
  ),
  ApplianceService(
    title: "Oven / Stove Repair",
    subtitle: "Oven not heating or stove not working",
    minPrice: 100,
    maxPrice: 280,
    image: "assets/images/oven_repair.jpg",
  ),
  ApplianceService(
    title: "Dishwasher Repair",
    subtitle: "Water not draining or not cleaning dishes",
    minPrice: 100,
    maxPrice: 260,
    image: "assets/images/dishwasher_repair.jpg",
  ),
  ApplianceService(
    title: "Microwave Repair",
    subtitle: "Microwave not heating / no power",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/microwave_repair.jpg",
  ),
];
