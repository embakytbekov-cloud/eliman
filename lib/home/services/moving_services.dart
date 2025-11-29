class MovingService {
  final String title;
  final String subtitle;
  final double minPrice;
  final double maxPrice;
  final String image;
  final String? badge;

  const MovingService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<MovingService> movingServices = [
  MovingService(
    title: "Full Apartment Move",
    subtitle: "Complete moving service",
    minPrice: 300,
    maxPrice: 800,
    image: "assets/images/moving_full.jpg",
    badge: "Popular",
  ),
  MovingService(
    title: "Small Move (1–2 items)",
    subtitle: "Quick small-item delivery",
    minPrice: 80,
    maxPrice: 200,
    image: "assets/images/moving_small.jpg",
  ),
  MovingService(
    title: "Furniture Pickup & Delivery",
    subtitle: "Store-to-home delivery",
    minPrice: 100,
    maxPrice: 250,
    image: "assets/images/moving_furniture_delivery.jpg",
  ),
  MovingService(
    title: "Heavy Lifting",
    subtitle: "Two movers for heavy items",
    minPrice: 120,
    maxPrice: 260,
    image: "assets/images/moving_heavy.jpg",
  ),
  MovingService(
    title: "Packing Service",
    subtitle: "Professional packing",
    minPrice: 80,
    maxPrice: 160,
    image: "assets/images/moving_packing.jpg",
  ),
  MovingService(
    title: "Unpacking Service",
    subtitle: "Fast unpacking assistance",
    minPrice: 70,
    maxPrice: 140,
    image: "assets/images/moving_unpacking.jpg",
  ),
  MovingService(
    title: "Storage Move",
    subtitle: "Move items to/from storage",
    minPrice: 150,
    maxPrice: 350,
    image: "assets/images/moving_storage.jpg",
  ),
  MovingService(
    title: "Office Move",
    subtitle: "Professional office relocation",
    minPrice: 400,
    maxPrice: 1200,
    image: "assets/images/moving_office.jpg",
  ),
];
