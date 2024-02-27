import 'package:first_project/database/db/database.dart';
import 'package:flutter/material.dart';
import '../home_screen/ScreenHome.dart';
import '../sign_up/sign_up.dart';
import '../widget/text_form_field.dart';

// ignore: must_be_immutable
class ScreenSignIn extends StatelessWidget {
  ScreenSignIn({super.key});

  final _loginformkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Form(
            key: _loginformkey,
            child: Column(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(160)),
                    color: Color.fromARGB(255, 41, 161, 110),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text('Sign into your account',
                            style: TextStyle(color: Colors.white, fontSize: 20))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormFieldWidget(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                              .hasMatch(value)) {
                        return 'Enter Valid Email';
                      } else {
                        return null;
                      }
                    },
                    controllerr: _emailController,
                    hinttext: 'Email',
                    icon: Icons.email_outlined),
                SizedBox(height: 20),
                TextFormFieldWidget(
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
                  controllerr: _passwordController,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    loginValidation(context);
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 41, 161, 110),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(width: 1, color: Colors.white),
                    minimumSize: Size(280, 50),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ? "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ScreenSignup()));
                      },
                      child: Text(
                        'Sign up ?',
                        style: TextStyle(color: Colors.orange),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  loginValidation(context) async {
    if (_loginformkey.currentState!.validate()) {
      String enteredEmail = _emailController.text;
      String enteredPassword = _passwordController.text;

      // Retrieve the user record from the database based on the entered email
      List<Map<String, dynamic>> dbRecords =
          await DatabaseHelper.instance.getAllUsers();
      Map<String, dynamic> userRecord = dbRecords.firstWhere(
          (record) => record[DatabaseHelper.coloumEmail] == enteredEmail,
          orElse: () => {});

      if (userRecord.isNotEmpty) {
        // User found in the database
        String storedPassword = userRecord[DatabaseHelper.coloumPassword];

        if (enteredPassword == storedPassword) {
          // Password matches, navigate to home screen

          await DatabaseHelper.instance.userupdate(
              data: enteredEmail,
              columnFiled: DatabaseHelper.coloumEmail,
              updatevalue: 1);
          final Map<String, dynamic>? user =
              await DatabaseHelper.instance.getuserlogged();
          showDialog(
              context: context,
              builder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ScreenHome(loggeduser: user!),
            ),
          );
        } else {
          // Incorrect password
          incorrectPassword(context);
        }
      } else {
        // User not found
        userNotFound(context);
      }
    }
  }

  // incorrect password
  incorrectPassword(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Password'),
        content: Text('The entered password is incorrect.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // user not found
  userNotFound(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('User Not Found'),
        content: Text('No user found with the entered email.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
