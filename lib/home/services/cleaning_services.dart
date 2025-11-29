class CleaningService {
  final String title;
  final String subtitle;
  final double minPrice;
  final double maxPrice;
  final String image;
  final String? badge;

  const CleaningService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<CleaningService> cleaningServices = [
  CleaningService(
    title: "Standard Cleaning",
    subtitle: "Regular home cleaning service",
    minPrice: 90,
    maxPrice: 200,
    image: "assets/images/standard_cleaning.jpg",
    badge: "Popular",
  ),
  CleaningService(
    title: "Deep Cleaning",
    subtitle: "Thorough deep cleaning",
    minPrice: 150,
    maxPrice: 400,
    image: "assets/images/deep_cleaning.jpg",
    badge: "Popular",
  ),
  CleaningService(
    title: "Move-In Cleaning",
    subtitle: "Complete cleaning before moving in",
    minPrice: 160,
    maxPrice: 440,
    image: "assets/images/move_in_cleaning.jpg",
  ),
  CleaningService(
    title: "Move-Out Cleaning",
    subtitle: "Final cleaning when moving out",
    minPrice: 180,
    maxPrice: 480,
    image: "assets/images/move_out_cleaning.jpg",
  ),
  CleaningService(
    title: "Airbnb Cleaning",
    subtitle: "Quick turnaround cleaning",
    minPrice: 60,
    maxPrice: 120,
    image: "assets/images/airbnb_cleaning.jpg",
    badge: "Popular",
  ),
  CleaningService(
    title: "Office Cleaning",
    subtitle: "Office space cleaning",
    minPrice: 100,
    maxPrice: 200,
    image: "assets/images/office_cleaning.jpg",
  ),
  CleaningService(
    title: "Post-Construction Cleaning",
    subtitle: "Cleaning after construction",
    minPrice: 200,
    maxPrice: 400,
    image: "assets/images/post_construction_cleaning.jpg",
  ),
  CleaningService(
    title: "Carpet Cleaning",
    subtitle: "Professional carpet cleaning",
    minPrice: 120,
    maxPrice: 250,
    image: "assets/images/carpet_cleaning.jpg",
  ),
  CleaningService(
    title: "Car Standard Cleaning",
    subtitle: "Interior cleaning",
    minPrice: 120,
    maxPrice: 140,
    image: "assets/images/car_standard_cleaning.jpg",
  ),
  CleaningService(
    title: "Car Deep Cleaning",
    subtitle: "Deep interior cleaning",
    minPrice: 300,
    maxPrice: 500,
    image: "assets/images/car_deep_cleaning.jpg",
  ),
  CleaningService(
    title: "Truck Cabin Refresh",
    subtitle: "Truck interior cleaning",
    minPrice: 160,
    maxPrice: 250,
    image: "assets/images/truck_cabin_cleaning.jpg",
  ),
  CleaningService(
    title: "Truck Elite Premium",
    subtitle: "Premium cleaning",
    minPrice: 400,
    maxPrice: 700,
    image: "assets/images/truck_deep_cleaning.jpg",
  ),
  CleaningService(
    title: "Driveway Cleaning",
    subtitle: "Driveway snow removal",
    minPrice: 80,
    maxPrice: 120,
    image: "assets/images/driveway_cleaning.jpg",
  ),
  CleaningService(
    title: "Sidewalk Cleaning",
    subtitle: "Sidewalk snow removal",
    minPrice: 60,
    maxPrice: 100,
    image: "assets/images/sidewalk_cleaning.jpg",
  ),
];
