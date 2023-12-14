import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SU {
  // Color
  static const Color primaryColor = Color(0xff115847); // A soothing blue color
  static const Color backgroundColor =
      Color(0xffB6976C); // A light grayish-blue background
  static const Color textColor = Color(0xff2c3e50); // A dark gray text color
  static const Color logoColor1 =
      Color(0xffe74c3c); // A vibrant red for your logo
  static const Color backGroundContainerColor =
      Color(0xffF2F2F4); // A fresh green for your logo

  static MaterialColor myMaterialColor = const MaterialColor(0xff115847, {
    50: Color(0xff115847), // Light blue shade
    100: Color(0xff115847), // Lighter blue shade
    200: Color(0xff115847), // Primary blue shade
    300: Color(0xff115847), // A bit darker blue shade
    400: Color(0xff115847), // Darker blue shade
    500: Color(0xff115847), // Dark blue, matching text color
    600: Color(0xff115847), // Even darker blue shade
    700: Color(0xff115847), // Very dark blue shade
    800: Color(0xff115847), // Almost black shade
    900: Color(0xff115847), // Deep black shade
  });

  // Config Files
  static String name = "name";
  static String email = "";

  // Firebase
  static FirebaseAuth? firebaseAuth;
  static FirebaseFirestore? firestore;
  static SharedPreferences? sharedPreferences;
  static FirebaseStorage? firebaseStorage;

  // Map API
  static const Map_API = "AIzaSyBpLzaDvyWfvVvxD9xO3fM1i5FfCbjJ9nE";
}
