import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handball/VideoPlayerScreen.dart';
import 'VideoItem .dart';

class HandballBeginner extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<VideoItem>> readHandballBeginnerItems() {
    return firestore.collection('HandballBeginner').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return VideoItem.fromMap(data, doc.id);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Handball Beginner Videos',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Color.fromARGB(255, 0, 2, 39),
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 2, 39), 
        child: StreamBuilder<List<VideoItem>>(
          stream: readHandballBeginnerItems(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No videos found.'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                VideoItem video = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Icon(Icons.play_circle_fill),
                    title: Text(
                      video.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(video.description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerScreen(videoUrl: video.videoUrl),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
