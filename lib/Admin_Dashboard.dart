import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handball/Adding.dart';
import 'package:handball/Exercises.dart';
import 'package:handball/HandballBeginner.dart';
import 'package:handball/HandballProfessional.dart';
import 'VideoItem .dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Exercise>> readExercises() {
    return firestore.collection('Exercises').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Exercise.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Stream<List<VideoItem>> readHandballBeginnerItems() {
    return firestore.collection('HandballBeginner').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return VideoItem.fromMap(data, doc.id);
      }).toList();
    });
  }

  Stream<List<VideoItem>> readHandballProfessionalItems() {
    return firestore
        .collection('HandballProfessional')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return VideoItem.fromMap(data, doc.id);
      }).toList();
    });
  }

  Future<void> deleteExercise(String exerciseId) async {
    await firestore.collection('Exercises').doc(exerciseId).delete();
  }

  Future<void> deleteBeginnerVideo(String videoId) async {
    await firestore.collection('HandballBeginner').doc(videoId).delete();
  }

  Future<void> deleteProfessionalVideo(String videoId) async {
    await firestore.collection('HandballProfessional').doc(videoId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Fitness Category',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 300,
              child: StreamBuilder<List<Exercise>>(
                stream: readExercises(),
                builder: (context, exerciseSnapshot) {
                  if (exerciseSnapshot.hasError) {
                    return Text(
                        'Error loading exercises: ${exerciseSnapshot.error}');
                  }

                  if (exerciseSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<Exercise> exercises = exerciseSnapshot.data ?? [];

                  return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final Exercise exercise = exercises[index];
                      return ListTile(
                        leading: Image.network(
                          exercise.imageUrl,
                          width: 100,
                          height: 100,
                        ),
                        title: Text(exercise.name),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteExercise(exercise.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Divider(
              indent: 40,
              endIndent: 40,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Handball Beginner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 300, // Adjust height as needed
              child: StreamBuilder<List<VideoItem>>(
                stream: readHandballBeginnerItems(),
                builder: (context, beginnerSnapshot) {
                  if (beginnerSnapshot.hasError) {
                    return Text(
                        'Error loading beginner items: ${beginnerSnapshot.error}');
                  }

                  if (beginnerSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<VideoItem> beginnerItems =
                      beginnerSnapshot.data ?? [];

                  return ListView.builder(
                    itemCount: beginnerItems.length,
                    itemBuilder: (context, index) {
                      final VideoItem video = beginnerItems[index];
                      return ListTile(
                        leading: Icon(Icons.video_library),
                        title: Text(video.name),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteBeginnerVideo(video.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Divider(
              indent: 40,
              endIndent: 40,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Handball Professional',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 300,
              child: StreamBuilder<List<VideoItem>>(
                stream: readHandballProfessionalItems(),
                builder: (context, professionalSnapshot) {
                  if (professionalSnapshot.hasError) {
                    return Text(
                        'Error loading professional items: ${professionalSnapshot.error}');
                  }

                  if (professionalSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<VideoItem> professionalItems =
                      professionalSnapshot.data ?? [];

                  return ListView.builder(
                    itemCount: professionalItems.length,
                    itemBuilder: (context, index) {
                      final VideoItem video = professionalItems[index];
                      return ListTile(
                        leading: Icon(Icons.video_library),
                        title: Text(video.name),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteProfessionalVideo(video.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Adding()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
