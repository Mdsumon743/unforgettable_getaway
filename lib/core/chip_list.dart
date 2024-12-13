import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipList extends StatelessWidget {
  const ChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          // _buildChip('Women', 'https://via.placeholder.com/20'),
          // _buildChip('Men', 'https://via.placeholder.com/20'),
          // _buildChip('Kids', 'https://via.placeholder.com/20'),
          // _buildChip('Accessories', 'https://via.placeholder.com/20'),
        ],
      ),
    );
  }
}

// Widget buildChip(
//   String label,
// ) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: Chip(
//       backgroundColor: const Color(0xff261d1c),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.r)),
//       label: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // const Icon(Icons.movie),
//           // CircleAvatar(
//           //   backgroundImage: NetworkImage(imageUrl),
//           // ),
//           // ClipOval(
//           //   child: Image.network(
//           //     imageUrl,
//           //     width: 24,
//           //     height: 24,
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           // const SizedBox(width: 8.0),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w400),
//           ),
//         ],
//       ),
//     ),
//   );
// }
  Widget buildChip(
  String label,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Chip(
      backgroundColor: const Color(0xff261d1c),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.r)),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Icon(Icons.movie),
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
          // const SizedBox(width: 8.0),
          Text(
            label,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
  );
}

