import 'package:first_project/screen/revenue/revenue.dart';
import 'package:first_project/screen/revenue/stock.dart';
import 'package:flutter/material.dart';

class ScreenRevenue extends StatefulWidget {
  ScreenRevenue({super.key, required this.loggeduser});
  final Map<String, dynamic> loggeduser;
  @override
  State<ScreenRevenue> createState() => _ScreenRevenueState();
}

class _ScreenRevenueState extends State<ScreenRevenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        elevation: 0.0,
        title: Text('Revenue & Stock'),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [CustomTabBar(userData: widget.loggeduser)],
      ),
    );
  }
}

// custom topbar //

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key, required this.userData});
  final Map<String, dynamic> userData;
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  List pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      RevenueWidget(userData: widget.userData),
      ScreenStock(logeduser: widget.userData)
    ];
  }

  List<String> items = [
    'Revenue',
    'Stock',
  ];
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    width: 180, // Adjust the width as per your preference
                    decoration: BoxDecoration(
                      color: current == index
                          ? Color.fromARGB(255, 41, 161, 110)
                          : Color.fromARGB(255, 186, 183, 183),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          items[index],
                          style: TextStyle(
                              color: current == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: pages[current],
          )
        ],
      ),
    );
  }
}
