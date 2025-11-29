class FurnitureService {
  final String title;
  final String subtitle;
  final double minPrice;
  final double maxPrice;
  final String image;
  final String? badge;

  const FurnitureService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<FurnitureService> furnitureServices = [
  FurnitureService(
    title: "Furniture Assembly",
    subtitle: "Professional furniture assembly",
    minPrice: 60,
    maxPrice: 150,
    image: "assets/images/furniture/assembly.jpg",
    badge: "Popular",
  ),
  FurnitureService(
    title: "Furniture Disassembly",
    subtitle: "Careful furniture disassembly",
    minPrice: 60,
    maxPrice: 150,
    image: "assets/images/furniture/disassembly.jpg",
  ),
  FurnitureService(
    title: "Outdoor Furniture Setup",
    subtitle: "Garden & patio furniture assembly",
    minPrice: 70,
    maxPrice: 160,
    image: "assets/images/furniture/outdoor.jpg",
  ),
  FurnitureService(
    title: "Furniture Repair",
    subtitle: "Fix broken or damaged furniture",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/furniture/repair.jpg",
  ),
];
