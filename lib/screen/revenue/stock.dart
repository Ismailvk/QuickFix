import 'package:first_project/database/db/database.dart';
import 'package:first_project/screen/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScreenStock extends StatefulWidget {
  ScreenStock({Key? key, required this.logeduser}) : super(key: key);

  final Map<String, dynamic> logeduser;

  @override
  State<ScreenStock> createState() => _ScreenStockState();
}

class _ScreenStockState extends State<ScreenStock> {
  final stockKey = GlobalKey<FormState>();

  TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: DatabaseHelper.instance
          .getStockAmount(widget.logeduser[DatabaseHelper.usercoloumId]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text('Error: ${snapshot.error}');
        } else {
          var newStock = snapshot.data;
          print('$newStock is new stock');

          return Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 200, 249, 241),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/background_image.jpg'),
                            fit: BoxFit.cover)),
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * .2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Stock',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        height: 200,
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 50),
                                            Form(
                                              key: stockKey,
                                              child: Container(
                                                  width: 350,
                                                  height: 51,
                                                  child: TextFormFieldWidget(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          !RegExp(r'^\d+$')
                                                              .hasMatch(
                                                                  value) ||
                                                          stockController.text
                                                              .trim()
                                                              .isEmpty) {
                                                        print(value);
                                                        return 'Add your stock amount';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    hinttext:
                                                        'Add your stock amount',
                                                    icon: Icons.money,
                                                    controllerr:
                                                        stockController,
                                                    keybordTypes: true,
                                                  )),
                                            ),
                                            SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                updateButtonPressed();
                                              },
                                              child: Text('Update',
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 41, 161, 110),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors.white),
                                                minimumSize: Size(200, 50),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.add,
                                    size: 35, color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text('₹ ',
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)),
                              Text(
                                '${newStock ?? 0}',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        }
      },
    ).animate().scaleX();
  }

  updateButtonPressed() async {
    if (stockKey.currentState!.validate()) {
      final tempStock = stockController.text;
      int Stock = int.parse(tempStock);

      final amount = await DatabaseHelper.instance
          .getStockAmount(widget.logeduser[DatabaseHelper.usercoloumId]);

      int newStock = amount + Stock;
      await DatabaseHelper.instance.stockupdate(
          id: widget.logeduser[DatabaseHelper.usercoloumId],
          controllerValue: newStock);
    }
    stockController.text = '';
    setState(() {});
  }
}
