import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:su_project/home/Posts/commentsPage.dart';
import 'package:su_project/home/Posts/uploadPost.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({Key? key}) : super(key: key);

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  String? selectedCollege, selectedLevel, selectedCourse;
  List<String> colleges = [], levels = [], courses = [];

  @override
  void initState() {
    super.initState();
    fetchFilters();
  }

  fetchFilters() async {
    var postsSnapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    var fetchedColleges = postsSnapshot.docs
        .map((doc) => doc['college'] as String)
        .toSet()
        .toList();
    var fetchedLevels = postsSnapshot.docs
        .map((doc) => doc['level'] as String)
        .toSet()
        .toList();
    var fetchedCourses = postsSnapshot.docs
        .map((doc) => doc['course'] as String)
        .toSet()
        .toList();

    setState(() {
      colleges = fetchedColleges;
      levels = fetchedLevels;
      courses = fetchedCourses;
    });
  }

  Stream<QuerySnapshot> getFilteredPosts() {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('posts');
    if (selectedCollege != null && selectedCollege!.isNotEmpty) {
      query = query.where('college', isEqualTo: selectedCollege);
    }
    if (selectedLevel != null && selectedLevel!.isNotEmpty) {
      query = query.where('level', isEqualTo: selectedLevel);
    }
    if (selectedCourse != null && selectedCourse!.isNotEmpty) {
      query = query.where('course', isEqualTo: selectedCourse);
    }
    return query.snapshots();
  }

  Future<void> _incrementLikes(String postId, int currentLikes) async {
    await FirebaseFirestore.instance.collection("posts").doc(postId).update({
      "likesCount": FieldValue.increment(1),
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Posts'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCollege,
                  hint: const Text("Select College"),
                  items: colleges.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) => setState(() => selectedCollege = value),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedLevel,
                  hint: const Text("Select Level"),
                  items: levels.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) => setState(() => selectedLevel = value),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCourse,
                  hint: const Text("Select Course"),
                  items: courses.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) => setState(() => selectedCourse = value),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Clear Filter'),
              onPressed: () {
                setState(() {
                  selectedCollege = null;
                  selectedLevel = null;
                  selectedCourse = null;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget buildPostCard(
      Map<String, dynamic> post, BuildContext context, String documentId) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (post['imageUrl'] != null)
                  Image.network(
                    post['imageUrl'],
                    width: 100, // Adjusted for a smaller image display
                    height: 100, // Fixed height for uniformity
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['postTitle'] ?? 'Untitled',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        post['postDescription'] ?? 'No Description',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () =>
                      _incrementLikes(documentId, post['likesCount'] ?? 0),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite_border, color: Colors.red),
                      Text(" ${post['likesCount'] ?? 0}"),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CommentsPage(postId: documentId)));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.comment, color: Colors.blue),
                      Text(" Comment"),
                    ],
                  ),
                ),
              ],
            ),
            if (post['videoUrl'] != null)
              Center(
                child: TextButton(
                  onPressed: () {
                    // Placeholder for future video functionality
                  },
                  child: const Text("View Video"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Posts"),
        actions: [
          IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const UploadPost())),
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: getFilteredPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> post =
                    document.data()! as Map<String, dynamic>;
                return buildPostCard(post, context,
                    document.id); // Pass the document ID as postId
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
