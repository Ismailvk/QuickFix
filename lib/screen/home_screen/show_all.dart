import 'package:first_project/database/database.dart';
import 'package:first_project/screen/details_screen/details.dart';
import 'package:first_project/screen/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ScreenShowAll extends StatefulWidget {
  ScreenShowAll(
      {super.key,
      required this.userdata,
      required this.profitAndRevenueNotifier});

  final Map<String, dynamic> userdata;
  ValueNotifier<Map> profitAndRevenueNotifier;

  @override
  State<ScreenShowAll> createState() => _ScreenShowAllState();
}

class _ScreenShowAllState extends State<ScreenShowAll> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance
          .getinputdetails(widget.userdata[DatabaseHelper.usercoloumId]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        } else {
          // final data = snapshot.data; // Store the snapshot data in a variable
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Container(
                height: 250,
                width: 200,
                child: Column(
                  children: [
                    Lottie.asset('assets/images/phone.json'),
                    Text('No data found')
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return InkWell(
                onTap: () async {
                  final refresh =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ScreenDetails(
                                valueNotifier: widget.profitAndRevenueNotifier,
                                userdata: widget.userdata,
                                customerData: item,
                              )));
                  if (refresh == true) {
                    setState(() {});
                  }
                },
                child: CardWidget(
                  image: item[DatabaseHelper.coloumDeviceImage],
                  name: item[DatabaseHelper.coloumCustomerName],
                  device: item[DatabaseHelper.coloumDeviceName],
                  date: item[DatabaseHelper.coloumDeliveryDate],
                  userdata: widget.userdata,
                  customerData: item,
                ),
              );
            },
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
          );
        }
      },
    );
  }
}
