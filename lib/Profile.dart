import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _profileImagePath;
  bool _isEditMode = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _emailController.text = user.email ?? '';
        _fetchUserDataFromFirestore(user.uid);
      });
    }
  }

  Future<void> _fetchUserDataFromFirestore(String uid) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Profile_Screen')
        .doc(uid)
        .get();
    if (userDoc.exists) {
      setState(() {
        _fullNameController.text = userDoc['fullName'] ?? '';
        _profileImagePath = userDoc['profileImagePath'] ?? '';
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _profileImagePath = pickedFile.path;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Profile_Screen')
            .doc(user.uid)
            .set({
          'fullName': _fullNameController.text,
          'email': _emailController.text,
          'profileImagePath': _profileImagePath,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile saved successfully')));
      }
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
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
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 2, 39),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (_isEditMode) {
                        _pickImage(ImageSource.gallery);
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImagePath != null
                          ? FileImage(File(_profileImagePath!))
                          : null,
                      child: _profileImagePath == null
                          ? Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey[700],
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _fullNameController.text,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProfileField(
                    icon: Icons.person,
                    controller: _fullNameController,
                    hint: 'Full Name',
                    enabled: _isEditMode,
                  ),
                  _buildProfileField(
                    icon: Icons.email,
                    controller: _emailController,
                    hint: 'Email',
                    enabled: _isEditMode,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_isEditMode) {
                        _saveProfile();
                      }
                      _toggleEditMode();
                    },
                    child: Text(
                      _isEditMode ? 'Save' : 'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 2, 39),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    bool enabled = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        enabled: enabled,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[700]),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[700]),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hint';
          }
          return null;
        },
      ),
    );
  }
}
