import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handball/ExerciseItem.dart';

class Fitness extends StatefulWidget {
  const Fitness({Key? key}) : super(key: key);

  @override
  _FitnessState createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<ExerciseItem>> readExercises() {
    return firestore.collection('Exercises').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ExerciseItem(
          title: data['name'],
          description: data['description'],
          imagePath: data['imageUrl'],
          onTap: () {},
        );
      }).toList();
    });
  }

  Future<void> deleteExercise(String exerciseId) async {
    await firestore.collection('Exercises').doc(exerciseId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 2, 39),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Fitness and Workout',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(100),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: StreamBuilder<List<ExerciseItem>>(
                  stream: readExercises(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final exercises = snapshot.data ?? [];

                    return ListView(
                      children: exercises.map((exerciseItem) {
                        return Column(
                          children: [
                            exerciseItem,
                            const Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
