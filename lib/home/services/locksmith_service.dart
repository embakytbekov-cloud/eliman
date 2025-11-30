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
    title: "House Lockout",
    subtitle: "Emergency home lockout service",
    minPrice: 75,
    maxPrice: 150,
    image: "assets/images/house_lockout.jpg",
    badge: "Emergency",
  ),
  LocksmithService(
    title: "Car Lockout",
    subtitle: "Locked keys in car",
    minPrice: 60,
    maxPrice: 120,
    image: "assets/images/car_lockout.jpg",
    badge: "Emergency",
  ),
  LocksmithService(
    title: "Lock Installation",
    subtitle: "Install new locks",
    minPrice: 80,
    maxPrice: 200,
    image: "assets/images/lock_installation.jpg",
    badge: "Popular",
  ),
  LocksmithService(
    title: "Lock Repair",
    subtitle: "Fix broken door locks",
    minPrice: 70,
    maxPrice: 150,
    image: "assets/images/lock_repair.jpg",
    badge: "Popular",
  ),
  LocksmithService(
    title: "Rekey Locks",
    subtitle: "Change key for existing lock",
    minPrice: 50,
    maxPrice: 120,
    image: "assets/images/rekey_locks.jpg",
    badge: "Popular",
  ),
  LocksmithService(
    title: "Smart Lock Install",
    subtitle: "Install smart home locks",
    minPrice: 90,
    maxPrice: 220,
    image: "assets/images/smart_lock_install.jpg",
    badge: "Popular",
  ),
  LocksmithService(
    title: "Mailbox Lock Replace",
    subtitle: "Replace mailbox locks",
    minPrice: 40,
    maxPrice: 90,
    image: "assets/images/mail_lock_replace.jpg",
  ),
  LocksmithService(
    title: "Door Handle Replace",
    subtitle: "Handle & knob replacement",
    minPrice: 60,
    maxPrice: 130,
    image: "assets/images/door_handle_replace.jpg",
  ),
  LocksmithService(
    title: "Deadbolt Install",
    subtitle: "Install deadbolt locks",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/deadbolt_install.jpg",
  ),
  LocksmithService(
    title: "Broken Key Extraction",
    subtitle: "Remove broken keys",
    minPrice: 70,
    maxPrice: 150,
    image: "assets/images/broken_key_extraction.jpg",
  ),
];