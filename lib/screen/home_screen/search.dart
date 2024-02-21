import 'package:first_project/database/database.dart';
import 'package:first_project/screen/details_screen/details.dart';
import 'package:first_project/screen/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ScrreenSearch extends StatefulWidget {
  final Map<String, dynamic> loggeduser;
  ValueNotifier<Map> profitAndRevenueNotifier = ValueNotifier({});
  ScrreenSearch(
      {Key? key,
      required this.loggeduser,
      required this.profitAndRevenueNotifier});

  @override
  State<ScrreenSearch> createState() => _ScrreenSearchState();
}

class _ScrreenSearchState extends State<ScrreenSearch> {
  List<Map<String, dynamic>> filterList = [];
  List<Map<String, dynamic>> allList = [];
  bool isFoundResult = false;

  @override
  void initState() {
    super.initState();
    getSearchResult(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Search',
          style: GoogleFonts.acme(
              textStyle: TextStyle(fontSize: 20, color: Colors.black)),
        ),
        backgroundColor: Color.fromARGB(255, 229, 228, 228),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 0.7, // Spread radius
              blurRadius: 40, // Blur radius
              offset: Offset(0, 4), // Offset in the y-axis
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  getSearchResult(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search here',
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              isFoundResult == true
                  ? Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filterList.length,
                        itemBuilder: (context, index) {
                          final data = filterList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ScreenDetails(
                                      userdata: widget.loggeduser,
                                      customerData: data,
                                      valueNotifier:
                                          widget.profitAndRevenueNotifier)));
                            },
                            child: CardWidget(
                              name: data[DatabaseHelper.coloumCustomerName],
                              image: data[DatabaseHelper.coloumDeviceImage],
                              device: data[DatabaseHelper.coloumDeviceName],
                              date: data[DatabaseHelper.coloumDate],
                              userdata: widget.loggeduser,
                              customerData: filterList[index],
                            ),
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 180),
                      child: Center(
                        child: Text(
                          'No Data Found',
                          style: GoogleFonts.acme(),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  getSearchResult(String? searchWord) async {
    if (searchWord == null) {
      allList = await DatabaseHelper.instance
          .getinputdetails(widget.loggeduser[DatabaseHelper.usercoloumId]);
      print('errorcode  $allList');
      setState(() {});
      print(filterList);
    } else if (searchWord.isNotEmpty) {
      filterList = allList
          .where((details) => details['customerName']
              .toString()
              .toLowerCase()
              .contains(searchWord.toString().toLowerCase()))
          .toList();
      print('Hai filter search $filterList');
      if (filterList.isEmpty) {
        isFoundResult = false;
      } else {
        isFoundResult = true;
      }
      setState(() {});
    } else {
      setState(() {});
      isFoundResult = false;
    }
  }
}
