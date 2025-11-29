class LocksmithService {
  final String title;
  final String subtitle;
  final double minPrice;
  final double maxPrice;
  final String image;
  final String? badge;

  const LocksmithService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<LocksmithService> locksmithServices = [
  LocksmithService(
    title: "Home Lockout",
    subtitle: "Emergency unlock service",
    minPrice: 80,
    maxPrice: 150,
    image: "assets/images/lockout.jpg",
    badge: "Popular",
  ),
  LocksmithService(
    title: "Lock Change",
    subtitle: "Replace old / broken locks",
    minPrice: 120,
    maxPrice: 250,
    image: "assets/images/lock_change.jpg",
  ),
  LocksmithService(
    title: "Smart Lock Install",
    subtitle: "Install smart locks (keypad + WiFi)",
    minPrice: 150,
    maxPrice: 300,
    image: "assets/images/smart_lock.jpg",
  ),
  LocksmithService(
    title: "Rekey Locks",
    subtitle: "Change lock pins & keys",
    minPrice: 60,
    maxPrice: 140,
    image: "assets/images/rekey.jpg",
  ),
];
