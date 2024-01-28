import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as DateFormatting;
import 'package:su_project/config/config.dart';
import 'package:su_project/widgets/customTextFieldRegsiterPage.dart';
import 'package:su_project/widgets/errorDialog.dart';
import 'package:su_project/widgets/loadingDialog.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPost();
}

class _UploadPost extends State<UploadPost> {
  // Title empty variable
  TextEditingController _PostTitle = TextEditingController();
  // Dsecription empty variable
  TextEditingController _PostDescription = TextEditingController();

  String selectedType = 'Post';
  @override
  Widget build(BuildContext context) {
    // The whole screen widget
    return Scaffold(
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
              children: [
                // Putting the image in a box that has a width of 180
                const Text(
                  "Post & Note",
                  style: TextStyle(
                    color: SU.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
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
                        "Title",
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
                          Icons.post_add,
                          color: SU.primaryColor,
                        ),
                        // we are storing here the email that the user write
                        textEditingController: _PostTitle,
                        textInputType: TextInputType.text,
                        hint: "School Campus",
                      ),
                      // Sized Box Widget
                      const SizedBox(
                        height: 10,
                      ),
                      // Text widget for "Password"
                      const Text(
                        "Description",
                        style: TextStyle(
                          color: SU.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Custom text field for password input
                      customTextFieldRegsiterPage(
                        // is it hidden, yes
                        isSecure: false,
                        // enable edit, true
                        enabledEdit: true,
                        // we storing here the passwrod that the user write
                        textEditingController: _PostDescription,
                        // keybaord style
                        textInputType: TextInputType.visiblePassword,
                        hint:
                            "We would suggest that the school campous can come with some other things which will be included*",

                        // icon
                        prefixIcon: const Icon(
                          Icons.description,
                          color: SU.primaryColor,
                        ),
                      ),

                      // space

                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Type",
                        style: TextStyle(
                          color: SU.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: SU.backgroundColor, // Border color
                            width: 1.0, // Border width
                          ),
                        ),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          isExpanded: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          value: selectedType,
                          items: ['Post', 'Note'].map((choosedType) {
                            return DropdownMenuItem(
                              value: choosedType,
                              child: Text(choosedType),
                            );
                          }).toList(),
                          onChanged: (newChoosedType) {
                            setState(
                              () {
                                selectedType = newChoosedType!;
                              },
                            );
                          },
                        ),
                      )
                      // Custom text field for email input
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
                        SavePost();
                      },
                      // putting space in the button
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        // the text inside the button
                        child: Text(
                          'Save',
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> SavePost() async {
    // Check if both email and password fields are not empty
    if (_PostDescription.text.isNotEmpty && _PostDescription.text.isNotEmpty) {
      // If not empty, call the `uploadToStorage` function
      SavePostToFirestore();
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
  SavePostToFirestore() async {
    // showing the pop screen
    showDialog(
      context: context,
      builder: (c) {
        // loaidn dialog
        return const LoadingDialogCustom(
          // the message inside the dialog
          message: "Uploading Post Please Wait...",
        );
      },
    );
    // the next Functoin
    UploadData();
  }

  // this function to store data in the Cloud Firebase
  UploadData() async {
    String? currentUser = SU.firebaseAuth?.currentUser?.uid;
    // the start of creating users collection in the database
    await SU.firestore!
        .collection("posts")
        // saving the ID there
        .add(
      {
        // ID
        "uploadedBy": currentUser.toString(),
        // string user full name,
        "postTitle": _PostTitle.text.trim(),
        // stroing the email storing
        "postDescription": _PostDescription.text.trim().toLowerCase(),
        // storing the date of registering
        "uploadedOn": DateFormatting.DateFormat('dd-mm-yyyy')
            .format(DateTime.now())
            .toString(),
        "type": selectedType,
        "likesCount": 0,
      },
      // everything is good
    ).then((value) {
      // remove loading dialog
      Navigator.pop(context);
      // it will go to the login page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post was uploaded')),
      );
      setState(() {
        _PostDescription.text = "";
        _PostDescription.text = "";
      });
    });
  }
}
