import 'dart:io';
import 'package:first_project/database/db/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../home_screen/ScreenHome.dart';
import '../widget/text_form_field.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  List<String> item = ['Processing', 'Finished', 'Billed', 'Not required'];
  final _addDetailsFormkey = GlobalKey<FormState>();
  TextEditingController _date = TextEditingController();
  TextEditingController _deviceNameController = TextEditingController();
  TextEditingController _modelNameController = TextEditingController();
  TextEditingController _serviceRequiredController = TextEditingController();
  TextEditingController _deviceConditionController = TextEditingController();
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _PhoneNumberController = TextEditingController();
  TextEditingController _sequrityCodeController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String? chooseValue;
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios_new)),
          title: Text('Add Details'),
          centerTitle: true),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _addDetailsFormkey,
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        addImage();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          //<-- SEE HERE
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            image == null
                                ? Column(
                                    children: [
                                      Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 80,
                                        color: Colors.grey.shade400,
                                      ),
                                      Text('Choose Device photo',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 137, 135, 135)))
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          image == null
                                              ? Column(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .add_a_photo_outlined,
                                                      size: 80,
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                    Text(
                                                      'Choose Device photo',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 137, 135, 135),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Image.file(
                                                  image!,
                                                  width: 330,
                                                  height: 220,
                                                  fit: BoxFit.fill,
                                                ),
                                        ],
                                      ),
                                      if (image != null)
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                image = null;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (_customerNameController.text.trim().isEmpty) {
                          return 'Please fill the field';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Customer name',
                      icon: Icons.person_outline,
                      controllerr: _customerNameController),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)")
                                .hasMatch(value)) {
                          return 'Please add phone number';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Customer Mobile No',
                      icon: Icons.numbers_sharp,
                      controllerr: _PhoneNumberController,
                      keybordTypes: true),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty ||
                            _deviceNameController.text.trim().isEmpty) {
                          return 'Enter Device name';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Device',
                      icon: Icons.phone_android,
                      controllerr: _deviceNameController),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty ||
                            _modelNameController.text.trim().isEmpty) {
                          return 'Enter model name';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Model Name',
                      icon: Icons.mode_outlined,
                      controllerr: _modelNameController),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty ||
                            _serviceRequiredController.text.trim().isEmpty) {
                          return 'Please fill the field';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Service required',
                      icon: Icons.design_services_outlined,
                      controllerr: _serviceRequiredController),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty ||
                            _deviceConditionController.text.trim().isEmpty) {
                          return 'Please fill the field';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Device Condition',
                      icon: Icons.report_gmailerrorred_outlined,
                      controllerr: _deviceConditionController),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty ||
                            _sequrityCodeController.text.trim().isEmpty) {
                          return 'Please the field';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Sequrity Code',
                      icon: Icons.lock_open,
                      controllerr: _sequrityCodeController),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty ||
                            _amountController.text.trim().isEmpty) {
                          return 'Please the field';
                        } else {
                          return null;
                        }
                      },
                      hinttext: 'Enter Amount(Aprx)',
                      icon: Icons.attach_money_outlined,
                      controllerr: _amountController,
                      keybordTypes: true),
                  SizedBox(height: 10),
                  TextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty || _date.text.trim().isEmpty) {
                        return 'Please fill the field';
                      } else {
                        return null;
                      }
                    },
                    hinttext: 'Choose Delivery Date',
                    icon: Icons.edit,
                    controllerr: _date,
                    read: true,
                    sufix: true,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 0.9,
                    height: MediaQuery.sizeOf(context).height / 14,
                    child: ElevatedButton(
                      onPressed: () async {
                        textfieldvalidation();
                      },
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 41, 161, 110),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)),
                        side: BorderSide(width: 1, color: Colors.white),
                        minimumSize: Size(280, 50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addImage() async {
    final images = await ImagePicker().pickImage(source: ImageSource.camera);
    if (images == null) {
      return;
    }
    final imageFile = File(images.path);

    setState(() {
      this.image = imageFile;
    });
  }

  // image add error message

  errorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.red,
        content: Text('Add Profile Photo')));
  }

  //add details message

  successfullyAdded(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text('Sucessfully added')));
  }

  // Textfield vlidate and image validate

  textfieldvalidation() async {
    if (image == null || image!.path.isEmpty) {
      errorMessage(context);
      return;
    }
    if (_addDetailsFormkey.currentState!.validate()) {
      DateTime Date = DateTime.now();
      String currentDate = DateFormat('yyyy/MM/dd').format(Date);
      String deviceName = _deviceNameController.text;
      String modelName = _modelNameController.text;
      String serviceRequired = _serviceRequiredController.text;
      String deviceCondition = _deviceConditionController.text;
      String customerName = _customerNameController.text;
      String phoneNumber = _PhoneNumberController.text;
      String sequrityCode = _sequrityCodeController.text;
      String amount = _amountController.text;
      String deliveryDate = _date.text;
      final imagefile = File(image!.path.toString());
      String deviceimage = imagefile.path;
      String staus = 'Processing';
      int id = widget.userData[DatabaseHelper.usercoloumId];

      Map<String, dynamic> details = {
        'deviceName': deviceName,
        'modelName': modelName,
        'serviceRequired': serviceRequired,
        'deviceCondition': deviceCondition,
        'customerName': customerName,
        'phoneNumber': phoneNumber,
        'sequrityCode': sequrityCode,
        'amount': amount,
        'deliveryDate': deliveryDate,
        'deviceImage': deviceimage,
        'deviceStatus': staus,
        'userId': id,
        'date': currentDate
      };

      successfullyAdded(context);
      await DatabaseHelper.instance.insertDetailsRecord(details);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ScreenHome(loggeduser: widget.userData)));
    }
  }
}
