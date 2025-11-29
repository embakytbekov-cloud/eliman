class HandymanService {
  final String title;
  final String subtitle;
  final double minPrice;
  final double maxPrice;
  final String image;
  final String? badge;

  const HandymanService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<HandymanService> handymanServices = [
  HandymanService(
    title: "TV Mounting",
    subtitle: "Professional TV wall mounting",
    minPrice: 75,
    maxPrice: 150,
    image: "assets/images/tv_mounting.jpg",
    badge: "Popular",
  ),
  HandymanService(
    title: "Light Fixture Install",
    subtitle: "Replace or install new lights",
    minPrice: 60,
    maxPrice: 120,
    image: "assets/images/handyman_light.jpg",
    badge: "Popular",
  ),
  HandymanService(
    title: "Ceiling Fan Install",
    subtitle: "Install or replace ceiling fans",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/handyman_fan.jpg",
    badge: "Popular",
  ),
  HandymanService(
    title: "Faucet Repair",
    subtitle: "Fix leaking faucets",
    minPrice: 70,
    maxPrice: 130,
    image: "assets/images/handyman_faucet.jpg",
  ),
  HandymanService(
    title: "Drywall Repair",
    subtitle: "Repair damaged drywall",
    minPrice: 90,
    maxPrice: 200,
    image: "assets/images/handyman_drywall.jpg",
  ),
];
