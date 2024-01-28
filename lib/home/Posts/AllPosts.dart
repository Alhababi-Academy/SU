import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';
import 'package:su_project/home/Posts/commentsPage.dart';
import 'package:su_project/home/Posts/uploadPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  // Function to increment likes
  Future<void> _incrementLikes(String postId, int currentLikes) async {
    await FirebaseFirestore.instance.collection("posts").doc(postId).update({
      "likesCount": currentLikes + 1,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Posts",
            style: TextStyle(color: SU.backgroundColor)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(height: 1.0, thickness: 1.0, color: Colors.grey[300]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const UploadPost()));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data?.docs[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: const AssetImage(
                                    "images/image.png"), // Replace with actual image
                                backgroundColor: Colors.grey[200],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(post?["postTitle"] ?? "Untitled",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(post?["postDescription"] ?? "No Description"),
                          const SizedBox(height: 10),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _incrementLikes(post!.id, post["likesCount"]);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.favorite_outline),
                                    const SizedBox(width: 4),
                                    Text(
                                        "${post?["likesCount"] ?? 0}"), // Display dynamic likes count
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CommentsPage(postId: post!.id),
                                    ),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.comment_outlined),
                                    SizedBox(width: 4),
                                    Text(
                                        "0"), // Replace with dynamic comment count
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
