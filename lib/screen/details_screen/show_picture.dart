import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenShowPicture extends StatelessWidget {
  ScreenShowPicture({super.key, this.imagepath, required this.userdata});
  String? imagepath;
  final Map<String, dynamic> userdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Image'),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(child: Image(image: FileImage(File(imagepath!)))),
      ),
    );
  }
}

// ignore: must_be_immutable
class ShowStackImage extends StatelessWidget {
  ShowStackImage({super.key, required this.image});

  String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(
                File(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 30,
          child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText(
                'Tap to show,',
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              RotateAnimatedText(
                'Tap to show,',
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
