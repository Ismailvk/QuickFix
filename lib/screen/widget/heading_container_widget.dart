import 'package:flutter/material.dart';

class HeadingContainerWidget extends StatelessWidget {
  final String serviceRequired;
  const HeadingContainerWidget({super.key, required this.serviceRequired});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Text(
          serviceRequired,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 41, 161, 110),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }
}
