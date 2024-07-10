import 'package:flutter/material.dart';

class VideoItem {
  final String id;
  final String name;
  final String description;
  final String videoUrl;

  VideoItem({
    required this.id,
    required this.name,
    required this.description,
    required this.videoUrl,
  });

  factory VideoItem.fromMap(Map<String, dynamic> data, String id) {
    return VideoItem(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
    );
  }
}

