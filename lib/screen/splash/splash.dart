import 'package:first_project/database/database.dart';
import 'package:first_project/screen/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

import '../home_screen/ScreenHome.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    loginornot();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 161, 110),
      body: Container(
        width: currentWidth,
        height: currentHeight,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage('assets/images/communication.png'),
                    height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mobile ',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    Text(
                      'Care',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginornot() async {
    final user = await DatabaseHelper.instance.getuserlogged();
    if (user == null) {
      movetologin();
    } else {
      await Future.delayed(Duration(milliseconds: 2));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => ScreenHome(
            loggeduser: user,
          ),
        ),
      );
    }
  }

  Future<void> movetologin() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => ScreenSignIn(),
      ),
    );
  }
}
