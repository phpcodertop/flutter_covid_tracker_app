import 'package:flutter/material.dart';

class HomeGridItem extends StatelessWidget {
  final String title;
  final int number;
  final Color foregroundColor;
  final Color backgroundColor;

  const HomeGridItem({
    super.key,
    required this.title,
    required this.number,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      width: width / 2,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '$number',
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
