import 'package:first_project/database/db/database.dart';
import 'package:flutter/material.dart';

class DropButtonWidget extends StatefulWidget {
  const DropButtonWidget({Key? key, required this.userdata}) : super(key: key);
  final Map<String, dynamic> userdata;

  @override
  _DropButtonWidgetState createState() => _DropButtonWidgetState();
}

class _DropButtonWidgetState extends State<DropButtonWidget> {
  String? valueChoose;
  List<String> listItem = ["Processing", "Finished", "Billed", "Not Repaired"];
  String? status;

  late Color buttonColor = Color(0xFFBCD333); // Default button color

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.instance.getinputStatusDetaills(
          widget.userdata[DatabaseHelper.detailscoloumId]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          // If there is an error retrieving the stock amount, show an error message
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>>? data = snapshot.data;
          if (data != null && data.isNotEmpty) {
            status = data[0][DatabaseHelper.coloumStatus];

            if (status == 'Processing') {
              buttonColor = const Color(0xFFBCD333);
            } else if (status == 'Finished') {
              buttonColor = Color(0xFF3373D3);
            } else if (status == 'Not Repaired') {
              buttonColor = Color(0xFFCE1E1E);
            } else if (status == 'Billed') {
              buttonColor = Color(0xFF29A135);
            }
          }

          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.04,
              maxWidth: MediaQuery.of(context).size.width * 0.4,
            ),
            decoration: BoxDecoration(
              color:
                  buttonColor, // Set the background color based on buttonColor
              border: Border.all(color: buttonColor), // Set the border color
              borderRadius: BorderRadius.circular(4), // Set the border radius
            ),
            child: DropdownButton<String>(
              focusColor: buttonColor,
              dropdownColor: Color.fromARGB(255, 41, 161,
                  110), // Set the dropdown menu color based on buttonColor
              hint: Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Text(
                  status!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              value: valueChoose,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: (String? newValue) async {
                await DatabaseHelper.instance.updateSelectedValue(
                    widget.userdata[DatabaseHelper.detailscoloumId], newValue!);

                setState(() {
                  valueChoose = newValue;

                  // Update button color based on selected value
                  if (newValue == 'Processing') {
                    buttonColor = const Color(0xFFBCD333);
                  } else if (newValue == 'Finished') {
                    buttonColor = Color(0xFF3373D3);
                  } else if (newValue == 'Not Repaired') {
                    buttonColor = Color(0xFFCE1E1E);
                  } else if (newValue == 'Billed') {
                    buttonColor = Color(0xFF29A135);
                  }
                });
              },

              underline: Container(), // Remove the underline
              items: listItem.map((String valueItem) {
                return DropdownMenuItem<String>(
                  value: valueItem,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(valueItem),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
