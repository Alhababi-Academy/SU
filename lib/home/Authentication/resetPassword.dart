import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';
import 'package:su_project/home/Authentication/login.dart';
import 'package:su_project/widgets/customTextFieldRegsiterPage.dart';
import 'package:su_project/widgets/errorDialog.dart';
import 'package:su_project/widgets/loadingDialog.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  // Empty email variable
  TextEditingController Email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // The whole screen widget
    return Scaffold(
      // app bar
      appBar: AppBar(),
      // White background color
      backgroundColor: Colors.white,
      // All the widgets will be in the safe area
      body: SafeArea(
        // This will center the widgets
        child: Center(
          // The widgets will be scrollable
          child: SingleChildScrollView(
            // In the Column, we can put multiple widgets
            child: Column(
              // Center the column vertically
              mainAxisAlignment: MainAxisAlignment.center,
              // Center the column horizontally
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Putting the image in a box that has a width of 180
                SizedBox(
                  width: 180,
                  // The image widget
                  child: Image.asset("images/logo.jpg"),
                ),
                // A container that will provide margin and padding around its child
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text widget for "Email"
                      Text(
                        "Email",
                        style: TextStyle(
                          color: SU.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Custom text field for email input
                      customTextFieldRegsiterPage(
                        // it will be hidden, falst
                        isSecure: false,
                        // wecan edit, true
                        enabledEdit: true,
                        // icon
                        prefixIcon: Icon(
                          Icons.email,
                          color: SU.primaryColor,
                        ),
                        // we are storing here the email that the user write
                        textEditingController: Email,
                        textInputType: TextInputType.emailAddress,
                        hint: "example@gmail.com",
                      ),
                      // Sized Box Widget
                    ],
                  ),
                ),
                Column(
                  children: [
                    // Elevated button for login
                    ElevatedButton(
                      style: ButtonStyle(
                        // the color of the button
                        backgroundColor: MaterialStateProperty.all(
                          SU.primaryColor,
                        ),
// the shape of the button
                      ),
                      onPressed: () {
                        // the Function when you click the button
                        validateData();
                      },
                      // putting space in the button
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        // the text inside the button
                        child: Text(
                          'Rest',
                          //. the style for the text inside the button
                          style: TextStyle(
                            // the size of the text inside the button
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // space
                    const SizedBox(
                      height: 20,
                    ),
                    // Row for "Forget Password?" text and a clickable text
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateData() async {
    // Check if both email and password fields are not empty
    if (Email.text.isNotEmpty) {
      // If not empty, call the `uploadToStorage` function
      uploadToStorage();
    } else {
      // If empty, display an error dialog
      displayDialog();
    }
  }

// this if the email or passwrod is empty
  displayDialog() {
    // showing the pop screen
    showDialog(
      context: context,
      // it will take the avialble space
      barrierDismissible: false,
      builder: (c) {
        // this is the error
        return const ErrorDialogCustom(
          message: "Fill up the form",
        );
      },
    );
  }

// functoin to show dialog
  uploadToStorage() async {
    // showing the pop screen
    showDialog(
      context: context,
      builder: (c) {
        // loaidn dialog
        return const LoadingDialogCustom(
          // the message inside the dialog
          message: "Checking Data Please Wait...",
        );
      },
    );
    // the next Functoin
    resetPassowrdFucntion();
  }

  void resetPassowrdFucntion() async {
    // we are siging the user using this firebase functoin
    SU.firebaseAuth!
        .sendPasswordResetEmail(
      // we put email here
      email: Email.text.trim(),
    )
        // if everyting is good
        .then((auth) {
      // go to the home page screen
      Route route = MaterialPageRoute(
        builder: (_) => const loginPage(),
      );
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      // if there is error
    }).catchError(
      (error) {
        // Authentication failed
        Navigator.pop(context);
        // show the error
        showDialog(
          context: context,
          builder: (c) => ErrorDialogCustom(
            message: error.toString(),
          ),
        );
      },
    );
  }
}
