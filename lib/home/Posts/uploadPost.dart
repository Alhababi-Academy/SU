import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as DateFormatting;
import 'package:su_project/config/config.dart';
import 'package:su_project/widgets/customTextFieldRegsiterPage.dart';
import 'package:su_project/widgets/errorDialog.dart';
import 'package:su_project/widgets/loadingDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({Key? key}) : super(key: key);

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  TextEditingController _PostTitle = TextEditingController();
  TextEditingController _PostDescription = TextEditingController();
  TextEditingController _level = TextEditingController();

  TextEditingController _colleges = TextEditingController();

  File? _image;
  File? _video;
  final picker = ImagePicker();

  @override
  void initState() {
    callingTheData();
    super.initState();
  }

  callingTheData() async {
    String? currentUser = SU.firebaseAuth?.currentUser?.uid;
    await SU.firestore?.collection("users").doc(currentUser).get().then(
      (results) {
        _colleges.text = results['College'];
        _level.text = results['Level'];
      },
    );
    print(_colleges.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
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

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: SU
                                .backgroundColor, // Use the correct color for the border
                            width: 1.0, // Adjust the border thickness as needed
                          ),
                        ),
                        child: TextField(
                          controller: _PostDescription,
                          maxLines: 8,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "My Parking has a problem",
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors
                                    .grey), // Adjust the hint text style as needed
                            fillColor: Colors.transparent,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: SU.backgroundColor, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: SU.primaryColor, width: 1.0),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 16,
                              top: 8,
                              bottom: 8,
                              right: 16,
                            ), // Adjust padding to ensure text is vertically centered
                          ),
                        ),
                      ),

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: pickImage,
                              child: const Text('Upload Image'),
                            ),
                            if (_image != null)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Image.file(
                                  _image!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: pickVideo,
                              child: const Text('Upload Video'),
                            ),
                            if (_video != null)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.video_library,
                                  size: 200,
                                ),
                              ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      SU.primaryColor),
                                ),
                                onPressed: () {
                                  SavePost();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 12),
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  Future<void> SavePost() async {
    if (_PostDescription.text.isNotEmpty && _PostTitle.text.isNotEmpty) {
      UploadData();
    } else {
      displayDialog("Please fill in all the fields.");
    }
  }

  void displayDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) {
        return ErrorDialogCustom(message: message);
      },
    );
  }

  Future<void> UploadData() async {
    String? currentUser = SU.firebaseAuth?.currentUser?.uid;

    String imageUrl = '';
    String videoUrl = '';

    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialogCustom(
          message: "Uploading Post Please Wait...",
        );
      },
    );

    if (_image != null) {
      imageUrl = await uploadFileToFirebaseStorage(_image!, 'images');
    }

    if (_video != null) {
      videoUrl = await uploadFileToFirebaseStorage(_video!, 'videos');
    }

    await SU.firestore!.collection("posts").add({
      "uploadedBy": currentUser,
      "postTitle": _PostTitle.text.trim(),
      "postDescription": _PostDescription.text.trim().toLowerCase(),
      "uploadedOn": DateFormatting.DateFormat('dd-MM-yyyy')
          .format(DateTime.now())
          .toString(),
      "likesCount": 0,
      'College': _colleges.text.trim(),
      'Level': _level.text.trim(),
      "imageUrl": imageUrl,
      "videoUrl": videoUrl,
    }).then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post was uploaded successfully')),
      );
      setState(() {
        _PostTitle.clear();
        _PostDescription.clear();
        _image = null;
        _video = null;
      });
    });
  }

  Future<String> uploadFileToFirebaseStorage(
      File file, String folderPath) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('$folderPath/$fileName');

    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
