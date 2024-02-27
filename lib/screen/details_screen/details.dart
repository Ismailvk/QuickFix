import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:first_project/database/db/database.dart';
import 'package:first_project/screen/details_screen/show_picture.dart';
import 'package:first_project/screen/home_screen/ScreenHome.dart';
import 'package:first_project/screen/pdf_screen/pdf_screen.dart';
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
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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

  late int total;
  String? comment;
  int? service;
  int? spare;
  int? oldSpare;
  String? pdfPath;

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

  Future<void> createPdf(String today, [String? items]) async {
    final ByteData image = await rootBundle.load('assets/images/logo.png');
    List<String?> itemList = [];
    if (items != null) {
      if (items.contains('0')) {
        itemList.add('Display');
      }
      if (items.contains('1')) {
        itemList.add('Battery');
      }
      if (items.contains('2')) {
        itemList.add('Touch');
      }
      if (items.contains('3')) {
        itemList.add('Board');
      }
      if (items.contains('4')) {
        itemList.add('Speaker');
      }
      if (items.contains('5')) {
        itemList.add('Additional Spare');
      }
    }
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(0),
          build: (pw.Context context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Image(
                        fit: pw.BoxFit.cover,
                        pw.MemoryImage(
                          image.buffer.asUint8List(),
                        ),
                        width: 60,
                        height: 70,
                      ),
                      pw.SizedBox(width: 20),
                      pw.Column(
                        children: [
                          pw.Text('Quick Fix',
                              style: const pw.TextStyle(fontSize: 24)),
                          pw.Text('+91 9876543210',
                              style: const pw.TextStyle(fontSize: 12))
                        ],
                      ),
                    ],
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 15),
                    child: pw.Container(
                        child: pw.Text('Date: $today'),
                        alignment: pw.Alignment.bottomRight),
                  ),

                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 15),
                    child: pw.Divider(thickness: 1),
                  ),
                  pw.SizedBox(height: 30),
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Container(
                      width: 200,
                      // ignore: deprecated_member_use
                      child: pw.Table.fromTextArray(
                        context: context,
                        border: null,
                        headerAlignment: pw.Alignment.centerLeft,
                        headerStyle:
                            pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        headerDecoration: const pw.BoxDecoration(
                            color: PdfColor.fromInt(0xFFE0E0E0)),
                        data: <List<String>>[
                          <String>['Items'],
                          ...itemList.map((item) => [item ?? 'No item found']),
                        ],
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  // ignore: deprecated_member_use
                  pw.Table.fromTextArray(
                    context: context,
                    border: null,
                    headerAlignment: pw.Alignment.centerLeft,
                    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    headerDecoration: const pw.BoxDecoration(
                        color: PdfColor.fromInt(0xFFE0E0E0)),
                    data: <List<String>>[
                      <String>['Charges', 'Total'],
                      <String>[
                        'Spare Charge   ',
                        '${spareChargeController.text}'
                      ],
                      <String>[
                        'Customer Charge',
                        '${serviceChargeController.text}'
                      ],
                    ],
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                    child: pw.Divider(thickness: 1),
                  ),
                  pw.Row(
                    children: [
                      pw.SizedBox(width: 11 * PdfPageFormat.cm),
                      pw.Text('Grand Total:'),
                      pw.SizedBox(width: 15),
                      pw.Text((total).toString())
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );

      final output = await getExternalStorageDirectory();
      if (output == null) {
        throw const FileSystemException(
            "Unable to get external storage directory");
      }

      final file = File('${output.path}/Quickfix.pdf');
      await file.writeAsBytes(await pdf.save());

      setState(() {
        pdfPath = file.path;
      });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PdfViewerPage(pdfPath!)),
        );
      }
    } catch (e) {
      debugPrint('Error creating PDF: $e');
    }
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
                        GestureDetector(
                          onTap: () async {
                            final tempSelectedCount = await DatabaseHelper
                                .instance
                                .getColumnChoiceChipsValue(widget.customerData[
                                    DatabaseHelper.detailscoloumId]);
                            DateTime date = DateTime.now();
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            tempSelectedCount != null
                                ? createPdf(formattedDate, tempSelectedCount)
                                : createPdf(formattedDate);
                          },
                          child: PdfAndCallWidget(
                            phoneNumber: widget
                                .customerData[DatabaseHelper.coloumPhoneNumber],
                          ),
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
      int? spareAmount = int.parse(spareChargeController.text);
      int? serviceAmount = int.parse(serviceChargeController.text);
      int updatedStockAmount = 0;
      int updatedServiceAmount = serviceAmount;
      int updatedSpareAmount = spareAmount;
      //get spare amount
      final spare = await DatabaseHelper.instance
          .getSpareAmount(widget.customerData[DatabaseHelper.detailscoloumId]);
      // get service amount
      final service = await DatabaseHelper.instance.getServiceAmount(
          widget.customerData[DatabaseHelper.detailscoloumId]);
      //get stock amount
      final stockData = await DatabaseHelper.instance
          .getStockAmount(widget.userdata[DatabaseHelper.usercoloumId]);

      if (spareAmount != spare && spareAmount != 0) {
        int checkedSpareamount = (spare - spareAmount).abs();
        updatedStockAmount = checkedSpareamount;
        updatedSpareAmount = checkedSpareamount;
        //updation code
        await DatabaseHelper.instance.updateSpareAmount(
            widget.customerData[DatabaseHelper.detailscoloumId],
            checkedSpareamount);
      }
      if (serviceAmount != service && serviceAmount != 0) {
        int checkedServiceamount = (service - serviceAmount).abs();
        updatedServiceAmount = checkedServiceamount;
        //updation code
        await DatabaseHelper.instance.updateServiceAmount(
            widget.customerData[DatabaseHelper.detailscoloumId],
            checkedServiceamount);
      }
      if (spare == 0 && spare != spareAmount) {
        updatedStockAmount = spareAmount;
        // spare add code
        await DatabaseHelper.instance.updateSpareAmount(
            widget.customerData[DatabaseHelper.detailscoloumId], spareAmount);
      }
      if (service == 0 && service != serviceAmount) {
        // service add code
        await DatabaseHelper.instance.updateServiceAmount(
            widget.customerData[DatabaseHelper.detailscoloumId], serviceAmount);
      }
      //update comment
      await DatabaseHelper.instance.updateComment(
          widget.customerData[DatabaseHelper.detailscoloumId], commentData);
      final updatedData = stockData - updatedStockAmount;
      // update and decrease stock amount in database (when user add his spare amount)
      await DatabaseHelper.instance.decreseStockAmount(
          id: widget.userdata[DatabaseHelper.usercoloumId],
          updatedStockamount: updatedData);

      int revenue = updatedSpareAmount + updatedServiceAmount;

      await DatabaseHelper.instance.updateRevenueamount(
          widget.customerData[DatabaseHelper.detailscoloumId], revenue);
      int profit = updatedServiceAmount;
      await DatabaseHelper.instance.updateprofit(
          widget.customerData[DatabaseHelper.detailscoloumId], profit);

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
