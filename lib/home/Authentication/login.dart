import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';
import 'package:su_project/home/Authentication/register.dart';
import 'package:su_project/home/Authentication/resetPassword.dart';
import 'package:su_project/home/userHome.dart';
import 'package:su_project/widgets/customTextFieldRegsiterPage.dart';
import 'package:su_project/widgets/errorDialog.dart';
import 'package:su_project/widgets/loadingDialog.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  // Empty email variable
  TextEditingController EmailTextEditingController = TextEditingController();
  // Empty password varialbe
  TextEditingController PasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // The whole screen widget
    return Scaffold(
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
                      const Text(
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
                        prefixIcon: const Icon(
                          Icons.email,
                          color: SU.primaryColor,
                        ),
                        // we are storing here the email that the user write
                        textEditingController: EmailTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        hint: "zee@gmail.com",
                      ),
                      // Sized Box Widget
                      const SizedBox(
                        height: 10,
                      ),
                      // Text widget for "Password"
                      const Text(
                        "Password",
                        style: TextStyle(
                          color: SU.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Custom text field for password input
                      customTextFieldRegsiterPage(
                        // is it hidden, yes
                        isSecure: true,
                        // enable edit, true
                        enabledEdit: true,
                        // we storing here the passwrod that the user write
                        textEditingController: PasswordEditingController,
                        // keybaord style
                        textInputType: TextInputType.visiblePassword,
                        hint: "123456789*",

                        // icon
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: SU.primaryColor,
                        ),
                      ),

                      // space
                      const SizedBox(
                        height: 10,
                      ),
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
                    // space
                    const SizedBox(
                      height: 20,
                    ),
                    // Row for "Forget Password?" text and a clickable text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // text
                        const Text(" Forget Password ? "),
                        // this widget will make the text clicable
                        GestureDetector(
                          onTap: () {
                            // this is to tell what page to go to
                            Route route = MaterialPageRoute(
                                builder: (_) => const ResetPassword());
                            // this to ask the user to go to
                            Navigator.push(context, route);
                          },
                          // text widget
                          child: const Text(
                            "Click Here",
                            // the style of the text
                            style: TextStyle(
                              // the color of the widget
                              color: SU.primaryColor,
                              // the line under the text
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // the space
                    const SizedBox(
                      height: 10,
                    ),
                    // Row for "No Account?" text and a clickable text
                    Row(
                      // it will take the minumee space
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // the text widget
                        const Text(
                          "No Account? ",
                          style: TextStyle(),
                        ),
                        // the text can be clicked
                        GestureDetector(
                          // here come a Function
                          onTap: () {
                            // this will allow me to go to another page, the register page
                            Route route = MaterialPageRoute(
                                builder: (_) => const ReigsterPage());
                            Navigator.push(context, route);
                          },
                          // text widget
                          child: const Text(
                            "Create Now",
                            // style
                            style: TextStyle(
                              // color
                              color: SU.primaryColor,
                              // line under it
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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
    if (EmailTextEditingController.text.isNotEmpty &&
        PasswordEditingController.text.isNotEmpty) {
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
    singinig();
  }
  // we are siging the user using this firebase functoin

  singinig() async {
    // Verify the phone number with Firebase Authentication
    SU.firebaseAuth!
        .signInWithEmailAndPassword(
      // we put email here
      email: EmailTextEditingController.text.trim(),
      // we put passwrod here
      password: PasswordEditingController.text.trim(),
    )
        // if everyting is good
        .then((auth) {
      // go to the home page screen
      Route route = MaterialPageRoute(builder: (_) => const HomePage());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
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

  // getData(String currentUser) async {
  //   await SU.firebaseFirestore
  //       ?.collection("users")
  //       .doc(currentUser)
  //       .get()
  //       .then((data) async {
  //     String fullName = data.get('fullName');
  //     String email = data.get('email');
  //     await SU.sharedPreferences?.setString("fullName", fullName);
  //     await SU.sharedPreferences?.setString("email", email);
  //   }).then((value) {
  //     Route route =
  //         MaterialPageRoute(builder: (_) => BottomNavigationBarCustom());
  //     Navigator.push(context, route);
  //   });
  // }
}
