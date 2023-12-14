import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedContainer = 0;
  String? currentUser = FirebaseAuth.instance.currentUser?.uid;
  bool? favorite = false;

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
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
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
              Column(
                children: [
                  const Text("Next Class"),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: SU.backGroundContainerColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Wednesday, 8 Nov"),
                        Row(
                          children: [
                            const Column(
                              children: [
                                Column(
                                  children: [
                                    Text("11:00AM"),
                                    Text(
                                      "---to---",
                                      style:
                                          TextStyle(color: SU.backgroundColor),
                                    ),
                                    Text("12:30")
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black,
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ACCT-301-01 - Intermediate Accounting 1",
                                    style: TextStyle(
                                      color: SU.backgroundColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.map,
                                            color: SU.primaryColor,
                                          ),
                                          Text("Building: 24"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Room: "),
                                          Text("174"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Column(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
