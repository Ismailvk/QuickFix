import 'package:first_project/database/database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// ignore: must_be_immutable
class page1 extends StatefulWidget {
  page1(
      {super.key,
      required this.loggeduser,
      required this.profitAndRevenueNotifier});
  final Map<String, dynamic> loggeduser;
  ValueNotifier<Map> profitAndRevenueNotifier;

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  Map<String, int>? profitAndrevenuelist;

  callrevenueAndProfit() async {
    final profitAndRevenue = await DatabaseHelper.instance
        .getRevenueAndProfitForToday(widget.loggeduser['id'], DateTime.now());
    widget.profitAndRevenueNotifier.value = profitAndRevenue;

    widget.profitAndRevenueNotifier.notifyListeners();
  }

  @override
  void initState() {
    super.initState();
    callrevenueAndProfit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ValueListenableBuilder(
            valueListenable: widget.profitAndRevenueNotifier,
            builder: (context, value, child) => Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.99,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: 4, color: Colors.deepPurple.shade200),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Today Revenue ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 3),
                                  Image.asset(
                                    'assets/images/money_blue.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 7),
                                    child: Text(
                                      '${value['revenueAmount']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.37,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: 4, color: Colors.red.shade200),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Today Profit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 3),
                                  Image.asset(
                                    'assets/images/money_red.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 7),
                                    child: Text(
                                      '${value['profitAmount']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 170,
                      width: 120,
                      // color: Colors.amber,
                      child: CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 15,
                        animation: true,
                        animationDuration: 1000,
                        progressColor: Color.fromARGB(255, 41, 161, 110),
                        percent: calculateProfitPercentage(
                            value['profitAmount'], value['revenueAmount']),
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.green.shade100,
                        center: Text(
                          '${(calculateProfitPercentage(value['profitAmount'], value['revenueAmount']) * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double calculateProfitPercentage(valueOne, valueTwo) {
    if (valueOne != null && valueTwo != null) {
      int profitAmount = valueOne;
      int revenueAmount = valueTwo;
      if (revenueAmount != 0) {
        return profitAmount / revenueAmount;
      }
    }
    return 0.0;
  }
}
