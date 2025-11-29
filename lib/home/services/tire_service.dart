class TireService {
  final String title;
  final String subtitle;
  final double minPrice;
  final double maxPrice;
  final String image;
  final String? badge;

  const TireService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<TireService> tireServices = [
  TireService(
    title: "Mobile Tire Change",
    subtitle: "On-site tire replacement",
    minPrice: 50,
    maxPrice: 120,
    image: "assets/images/tire_change.jpg",
    badge: "Mobile",
  ),
  TireService(
    title: "Mobile Tire Repair",
    subtitle: "Flat tire patching & repair",
    minPrice: 40,
    maxPrice: 90,
    image: "assets/images/tire_repair.jpg",
  ),
  TireService(
    title: "Tire Rotation",
    subtitle: "Rotate all 4 tires",
    minPrice: 35,
    maxPrice: 60,
    image: "assets/images/tire_rotation.jpg",
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
    subtitle: "Install your spare tire",
    minPrice: 40,
    maxPrice: 80,
    image: "assets/images/spare_tire.jpg",
  ),
];
