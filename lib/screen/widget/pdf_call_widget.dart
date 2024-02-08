import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PdfAndCallWidget extends StatelessWidget {
  final String phoneNumber;
  PdfAndCallWidget({super.key, required this.phoneNumber});

  TextEditingController spareController = TextEditingController();

  final sparekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 60,
          width: 60,
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 27,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.picture_as_pdf),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(8),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.info,
                                          color: Colors.red, size: 19),
                                      Text(
                                        'Use (,) between items',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Form(
                                  key: sparekey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (spareController.text.isEmpty) {
                                        return 'Add the spare names';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: spareController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter used spare name',
                                      border: OutlineInputBorder(),
                                    ),
                                    minLines: 6,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    //
                                  },
                                  child: Text(
                                    'Generate Pdf',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 41, 161, 110),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    side: BorderSide(
                                        width: 1, color: Colors.white),
                                    minimumSize: Size(200, 50),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -2,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 60,
          width: 60,
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 27,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () {
                        final String number = phoneNumber;

                        final Uri phoneUri = Uri(scheme: 'tel', path: number);
                        launchUrl(phoneUri);
                      }),
                ),
                Positioned(
                  bottom: 0,
                  right: -2,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
