import 'dart:io';
import 'package:first_project/database/db/database.dart';
import 'package:first_project/screen/home_screen/drawer_edit.dart';
import 'package:first_project/screen/privacy_policy/privacy_policy.dart';
import 'package:first_project/screen/revenue/tab_bar.dart';
import 'package:first_project/screen/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import '../app_Info/app_info.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.logeduser});
  final Map<String, dynamic> logeduser;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late TextEditingController userdrawername;
  late TextEditingController emaildrawer;
  File? image;
  @override
  void initState() {
    super.initState();
    userdrawername = TextEditingController(
        text: widget.logeduser[DatabaseHelper.coloumName]);
    emaildrawer = TextEditingController(
        text: widget.logeduser[DatabaseHelper.coloumEmail]);

    // Initialize image variable based on logeduser's image path
    final imagePath = widget.logeduser[DatabaseHelper.coloumImage];
    image = imagePath != null ? File(imagePath) : null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Listen for updated data when the DrawerEdit page is popped
    Map<String, dynamic>? updatedData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (updatedData != null) {
      setState(() {
        userdrawername.text = updatedData['name'];
        emaildrawer.text = updatedData['email'];
        image = updatedData['image'];
      });
    }
  }

  void updateNavBar(Map<String, dynamic> updatedUserData) {
    setState(() {
      userdrawername.text = updatedUserData[DatabaseHelper.coloumName];
      emaildrawer.text = updatedUserData[DatabaseHelper.coloumEmail];
      String? imagePath = updatedUserData[DatabaseHelper.coloumImage];
      image = imagePath != null ? File(imagePath) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Card(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        CircleAvatar(
                          radius: 42,
                          child: CircleAvatar(
                            // Use either AssetImage or FileImage based on the image type
                            backgroundImage: image == null
                                ? AssetImage('assets/images/user.png')
                                : FileImage(image!) as ImageProvider<Object>,
                            radius: 40,
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(height: 5),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                widget.logeduser[DatabaseHelper.coloumName],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.logeduser[DatabaseHelper.coloumEmail],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.black),
            title: Text('App info'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ScreenAppinfo()));
            },
          ),
          ListTile(
            leading: Icon(Icons.edit, color: Colors.black),
            title: Text('Edit Profile'),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ));
              await Future.delayed(Duration(seconds: 2));
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => DrawerEdit(
                      updateNavBar: updateNavBar, // Pass the callback function
                      logeduser: widget.logeduser)));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.black),
            title: Text('Privacy & policy'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenPrivacyPolicy()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_home_work_outlined, color: Colors.black),
            title: Text('Revenue & Stock'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ScreenRevenue(
                        loggeduser: widget.logeduser,
                      )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Color.fromARGB(255, 41, 161, 110),
            ),
            title: Text(
              'Log Out',
              style: TextStyle(color: Color.fromARGB(255, 41, 161, 110)),
            ),
            onTap: () {
              logoutPopup(context);
            },
          ),
        ],
      ),
    );
  }

  // Logout pop up
  logoutPopup(context) {
    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text('Logout '),
        content: Text('Do you want logout ?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () {
                confirmLogout(context);
              },
              child: Text('Ok'))
        ],
      ),
    );
  }

  // confirm log out
  confirmLogout(context) {
    DatabaseHelper.instance.userupdate(
        data: widget.logeduser[DatabaseHelper.usercoloumId],
        columnFiled: DatabaseHelper.usercoloumId,
        updatevalue: 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => ScreenSignIn()), (route) => false);
  }
}
