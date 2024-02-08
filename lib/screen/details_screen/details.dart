// ignore_for_file: must_be_immutable
import 'package:first_project/database/database.dart';
import 'package:first_project/screen/details_screen/show_picture.dart';
import 'package:first_project/screen/home_screen/ScreenHome.dart';
import 'package:first_project/screen/widget/choicechips_widget.dart';
import 'package:first_project/screen/widget/device_details_card_widget.dart';
import 'package:first_project/screen/widget/heading_container_widget.dart';
import 'package:first_project/screen/widget/pdf_call_widget.dart';
import 'package:first_project/screen/widget/show_alert_dialogue.dart';
import 'package:first_project/screen/widget/small_text_field.dart';
import 'package:first_project/screen/widget/text_form_field.dart';
import 'package:first_project/screen/widget/text_widget.dart';
import 'package:first_project/screen/widget/total_card_widget.dart';
import 'package:first_project/screen/widget/validation.dart';
import 'package:flutter/material.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails(
      {super.key,
      required this.userdata,
      required this.customerData,
      required this.valueNotifier});

  final Map<String, dynamic> userdata;
  final Map<String, dynamic> customerData;
  final ValueNotifier valueNotifier;

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  final amountkey = GlobalKey<FormState>();

  TextEditingController spareChargeController = TextEditingController();
  TextEditingController serviceChargeController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  late var total;
  String? comment;
  int? service;
  int? spare;
  int? oldSpare;
  @override
  void initState() {
    super.initState();
    spare = widget.customerData[DatabaseHelper.coloumSpareAmount] ?? 0;
    service = widget.customerData[DatabaseHelper.coloumServiceAmount] ?? 0;
    total = (service ?? 0) + (spare ?? 0);
    comment = widget.customerData[DatabaseHelper.coloumComment];
    oldSpare = widget.customerData[DatabaseHelper.coloumSpareAmount] ?? 0;

    spareChargeController.text = spare == null ? '' : spare.toString();
    serviceChargeController.text = service == null ? '' : service.toString();
    commentController.text = comment ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await DatabaseHelper.instance
            .getStatus(widget.customerData[DatabaseHelper.coloumuserId]);

        if (value == 'Billed') {
          showAlertDialogfor(context);
          return true;
        } else {
          Navigator.of(context).pop();
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFECECEC),
        appBar: AppBar(
          title: Text('Details'),
          leading: InkWell(
            onTap: () async {
              // Get the current value of the drop-down
              final value = await DatabaseHelper.instance
                  .getStatus(widget.customerData[DatabaseHelper.coloumuserId]);

              if (value == 'Billed') {
                showAlertDialogfor(context);
              } else {
                Navigator.pop(context, true);
              }
              setState(() {});
            },
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: ListView(children: [
          Container(
            child: Column(
              children: [
                Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Set up methods',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10),
                        PdfAndCallWidget(
                          phoneNumber: widget
                              .customerData[DatabaseHelper.coloumPhoneNumber],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DeviceDetailsCardWidget(
                  aprxAmount: widget.customerData[DatabaseHelper.coloumAmount],
                  condition:
                      widget.customerData[DatabaseHelper.coloumDeviceCondition],
                  customerData: widget.customerData,
                  date: widget.customerData[DatabaseHelper.coloumDeliveryDate],
                  device: widget.customerData[DatabaseHelper.coloumDeviceName],
                  mobileNumber:
                      widget.customerData[DatabaseHelper.coloumPhoneNumber],
                  model: widget.customerData[DatabaseHelper.coloumModelName],
                  name: widget.customerData[DatabaseHelper.coloumCustomerName],
                  screenLock:
                      widget.customerData[DatabaseHelper.coloumSequrityCode],
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.86,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          HeadingContainerWidget(
                              serviceRequired: widget.customerData[
                                  DatabaseHelper.coloumServiceRequired]),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TotalCardWidget(totalAmount: total),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => ScreenShowPicture(
                                          userdata: widget.userdata,
                                          imagepath: widget.customerData[
                                              DatabaseHelper.coloumDeviceImage],
                                        ),
                                      ),
                                    );
                                  },
                                  // deatails page's gridview image . like stack
                                  child: ShowStackImage(
                                      image: widget.customerData[
                                          DatabaseHelper.coloumDeviceImage])),
                              // Photo card endedd   //
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 15),
                            child: TextWidget(text1st: 'Spare used'),
                          ),

                          ChoiceChipsWidget(inputDetails: widget.customerData),
                          //   choice chips   Endedd  //
                          Form(
                            key: amountkey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SmallTextFormFieldWidget(
                                          keybordTypes: true,
                                          labelname: 'Spare amount',
                                          validator: (value) =>
                                              Validation.amountValidation(
                                                  value!),
                                          hinttext: 'Enter spare charge',
                                          controllerr: spareChargeController),
                                      SmallTextFormFieldWidget(
                                          keybordTypes: true,
                                          labelname: 'Service amount',
                                          validator: (value) =>
                                              Validation.amountValidation(
                                                  value!),
                                          hinttext: 'Add your service amount',
                                          controllerr: serviceChargeController),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  TextFormFieldWidget(
                                      validator: (value) =>
                                          Validation.isEmpty(value!),
                                      hinttext: 'Comment',
                                      controllerr: commentController),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 41, 161, 110),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        minimumSize: Size(120, 40)),
                                    onPressed: () async {
                                      addYourAmountButton(
                                          commentController.text);
                                    },
                                    child: Text('Add your data'),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  addYourAmountButton(String commentData) async {
    if (amountkey.currentState!.validate()) {
      // Convert the amount values to double
      int? spareAmount = int.parse(spareChargeController.text);
      int? serviceAmount = int.parse(serviceChargeController.text);

      // Store the values in the database
      await DatabaseHelper.instance.updateSpareAmount(
          widget.customerData[DatabaseHelper.detailscoloumId], spareAmount);
      // update service amount in database
      await DatabaseHelper.instance.updateServiceAmount(
          widget.customerData[DatabaseHelper.detailscoloumId], serviceAmount);
      // get stock amount in database
      final stockData = await DatabaseHelper.instance
          .getStockAmount(widget.userdata[DatabaseHelper.usercoloumId]);
      final updatedData = stockData - spareAmount;
      // update and decrease stock amount in database (when user add his spare amount)
      await DatabaseHelper.instance.decreseStockAmount(
          id: widget.userdata[DatabaseHelper.usercoloumId],
          updatedStockamount: updatedData);

      int revenue = spareAmount + serviceAmount;

      await DatabaseHelper.instance.updateRevenueamount(
          widget.customerData[DatabaseHelper.detailscoloumId], revenue);
      int profit = serviceAmount;
      await DatabaseHelper.instance.updateprofit(
          widget.customerData[DatabaseHelper.detailscoloumId], profit);
      await DatabaseHelper.instance.updateComment(
          widget.customerData[DatabaseHelper.detailscoloumId], commentData);
      widget.valueNotifier.value = {
        'profitAmount': profit,
        'revenueAmount': revenue,
      };

      widget.valueNotifier.notifyListeners();
      final user = await DatabaseHelper.instance.getuserlogged();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ScreenHome(loggeduser: user!)));
    }
  }
}
