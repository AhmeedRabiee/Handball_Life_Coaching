import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id;
  final String name;
  final String imageUrl;

  Exercise({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Exercise.fromMap(Map<String, dynamic> map, String id) {
    return Exercise(
      id: id,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}


