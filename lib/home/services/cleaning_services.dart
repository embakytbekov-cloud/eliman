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
    minPrice: 80, // 90 → 80
    maxPrice: 190, // 200 → 190
    image: "assets/images/standard_cleaning.jpg",
    badge: "Popular",
  ),

  CleaningService(
    title: "Deep Cleaning",
    subtitle: "Thorough deep cleaning",
    minPrice: 140, // 150 → 140
    maxPrice: 390, // 400 → 390
    image: "assets/images/deep_cleaning.jpg",
    badge: "Popular",
  ),

  CleaningService(
    title: "Move-In Cleaning",
    subtitle: "Complete cleaning before moving in",
    minPrice: 150, // 160 → 150
    maxPrice: 430, // 440 → 430
    image: "assets/images/move_in_cleaning.jpg",
  ),

  CleaningService(
    title: "Move-Out Cleaning",
    subtitle: "Final cleaning when moving out",
    minPrice: 170, // 180 → 170
    maxPrice: 470, // 480 → 470
    image: "assets/images/move_out_cleaning.jpg",
  ),

  CleaningService(
    title: "Airbnb Cleaning",
    subtitle: "Quick turnaround cleaning",
    minPrice: 50, // 60 → 50
    maxPrice: 110, // 120 → 110
    image: "assets/images/airbnb_cleaning.jpg",
    badge: "Popular",
  ),

  CleaningService(
    title: "Office Cleaning",
    subtitle: "Office space cleaning",
    minPrice: 90, // 100 → 90
    maxPrice: 190, // 200 → 190
    image: "assets/images/office_cleaning.jpg",
  ),

  CleaningService(
    title: "Post-Construction Cleaning",
    subtitle: "Cleaning after construction",
    minPrice: 190, // 200 → 190
    maxPrice: 390, // 400 → 390
    image: "assets/images/post_construction_cleaning.jpg",
  ),

  CleaningService(
    title: "Carpet Cleaning",
    subtitle: "Professional carpet cleaning",
    minPrice: 110, // 120 → 110
    maxPrice: 240, // 250 → 240
    image: "assets/images/carpet_cleaning.jpg",
  ),

  // 🔥 Vehicle Cleaning — объединённая
  CleaningService(
    title: "Vehicle Interior Cleaning",
    subtitle: "Car & truck interior detailing",
    minPrice: 60,
    maxPrice: 300,
    image: "assets/images/vehicle_cleaning.jpg",
    badge: "Popular",
  ),

  CleaningService(
    title: "Gutter Cleaning",
    subtitle: "Cleaning gutters and removing debris",
    minPrice: 70, // 80 → 70
    maxPrice: 240, // 250 → 240
    image: "assets/images/gutter_cleaning.jpg",
    badge: "Popular",
  ),

  CleaningService(
    title: "Lawn Care",
    subtitle: "Mowing and maintaining the lawn",
    minPrice: 55, // 65 → 55
    maxPrice: 140, // 150 → 140
    image: "assets/images/lawn_care.jpg",
    badge: "Popular",
  ),

  CleaningService(
    title: "Sidewalk Cleaning",
    subtitle: "Sidewalk snow removal",
    minPrice: 50, // 60 → 50
    maxPrice: 90, // 100 → 90
    image: "assets/images/sidewalk_cleaning.jpg",
    badge: "Popular",
  ),

  CleaningService(
    title: "Outside Window Cleaning",
    subtitle: "Exterior window washing",
    minPrice: 60, // 70 → 60
    maxPrice: 170, // 180 → 170
    image: "assets/images/outside_window_cleaning.jpg",
    badge: "Popular",
  ),
];
