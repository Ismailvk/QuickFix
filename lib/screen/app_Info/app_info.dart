import 'package:flutter/material.dart';

class ScreenAppinfo extends StatelessWidget {
  const ScreenAppinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('App Info'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'About the app',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                      "Description: Quick Fix is a mobile shop service app that provides a convenient platform for users to seek assistance and information regarding their damaged or malfunctioning devices. Whether it's a cracked screen, battery issues, or software problems, our app aims to connect users with professional technicians who can diagnose and repair their devices efficiently"),
                  SizedBox(height: 8),
                  Text('Key Features:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                      '1- Device Diagnosis: With Quick Fix, users can input details about their damaged device, including the brand, model, and specific issues they are experiencing. The app uses this information to provide an initial diagnosis and recommend potential solutions.'),
                  Text(
                      "2- Repair Service Search: Quick Fix offers a comprehensive database of authorized service centers and independent technicians in the user's area. Users can search for nearby repair shops, compare prices, read reviews, and select a suitable service provider."),
                  Text(
                      "3- Service Request and Booking: Users can request repair services directly through the app. Once they have chosen a service provider, they can book an appointment, specify their device's issues, and provide any additional information the technician may need for a smooth repair process."),
                  Text(
                      '4-In-App Communication: Quick Fix facilitates seamless communication between users and service providers. Users can exchange messages, ask questions, and receive updates on the progress of their device repair, ensuring transparency and convenience.'),
                  Text(
                      '5- Device Tracking: The app allows users to track the status of their device repair in real-time. They can receive notifications about repair milestones, estimated completion times, and when their device is ready for pickup.'),
                  Text(
                      "6- Repair History and Documentation: [App Name] maintains a comprehensive repair history for each user, including past service requests, repairs performed, and associated costs. This feature enables users to keep track of their device's maintenance and repair records for future reference."),
                  Text(
                      '7- Knowledge Base and Troubleshooting: The app offers a knowledge base section with helpful articles and troubleshooting guides for common device issues. Users can access step-by-step instructions, tips, and suggestions to address minor problems themselves before seeking professional assistance.'),
                  Text(
                      '8- Secure Payment Options: [App Name] supports secure and convenient payment options. Users can pay for repair services directly through the app, ensuring a hassle-free and secure transaction process.'),
                  Text(
                      '9- User Registration: Guide users through the process of creating an account within the app. Explain the benefits of registration, such as personalized recommendations, saved repair history, and easy access to customer support.'),
                  Text(
                      '10- Profile Creation: Instruct users to create a profile within the app, including their contact information, preferred communication methods, and device preferences. This information can help technicians provide more accurate assistance.'),
                  Text(
                      '11- Uploading Photos or Videos: Encourage users to upload clear photos or videos of their damaged devices. Explain how this visual documentation can assist technicians in diagnosing the issue and preparing for repairs'),
                  Text(
                      '12- Warranty and Insurance Information: Remind users to check if their device is still under warranty or covered by insurance. Provide instructions on how to gather relevant documentation, such as proof of purchase or warranty certificates.'),
                  Text(
                      "13- Repair Cost Estimates: Inform users that they can request cost estimates for the repair services they require. Explain how technicians will assess the device's condition and provide an approximate cost before proceeding with the repair."),
                  Text(
                      '14- Feedback and Ratings: Encourage users to provide feedback and rate their experience with the service provider after their device repair is completed. Explain how their input can help improve the quality of service and assist other users in selecting reliable technicians.'),
                  Text(
                      "15- Data Privacy and Security: Assure users that their personal information and device data will be handled with utmost care and adhere to privacy regulations. Explain the app's data protection measures and provide links to the app's privacy policy for transparency."),
                  Text(
                      '16- Customer Support: Clearly outline how users can reach out to customer support for any questions, concerns, or technical difficulties they may encounter while using the app. Include contact information such as email addresses, phone numbers, or in-app chat support.'),
                  SizedBox(height: 5),
                  Text(
                      '     Quick Fix strives to simplify the process of finding reliable repair services for damaged mobile devices. With a user-friendly interface, seamless communication, and extensive repair resources, our app aims to enhance user satisfaction and provide a one-stop solution for all device-related concerns.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
