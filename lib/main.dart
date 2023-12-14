// this is for cloud firebase
import 'package:cloud_firestore/cloud_firestore.dart';
// this is for the authentication from firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// this is for all the wigets
import 'package:flutter/material.dart';
// this is to let the app know we are
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:su_project/config/config.dart';
import 'package:su_project/firebase_options.dart';
import 'package:su_project/splashScreen/splashScreen.dart';

Future<void> main() async {
  // this is to idntfy we using Flutter
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // this is auth, email.
  SU.firebaseAuth = FirebaseAuth.instance;
  // this is for saving the data in the databse. everythign else
  SU.firestore = FirebaseFirestore.instance;
  // to save pictures of files
  SU.firebaseStorage = FirebaseStorage.instance;
  // saving data temp
  SU.sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// this is the start of the widgets
  Widget build(BuildContext context) {
    // this is the main widget which is a white screen
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // for the app color
      theme: ThemeData(
        primaryColor: SU.primaryColor,
        primarySwatch: SU.myMaterialColor,
      ),
      // frist screen
      home: const splashScreen(),
    );
  }
}
