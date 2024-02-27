import 'dart:io';
import 'package:first_project/database/db/database.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String name;
  final String? image;
  final String device;
  final String date;
  final Map<String, dynamic> userdata;
  final Map<String, dynamic> customerData;

  CardWidget(
      {super.key,
      required this.name,
      required this.image,
      required this.device,
      required this.date,
      required this.userdata,
      required this.customerData});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.file(
                  File(widget.image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name: ${widget.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          '${widget.customerData[DatabaseHelper.coloumStatus]}',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('Device: ${widget.device}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.calendar_month),
                      Text(widget.date),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
