import 'package:first_project/database/database.dart';
import 'package:first_project/screen/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RevenueWidget extends StatefulWidget {
  RevenueWidget({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<RevenueWidget> createState() => _RevenueWidgetState();
}

class _RevenueWidgetState extends State<RevenueWidget> {
  String? valuechoose;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final formKeys = GlobalKey<FormState>();

  final List<String> listvalue = [
    'Today',
    'Last Month',
    'Custom Range',
  ];
  bool isvisible = false;
  String? revenues;
  String? profits;
  Text hintText = Text('Today');
  String? currentDate;
  String? startDate;
  Map<String, int>? profitAndrevenuelist;
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    todayRevenueAndProfit();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: isvisible == true ? 800 : 600,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                height: 55,
                child: DropdownButton<String>(
                  //Drop down widget .......
                  underline: SizedBox(),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: hintText,
                  ),
                  isExpanded: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FaIcon(FontAwesomeIcons.codeCompare),
                  ),
                  value: valuechoose,
                  items: listvalue.map((String newvalue) {
                    return DropdownMenuItem<String>(
                      value: newvalue,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(newvalue),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newvalue) async {
                    // today date
                    currentDate = DateFormat('yyyy/MM/dd').format(today);
                    DateTime startDayofMonth =
                        DateTime(today.year, today.month, 1);
                    startDate =
                        DateFormat('yyyy/MM/dd').format(startDayofMonth);
                    if (newvalue == 'Last Month') {
                      // print('reached');
                      thisMonth();
                    }
                    if (newvalue == 'Today') {
                      todayRevenueAndProfit();
                    }
                    if (newvalue == 'Custom Range') {
                      customDate();
                    }
                    setState(() {
                      valuechoose = newvalue;
                      if (valuechoose == 'Custom Range') {
                        isvisible = true;
                      } else {
                        isvisible = false;
                      }
                    });
                  },
                  //close Drop down
                ),
              ),
            ),
            Visibility(
                visible: isvisible,
                child: Form(
                  key: formKeys,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        validator: (value) {
                          if (value == null ||
                              startDateController.text.trim().isEmpty) {
                            return 'Please select your starting date';
                          } else {
                            return null;
                          }
                        },
                        hinttext: 'Start Date',
                        controllerr: startDateController,
                        sufix: true,
                        read: true,
                      ),
                      SizedBox(height: 10),
                      TextFormFieldWidget(
                          read: true,
                          sufix: true,
                          validator: (value) {
                            if (value == null ||
                                endDateController.text.trim().isEmpty) {
                              return 'Please select your date';
                            } else {
                              return null;
                            }
                          },
                          hinttext: 'End Date',
                          controllerr: endDateController),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 41, 161, 110),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: Size(120, 40)),
                        onPressed: () async {
                          if (formKeys.currentState!.validate()) {
                            customDate();
                          }
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                )),
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 195, 231, 216),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/background_image.jpg'),
                              fit: BoxFit.cover)),
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * .2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Revenue',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '₹ $revenues',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width / 6),
                            Container(
                                color: Colors.white, width: 8, height: 80),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width / 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Profit',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '₹ $profits',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Get today revenue and profit

  todayRevenueAndProfit() async {
    profitAndrevenuelist = await DatabaseHelper.instance
        .getRevenueAndProfitForToday(widget.userData['id'], DateTime.now());
    setState(() {
      if (profitAndrevenuelist != null && profitAndrevenuelist!.isNotEmpty) {
        profits = profitAndrevenuelist!['profitAmount'].toString();
        revenues = profitAndrevenuelist!['revenueAmount'].toString();
      }
    });
  }
  // Get this month revenue and profit

  thisMonth() async {
    print(currentDate);
    profitAndrevenuelist = await DatabaseHelper.instance.getRevenueAndProfit(
        userId: widget.userData['id'],
        currentDate: currentDate,
        startDate: startDate);
    setState(() {
      profits = profitAndrevenuelist!['profitAmount'].toString();
      revenues = profitAndrevenuelist!['revenueAmount'].toString();
      print('Profit $profits');
      print('Revenue $revenues');
    });
  }

  customDate() async {
    String startDate = startDateController.text.toString();
    String endDate = endDateController.text.toString();
    profitAndrevenuelist = await DatabaseHelper.instance
        .getCustomRevenueAndProfit(
            userId: widget.userData['id'],
            currentDate: startDate,
            startDate: endDate);
    setState(() {
      if (profitAndrevenuelist != null && profitAndrevenuelist!.isNotEmpty) {
        profits = profitAndrevenuelist!['profitAmount'].toString();
        revenues = profitAndrevenuelist!['revenueAmount'].toString();
        print('Profit c $profits');
        print('Revenue c$revenues');
      }
    });
  }
}