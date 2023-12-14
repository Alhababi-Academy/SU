import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart'; // Import the Flutter material library.

class LoadingDialogCustom extends StatelessWidget {
  final String
      message; // Store the loading message to be displayed in the dialog.
  const LoadingDialogCustom({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        title: Text(
          message, // Display the loading message received as a parameter.
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: SU.primaryColor,
              fontSize: 20), // Set text style.
          textAlign: TextAlign.center, // Center-align the text.
        ),
        content: const Center(
          child: CircularProgressIndicator(
            color: SU.primaryColor,
          ),
        ) // Display a Lottie animation from an asset.
        );
  }
}
