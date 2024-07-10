import 'dart:async';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  const ExerciseItem({
    Key? key,
    required this.title,
    this.description = '',
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Image.network(imagePath, width: 100, height: 100),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }

  static Stream<List<ExerciseItem>> fromMap(Map<String, dynamic> data) {
    // Implement the conversion logic here
    StreamController<List<ExerciseItem>> controller = StreamController();

    // Assuming data contains a list of exercise item details
    List<dynamic> itemsData = data['items'] ?? [];

    // Transform the data into ExerciseItem objects
    List<ExerciseItem> items = itemsData.map((item) {
      return ExerciseItem(
        title: item['title'] ?? '',
        description: item['description'] ?? '',
        imagePath: item['imagePath'] ?? '',
        onTap: () {
          // Handle onTap behavior if needed
        },
      );
    }).toList();

    // Add the transformed list to the stream controller
    controller.add(items);

    // Close the stream when done
    controller.close();

    // Return the stream
    return controller.stream;
  }
}
