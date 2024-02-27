import 'package:first_project/database/db/database.dart';
import 'package:first_project/screen/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import '../home_screen/ScreenHome.dart';
import '../widget/text_form_field.dart';

class ScreenSignup extends StatelessWidget {
  const ScreenSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final _signupKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              Container(
                height: size.height / 2.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(160)),
                  color: Color.fromARGB(255, 41, 161, 110),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width / 9, top: size.height / 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: size.width / 7.2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text('Creat your account',
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width / 17))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Form(
                  key: _signupKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                          validator: (value) {
                            if (value!.isEmpty ||
                                usernameController.text.trim().isEmpty ||
                                RegExp(r'^[a-zA-Z0-9]$').hasMatch(value)) {
                              return 'Enter Correct Name';
                            } else {
                              return null;
                            }
                          },
                          hinttext: 'Username',
                          icon: Icons.person,
                          controllerr: usernameController),
                      TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                    .hasMatch(value)) {
                              return 'Enter Valid Email';
                            } else if (DatabaseHelper.instance
                                .isemailavailable()) {
                              return 'Email already taken';
                            } else {
                              return null;
                            }
                          },
                          hinttext: 'Email',
                          icon: Icons.email_outlined,
                          controllerr: emailController),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: size.height / 10,
                            maxHeight: size.height / 10),
                        child: TextFormFieldWidget(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                                      .hasMatch(value)) {
                                return 'Enter Correct Password';
                              } else {
                                return null;
                              }
                            },
                            hinttext: 'Password',
                            icon: Icons.key,
                            controllerr: passwordController),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Register'),
                onPressed: () async {
                  await DatabaseHelper.instance
                      .isemailAvailableValidating(emailController.text.trim());
                  if (_signupKey.currentState!.validate()) {
                    String name = usernameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;
                    // ignore: unused_local_variable
                    int? islogin;

                    // Create a map containing the user data
                    Map<String, dynamic> userData = {
                      'name': name,
                      'email': email,
                      'password': password,
                      'islogin': islogin = 1,
                    };

                    // Insert the user data into the database
                    await DatabaseHelper.instance.insertUserRecord(userData);
                    final Map<String, dynamic>? user =
                        await DatabaseHelper.instance.getuserlogged();

                    // circular loader
                    showDialog(
                        context: context,
                        builder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ));
                    await Future.delayed(Duration(seconds: 2));
                    // Navigate to the home screen or perform any other desired action
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => ScreenHome(loggeduser: user!)),
                    );
                    // Retrieve all records from the database
                    List<Map<String, dynamic>> dbRecords =
                        await DatabaseHelper.instance.getAllUsers();

                    // Print the username and email from the database
                    for (var record in dbRecords) {
                      print('Name: ${record[DatabaseHelper.coloumName]}');
                      print('Email: ${record[DatabaseHelper.coloumEmail]}');
                      print('Username: ${record[DatabaseHelper.coloumName]}');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 41, 161, 110),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  side: BorderSide(width: 1, color: Colors.white),
                  minimumSize: Size(size.width / 1.6, size.height / 14),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account ? '),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ScreenSignIn()));
                      },
                      child:
                          Text('Login', style: TextStyle(color: Colors.orange)))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
