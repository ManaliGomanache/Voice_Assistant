import 'package:flutter/material.dart';
import 'pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String description;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 35,
      ),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                    color: Pallete.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cera-Pro'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              description,
              style: const TextStyle(
                  color: Pallete.blackColor,
                  fontSize: 16,
                  fontFamily: 'Cera-Pro'),
            )
          ],
        ),
      ),
    );
  }
}
