import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon iconName;
  final double height;
  final double wight;
  final Image image;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.height,
    required this.wight,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white54,
        child: image,
      ),
      title: Text(
        title,
        style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style:const TextStyle(color: Colors.white60),
          ),
          Text(
            "42 minute ago",
            style:const TextStyle(color: Colors.white60),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         iconName,
        ],
      ),
    );
  }
}