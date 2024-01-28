import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as DateFormatting;
import 'package:su_project/config/config.dart';
import 'package:su_project/home/Authentication/login.dart';
import 'package:su_project/widgets/customTextFieldRegsiterPage.dart';
import 'package:su_project/widgets/errorDialog.dart';
import 'package:su_project/widgets/loadingDialog.dart';

class ReigsterPage extends StatefulWidget {
  const ReigsterPage({super.key});

  @override
  State<ReigsterPage> createState() => _ReigsterPage();
}

class _ReigsterPage extends State<ReigsterPage> {
  // email empty variable
  TextEditingController emailTextEditingController = TextEditingController();
  // password empty variable
  TextEditingController passworTextEditingController = TextEditingController();
  // full name empty variable
  TextEditingController fullName = TextEditingController();
  // address empty variable
  TextEditingController address = TextEditingController();

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
              children: [
                // Putting the image in a box that has a width of 180
                SizedBox(
                  width: 200,
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
                      // put space between the sides
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
                        textEditingController: emailTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        hint: "example@gmail.com",
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
                        textEditingController: passworTextEditingController,
                        // keybaord style
                        textInputType: TextInputType.visiblePassword,
                        hint: "123456789*",
                        onChanged: (value) {
                          setState(() {
                            value;
                          });
                        },
                        // icon
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: SU.primaryColor,
                        ),
                      ),

                      // space

                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Full Name",
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
                          Icons.person,
                          color: SU.primaryColor,
                        ),
                        // we are storing here the email that the user write
                        textEditingController: fullName,
                        textInputType: TextInputType.emailAddress,
                        hint: "mohamemd ",
                      ),
                      // Sized Box Widget
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Address",
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
                          Icons.location_city,
                          color: SU.primaryColor,
                        ),
                        // we are storing here the email that the user write
                        textEditingController: address,
                        textInputType: TextInputType.emailAddress,
                        hint: "Abha",
                      ),
                      // Sized Box Widget
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
                          'Register',
                          //. the style for the text inside the button
                          style: TextStyle(
                            color: Colors.white,
                            // the size of the text inside the button
                            fontSize: 18,
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

                    // Row for "No Account?" text and a clickable text
                    Row(
                      // it will take the minumee space
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // the text widget
                        const Text(
                          "You have account? ",
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
                            "Login",
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
    if (emailTextEditingController.text.isNotEmpty &&
        passworTextEditingController.text.isNotEmpty &&
        fullName.text.isNotEmpty &&
        address.text.isNotEmpty) {
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
    register();
  }

  void register() async {
    // we are siging the user using this firebase functoin
    SU.firebaseAuth!
        .createUserWithEmailAndPassword(
      // we put email here
      email: emailTextEditingController.text.trim(),
      // we put passwrod here
      password: passworTextEditingController.text.trim(),
    )
        // if everyting is good
        .then((auth) {
      // this will store the user ID
      String currentUser = auth.user!.uid;
      // This will go to function to save the data
      saveUserInfoToFireStor(currentUser);
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

  // this function to store data in the Cloud Firebase
  saveUserInfoToFireStor(currentUser) async {
    // the start of creating users collection in the database
    await SU.firestore!
        .collection("users")
        // saving the ID there
        .doc(currentUser.toString())
        .set(
      {
        // ID
        "uid": currentUser.toString(),
        // string user full name,
        "fullName": fullName.text.trim(),
        // stroing the email storing
        "email": emailTextEditingController.text.trim().toLowerCase(),
        // storing the address
        "address": address.text.trim(),
        // storing the date of registering
        "registedOn": DateFormatting.DateFormat('dd-mm-yyyy')
            .format(DateTime.now())
            .toString(),
      },
      // everything is good
    ).then((value) {
      // remove loading dialog
      Navigator.pop(context);
      // it will go to the login page
      Route route = MaterialPageRoute(builder: (_) => const loginPage());
      Navigator.pushReplacement(context, route);
    });
  }
}
