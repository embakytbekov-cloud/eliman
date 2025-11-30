class SmartHomeService {
  final String title;
  final String subtitle;
  final int minPrice;
  final int maxPrice;
  final String image;
  final String? badge;

  const SmartHomeService({
    required this.title,
    required this.subtitle,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
    this.badge,
  });
}

const List<SmartHomeService> smartHomeServices = [
  // -----------------------------
  // ⭐ SMART SECURITY
  // -----------------------------
  SmartHomeService(
    title: "Video Doorbell Install",
    subtitle: "Install Ring, Nest or other smart video doorbells",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/smart_doorbell.jpg",
    badge: "Popular",
  ),
  SmartHomeService(
    title: "Security Camera Install",
    subtitle: "Install indoor or outdoor WiFi security cameras",
    minPrice: 90,
    maxPrice: 220,
    image: "assets/images/security_camera.jpg",
  ),
  SmartHomeService(
    title: "Smart Lock Install",
    subtitle: "Install and configure smart home locks",
    minPrice: 90,
    maxPrice: 220,
    image: "assets/images/smart_lock.jpg",
    badge: "Popular",
  ),
  SmartHomeService(
    title: "Garage Smart Opener",
    subtitle: "Install smart garage door opener systems",
    minPrice: 120,
    maxPrice: 250,
    image: "assets/images/smart_garage.jpg",
  ),
  SmartHomeService(
    title: "Doorbell Replace/Upgrade",
    subtitle: "Replace existing doorbell with a smart one",
    minPrice: 70,
    maxPrice: 150,
    image: "assets/images/doorbell_replace.jpg",
  ),

  // -----------------------------
  // ⭐ SMART COMFORT
  // -----------------------------
  SmartHomeService(
    title: "Smart Thermostat Install",
    subtitle: "Install Nest, Ecobee or other smart thermostats",
    minPrice: 120,
    maxPrice: 250,
    image: "assets/images/smart_thermostat.jpg",
    badge: "Popular",
  ),
  SmartHomeService(
    title: "Smart AC Controller",
    subtitle: "Install AC smart controllers like Sensibo",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/smart_ac.jpg",
  ),
  SmartHomeService(
    title: "Smart Heater Controller",
    subtitle: "Install smart heater control systems",
    minPrice: 70,
    maxPrice: 160,
    image: "assets/images/smart_heater.jpg",
  ),

  // -----------------------------
  // ⭐ SMART LIGHTING & NETWORK
  // -----------------------------
  SmartHomeService(
    title: "Smart Switch Install",
    subtitle: "Install smart light switches and WiFi switches",
    minPrice: 70,
    maxPrice: 150,
    image: "assets/images/smart_switch.jpg",
  ),
  SmartHomeService(
    title: "Smart Dimmer Install",
    subtitle: "replace dimmers with smart dimmers",
    minPrice: 70,
    maxPrice: 150,
    image: "assets/images/smart_dimmer.jpg",
  ),
  SmartHomeService(
    title: "Smart Bulbs & Hubs Setup",
    subtitle: "Setup smart bulbs, hubs and voice control",
    minPrice: 60,
    maxPrice: 130,
    image: "assets/images/smart_lighting.jpg",
  ),
  SmartHomeService(
    title: "Alexa / Google Home Setup",
    subtitle: "Setup smart assistants and routines",
    minPrice: 60,
    maxPrice: 140,
    image: "assets/images/smart_assistant.jpg",
  ),
  SmartHomeService(
    title: "WiFi Router Setup",
    subtitle: "Optimize home WiFi, router and network",
    minPrice: 80,
    maxPrice: 180,
    image: "assets/images/wifi_router.jpg",
  ),
  SmartHomeService(
    title: "Mesh WiFi Install",
    subtitle: "Install mesh systems (Eero, Google Nest Wifi)",
    minPrice: 100,
    maxPrice: 200,
    image: "assets/images/mesh_wifi.jpg",
  ),
  SmartHomeService(
    title: "Smart TV & Streaming Setup",
    subtitle: "Set up smart TV, apps and streaming devices",
    minPrice: 60,
    maxPrice: 140,
    image: "assets/images/smart_tv.jpg",
  ),
];
