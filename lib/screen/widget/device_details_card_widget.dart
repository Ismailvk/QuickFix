import 'package:first_project/screen/widget/dropdown_widget.dart';
import 'package:first_project/screen/widget/text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceDetailsCardWidget extends StatelessWidget {
  final String name;
  Map<String, dynamic> customerData;
  final String device;
  final String condition;
  final String mobileNumber;
  final String screenLock;
  final String model;
  final String date;
  final String aprxAmount;
  DeviceDetailsCardWidget({
    super.key,
    required this.name,
    required this.customerData,
    required this.device,
    required this.condition,
    required this.mobileNumber,
    required this.screenLock,
    required this.model,
    required this.date,
    required this.aprxAmount,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 5, right: 5, top: size.height / 25),
                    child: Text(
                      'Name: $name',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(width: size.width / 8),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 5, right: 5, top: size.height / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropButtonWidget(userdata: customerData),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: size.height / 4.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text1st: 'Device:'),
                        TextWidget(text1st: device),
                        SizedBox(height: 10),
                        TextWidget(text1st: 'Condition:'),
                        TextWidget(text1st: condition),
                        SizedBox(height: 10),
                        TextWidget(text1st: 'Mob.No:'),
                        Text(
                          mobileNumber,
                          style: TextStyle(color: Color(0xFFBC6C25)),
                        ),
                        SizedBox(height: 10),
                        TextWidget(text1st: 'Security code :'),
                        Text(screenLock)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width / 8),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: size.height / 4.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height / 22),
                        TextWidget(text1st: 'Model:'),
                        TextWidget(text1st: model),
                        SizedBox(height: 10),
                        TextWidget(text1st: 'Delivery Date:'),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              size: 20,
                            ),
                            Text(date),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextWidget(text1st: 'Aprx amount :'),
                        Text(aprxAmount)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
