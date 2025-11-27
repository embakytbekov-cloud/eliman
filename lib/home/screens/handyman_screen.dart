import 'package:flutter/material.dart';
import 'package:eliman/home/screens/handyman_details_screen.dart';

class HandymanScreen extends StatelessWidget {
  const HandymanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Handyman Services",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "24 services",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: handymanServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            return HandymanCard(item: handymanServices[index]);
          },
        ),
      ),
    );
  }
}

class HandymanCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const HandymanCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HandymanDetailsScreen(item: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  item["image"],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 6),

              /// BADGE
              if (item["badge"] != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF23A373).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item["badge"],
                    style: const TextStyle(
                      color: Color(0xFF23A373),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 6),

              /// TITLE
              Text(
                item["title"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 2),

              /// SUBTITLE
              Text(
                item["subtitle"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 6),

              /// PRICE + Arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item["price"],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF23A373),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> handymanServices = [
  {
    "badge": "Popular",
    "title": "TV Mounting",
    "subtitle": "Professional TV wall mounting",
    "price": "\$75 - \$150",
    "image": "assets/images/tv_mounting.jpg"
  },
  {
    "badge": "Popular",
    "title": "Light Fixture Install",
    "subtitle": "Replace or install new lights",
    "price": "\$60 - \$120",
    "image": "assets/images/handyman_light.jpg"
  },
  {
    "badge": "Popular",
    "title": "Ceiling Fan Install",
    "subtitle": "Install or replace ceiling fans",
    "price": "\$80 - \$180",
    "image": "assets/images/handyman_fan.jpg"
  },
  {
    "badge": "Popular",
    "title": "Faucet Repair",
    "subtitle": "Fix leaking faucets",
    "price": "\$70 - \$130",
    "image": "assets/images/handyman_faucet.jpg"
  },
  {
    "badge": "Popular",
    "title": "Drywall Repair",
    "subtitle": "Repair damaged drywall",
    "price": "\$90 - \$200",
    "image": "assets/images/handyman_drywall.jpg"
  },
  {
    "badge": "Popular",
    "title": "Furniture Assembly",
    "subtitle": "Assemble home furniture",
    "price": "\$60 - \$150",
    "image": "assets/images/furniture_assembly.jpg"
  },
  {
    "title": "Window/door Repair",
    "subtitle": "Fix windows anf door",
    "price": "\$80 - \$180",
    "image": "assets/images/window_repair.jpg"
  },
  {
    "title": "Small Painting",
    "subtitle": "Touch-up and small painting",
    "price": "\$60 - \$150",
    "image": "assets/images/small_painting.jpg"
  },
  {
    "title": "Baby Proofing",
    "subtitle": "Childproof your home",
    "price": "\$80 - \$150",
    "image": "assets/images/baby_proofing.jpg"
  },
  {
    "title": "Shelf Mounting",
    "subtitle": "Mount shelves securely",
    "price": "\$50 - \$100",
    "image": "assets/images/shelf_mounting.jpg"
  },
  {
    "title": "Furniture Disassembly ",
    "subtitle": "Take apart furniture for moving",
    "price": "\$60 - \$150",
    "image": "assets/images/furniture_disassembly.jpg"
  },
  {
    "title": "Outdoor Furniture ",
    "subtitle": "Assemble outdoor furniture",
    "price": "\$70 - \$150",
    "image": "assets/images/outdoor_furniture.jpg"
  },
  {
    "title": "Curtain Rod Install",
    "subtitle": "Install curtain rods and blinds",
    "price": "\$50 - \$100",
    "image": "assets/images/curtain_rod_install.jpg"
  },
  {
    "title": "Wall Patch Repair",
    "subtitle": "Repair wall damage",
    "price": "\$60 - \$120",
    "image": "assets/images/wall_patch_repair.jpg"
  },
  {
    "title": "Appliance Hookup",
    "subtitle": "Connect appliance safely",
    "price": "\$70 - \$130",
    "image": "assets/images/appliance_hookup.jpg"
  },
  {
    "title": "Minor Plumbing",
    "subtitle": "Small plumbing repairs",
    "price": "\$60 - \$150",
    "image": "assets/images/minor_plumbing.jpg"
  },
  {
    "title": "Cabinet Repair",
    "subtitle": "Fix cabinet doors and hingers",
    "price": "\$60 - \$120",
    "image": "assets/images/cabinet_repair.jpg"
  },
  {
    "title": "Window Blinds",
    "subtitle": "Install window blinds",
    "price": "\$50 - \$100",
    "image": "assets/images/window_blinds.jpg"
  },
  {
    "title": "Tile Caulking",
    "subtitle": "Recaulk tiles and tubs",
    "price": "\$50 - \$100",
    "image": "assets/images/tile_caulking.jpg"
  },
  {
    "title": "Door Handle Fix",
    "subtitle": "Repair or replace door handles",
    "price": "\$50 - \$100",
    "image": "assets/images/door_handle_fix.jpg"
  },
  {
    "title": "General Handyman",
    "subtitle": "Various home repair tasks",
    "price": "\$60 - \$150",
    "image": "assets/images/general_handyman.jpg"
  },
];
