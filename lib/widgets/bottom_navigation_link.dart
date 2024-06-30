import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/datasource.dart';

class BottomNavigationLink extends StatelessWidget {
  final String title;
  final Function()? action;

  const BottomNavigationLink({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10),
        color: deepColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),

            const Icon(Icons.arrow_forward, size: 30, color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
