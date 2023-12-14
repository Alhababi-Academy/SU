import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';

class ErrorDialogCustom extends StatelessWidget {
  final String?
      message; // Store the error message to be displayed in the dialog.
  const ErrorDialogCustom({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable:
          true, // Allow scrolling within the dialog if the content overflows.
      title: Column(
        children: [
          Text(
            message
                .toString(), // Display the error message received as a parameter.
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: SU.primaryColor,
              fontSize: 20,
            ), // Set text style.
            textAlign: TextAlign.center, // Center-align the text.
          ),
        ],
      ),
      content: ElevatedButton(
        style: ButtonStyle(
          // the color of the button
          backgroundColor: MaterialStateProperty.all(
            SU.primaryColor,
          ),
          // the shape of the button
        ),
        onPressed: () {
          // the Function when you click the button
          Navigator.pop(context);
        },
        // putting space in the button
        child: const Padding(
          padding: EdgeInsets.all(10.0),

          // the text inside the button
          child: Text(
            'Next',
            //. the style for the text inside the button
            style: TextStyle(
              // the size of the text inside the button
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
