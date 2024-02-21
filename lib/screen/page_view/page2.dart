import 'package:first_project/database/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class page2 extends StatelessWidget {
  final Map<String, dynamic> loggeduser;

  const page2({super.key, required this.loggeduser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FutureBuilder(
              future: DatabaseHelper.instance.getAllDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error${snapshot.error}');
                } else if (snapshot.data!.isEmpty || snapshot.data == null) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.99,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/back1.png'),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You haven't Customer",
                            style: GoogleFonts.acme(
                                textStyle: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  final data = snapshot.data!.length;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.98,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage('assets/images/back1.png'),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'You Got',
                              style: GoogleFonts.acme(
                                  textStyle: TextStyle(fontSize: 18)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '$data',
                                style: GoogleFonts.acme(
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            data == 1 || data == 0
                                ? Text(
                                    'Customer',
                                    style: GoogleFonts.acme(
                                        textStyle: TextStyle(fontSize: 18)),
                                  )
                                : Text(
                                    'Customers',
                                    style: GoogleFonts.acme(
                                        textStyle: TextStyle(fontSize: 18)),
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
