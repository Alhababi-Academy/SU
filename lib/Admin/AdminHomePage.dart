import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';
import 'package:su_project/home/Authentication/login.dart';
import 'package:su_project/home/BarCode/viewQRCode.dart';
import 'package:su_project/home/Posts/AllPosts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Services",
          style: TextStyle(
            fontSize: 30,
            color: SU.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Route route = MaterialPageRoute(builder: (_) => loginPage());
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              });
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: GridView.count(
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 1.7, // Keeping your aspect ratio
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AllPosts(),
                          ),
                        );
                      },
                      child: Card(
                        color: SU.backGroundContainerColor,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/3.png",
                                width: MediaQuery.of(context).size.width * 0.15,
                              ),
                              const Text(
                                "Add Barcode",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: SU.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
