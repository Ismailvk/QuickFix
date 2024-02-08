import 'dart:io';
import 'package:first_project/database/database.dart';
import 'package:first_project/screen/home_screen/ScreenHome.dart';
import 'package:first_project/screen/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class DrawerEdit extends StatefulWidget {
  Map<String, dynamic> logeduser;
  final Function(Map<String, dynamic>) updateNavBar; // Callback function

  DrawerEdit({Key? key, required this.logeduser, required this.updateNavBar})
      : super(key: key);

  @override
  _DrawerEditState createState() => _DrawerEditState();
}

class _DrawerEditState extends State<DrawerEdit> {
  late TextEditingController userdrawername;
  late TextEditingController emaildrawer;
  File? image;

  @override
  void initState() {
    super.initState();
    userdrawername = TextEditingController(text: widget.logeduser['name']);
    emaildrawer = TextEditingController(text: widget.logeduser['email']);

    final imagePath = widget.logeduser[DatabaseHelper.coloumImage];
    image = imagePath != null ? File(imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 55),
            Stack(
              children: [
                CircleAvatar(
                  radius: 47,
                  backgroundColor: Color(0xFF29A16E),
                  child: CircleAvatar(
                    // Use either AssetImage or FileImage based on the image type
                    backgroundImage: image == null
                        ? AssetImage('assets/images/user.png')
                        : FileImage(image!) as ImageProvider<Object>,
                    radius: 45,
                  ),
                ),
                Positioned(
                  bottom: -6,
                  right: -25,
                  child: RawMaterialButton(
                    onPressed: () {
                      photoSelectPopup(context);
                    },
                    elevation: 2.0,
                    fillColor: Color(0xFFF5F6F9),
                    child: Icon(Icons.camera_alt_outlined, color: Colors.blue),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFormFieldWidget(
              labelname: 'Username',
              validator: (value) {
                if (value!.isEmpty || userdrawername.text.trim().isEmpty) {
                  return 'Enter Correct Name';
                } else {
                  return null;
                }
              },
              hinttext: 'Enter new username',
              icon: Icons.person_outline,
              controllerr: userdrawername,
            ),
            SizedBox(height: 10),
            TextFormFieldWidget(
              labelname: 'Email',
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                        .hasMatch(value)) {
                  return 'Enter Valid Email';
                } else if (DatabaseHelper.instance.isemailavailable()) {
                  return 'Email already taken';
                } else {
                  return null;
                }
              },
              hinttext: 'Enter new email',
              icon: Icons.email_outlined,
              controllerr: emaildrawer,
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 14,
              child: ElevatedButton(
                onPressed: () {
                  updateButton();
                },
                child: Text('Update', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF29A16E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  side: BorderSide(width: 1, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateButton() async {
    Map<String, dynamic> updateUserData = Map.from(widget.logeduser);

    updateUserData[DatabaseHelper.coloumName] = userdrawername.text;
    updateUserData[DatabaseHelper.coloumEmail] = emaildrawer.text;
    updateUserData[DatabaseHelper.coloumImage] = image!.path;

    await DatabaseHelper.instance.updateUserdetails(
        updateUserData, widget.logeduser[DatabaseHelper.usercoloumId]);

    setState(() {
      widget.logeduser = updateUserData;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (ctx) => ScreenHome(loggeduser: updateUserData)),
        (route) => false);
  }

  photoSelectPopup(context) {
    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text('Update'),
        content: Text('Do you want to update your photo?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () async {
                var pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() {
                    image = File(pickedImage.path);
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Ok'))
        ],
      ),
    );
  }
}
