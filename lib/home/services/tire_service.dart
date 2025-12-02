class TireService {
  final String title;
  final String subtitle;
  final int minPrice;
  final int maxPrice;
  final String image;
  final String? badge;

  TireService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

List<TireService> tireServices = [
  TireService(
    title: "Tire Change (At Home)",
    subtitle: "Fast mobile tire replacement at your location",
    minPrice: 40,
    maxPrice: 80,
    image: "assets/images/tire_change.jpg",
    badge: "Popular",
  ),
  TireService(
    title: "Flat Tire Repair",
    subtitle: "Quick puncture repair and plug service",
    minPrice: 35,
    maxPrice: 70,
    image: "assets/images/flat_tire.jpg",
  ),
  TireService(
    title: "Mobile Tire Repair",
    subtitle: "On-site tire inspection & repair",
    minPrice: 40,
    maxPrice: 90,
    image: "assets/images/mobile_tire_repair.jpg",
  ),
  TireService(
    title: "Tire Rotation",
    subtitle: "Improve tire wear with 4-tire rotation",
    minPrice: 30,
    maxPrice: 60,
    image: "assets/images/tire_rotation.jpg",
  ),
  TireService(
    title: "Fuel Delivery",
    subtitle: "Emergency gas delivery to your vehicle",
    minPrice: 30,
    maxPrice: 70,
    image: "assets/images/fuel_delivery.jpg",
  ),
  TireService(
    title: "Jump Start",
    subtitle: "Instant battery jump service",
    minPrice: 30,
    maxPrice: 60,
    image: "assets/images/jump_start.jpg",
  ),
  TireService(
    title: "Spare Tire Install",
    subtitle: "Install your spare tire quickly",
    minPrice: 40,
    maxPrice: 80,
    image: "assets/images/spare_tire.jpg",
  ),
];
