import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipList extends StatelessWidget {
  const ChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildChip('Women', 'https://via.placeholder.com/20'),
          _buildChip('Men', 'https://via.placeholder.com/20'),
          _buildChip('Kids', 'https://via.placeholder.com/20'),
          _buildChip('Accessories', 'https://via.placeholder.com/20'),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.r)),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.movie),
            // CircleAvatar(
            //   backgroundImage: NetworkImage(imageUrl),
            // ),
            // ClipOval(
            //   child: Image.network(
            //     imageUrl,
            //     width: 24,
            //     height: 24,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(width: 8.0),
            Text(label),
          ],
        ),
      ),
    );
  }
}
