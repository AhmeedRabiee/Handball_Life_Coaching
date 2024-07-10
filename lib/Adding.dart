import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adding extends StatefulWidget {
  const Adding({Key? key}) : super(key: key);

  @override
  _AddingState createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController videoUrlController =
      TextEditingController(); // New controller for video URL
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedCategory;
  bool showVideoUrl = false;
  bool showImageUrl = true; // Added boolean to track whether to show Image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Item',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add New Item',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Item Name',
                  hintText: 'Enter Item Name',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Description',
                  hintText: 'Enter Item Description',
                ),
                maxLines: 4,
              ),
              SizedBox(height: 10),
              if (showImageUrl) // Conditionally show/hide Image URL TextField
                TextField(
                  controller: imageUrlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Image URL',
                    hintText: 'Enter Image URL',
                  ),
                ),
              SizedBox(height: 10),
              if (showVideoUrl)
                TextField(
                  controller:
                      videoUrlController, // New text field for video URL
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Video URL',
                    hintText: 'Enter Video URL',
                  ),
                ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  labelText: 'Category',
                ),
                items: ['Fitness', 'Handball Beginner', 'Handball Professional']
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    if (value == 'Handball Beginner' ||
                        value == 'Handball Professional') {
                      showVideoUrl = true;
                      showImageUrl =
                          false; // Hide Image URL when Handball is selected
                    } else {
                      showVideoUrl = false;
                      showImageUrl =
                          true; // Show Image URL for other categories
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    final String name = nameController.text.trim();
                    final String description =
                        descriptionController.text.trim();
                    final String imageUrl = imageUrlController.text.trim();
                    final String videoUrl =
                        videoUrlController.text.trim(); // Get video URL

                    if (name.isNotEmpty &&
                        description.isNotEmpty &&
                        ((showImageUrl && imageUrl.isNotEmpty) ||
                            !showImageUrl) &&
                        selectedCategory != null) {
                      String collectionName;
                      if (selectedCategory == 'Fitness') {
                        collectionName = 'Exercises';
                      } else if (selectedCategory == 'Handball Beginner') {
                        collectionName = 'HandballBeginner';
                      } else if (selectedCategory == 'Handball Professional') {
                        collectionName = 'HandballProfessional';
                      } else {
                        return;
                      }

                      Map<String, dynamic> data = {
                        'name': name,
                        'description': description,
                      };

                      if (showImageUrl) {
                        data['imageUrl'] = imageUrl;
                      }

                      if (showVideoUrl) {
                        data['videoUrl'] = videoUrl;
                      }

                      firestore
                          .collection(collectionName)
                          .add(data)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Item Added Successfully')),
                        );

                        nameController.clear();
                        descriptionController.clear();
                        imageUrlController.clear();
                        videoUrlController.clear();
                        setState(() {
                          selectedCategory = null;
                        });
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add item: $error')),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please fill all fields and select a category'),
                        ),
                      );
                    }
                  },
                  child: Text('Add Item'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
