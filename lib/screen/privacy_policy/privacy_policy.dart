import 'package:flutter/material.dart';

class ScreenPrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Quick Fix App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Effective Date: August 18, 2023',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome to Mobile Care! This Privacy Policy outlines our practices regarding the collection, use, and disclosure of personal and non-personal information when you use our mobile application.',
            ),
            SizedBox(height: 8.0),
            Text(
              '2. Information We Collect',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'We may collect various types of information, including:',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '- Personal Information: We may collect information such as your name, email address, and contact details.'),
                  Text(
                      '- Usage Information: We may collect information about how you interact with our app, including actions you take and features you use.'),
                  Text(
                      '- Financial Information: We may collect revenue and profit data to provide you with insights into your business.'),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '3. How We Use Your Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'We use the collected information for various purposes, including:',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Providing and improving our services.'),
                  Text('- Analyzing app usage to enhance user experience.'),
                  Text('- Offering insights into revenue and profit.'),
                  Text('- Sending promotional and informational content.'),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '4. Data Sharing and Disclosure',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'We may share your information with:',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '- Third-party service providers to help us operate and improve our services.'),
                  Text('- Legal authorities when required by law.'),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '5. Security',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'We take reasonable measures to protect your information, but no data transmission or storage system can be guaranteed to be 100% secure.',
            ),
            SizedBox(height: 8.0),
            Text(
              '6. Contact Us',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at ismailkbassi00@gmail.com',
            ),
          ],
        ),
      ),
    );
  }
}
