import 'package:flutter/material.dart';

class TotalCardWidget extends StatelessWidget {
  final int totalAmount;
  const TotalCardWidget({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Color(0xFFE0F0E9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14,
              ),
              Icon(
                Icons.folder_open_sharp,
                size: 45,
              ),
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Text(
                totalAmount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xFFBC6C25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
