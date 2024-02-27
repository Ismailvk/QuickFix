import 'package:first_project/database/db/database.dart';
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
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              height: currentHeight / 5,
              width: currentWidth / 2.5,
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
