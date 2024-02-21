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
                  child: Icon(
                    Icons.picture_as_pdf,
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
