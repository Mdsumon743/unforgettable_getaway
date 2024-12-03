import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://a.storyblok.com/f/191576/1200x800/a3640fdc4c/profile_picture_maker_before.webp',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                const Text(
                  "Leo Cole, 24 🇨🇦",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  "Toronto, Canada",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Icon(Icons.directions_walk, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  "5 Km Away from you",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "New",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Positioned(
          top: 10,
          right: 10,
          child: Icon(
            Icons.favorite_border,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
