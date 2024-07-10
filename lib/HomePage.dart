import 'package:flutter/material.dart';
import 'package:handball/Fitness.dart';
import 'package:handball/HandballBeginner.dart';
import 'package:handball/HandballProfessional.dart';
import 'package:handball/Nutrition.dart';
import 'package:handball/Profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Home of Handball'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 2, 39),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/G.jpg'),
                    radius: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Be Motivated',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 2, 39),
        child: ListView(
          children: [
            _buildImageCard(
              context,
              "assets/FT.jpg",
              "Fitness",
              "Improve your fitness level with our workout programs.",
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Fitness()),
              ),
            ),
            _buildImageCard(
              context,
              "assets/GH.jpg",
              "Handball Beginner",
              "Learn the basics of handball and start playing.",
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HandballBeginner()),
              ),
            ),
            _buildImageCard(
              context,
              "assets/HP.jpg",
              "Handball Professional",
              "Advance your handball skills with our expert training.",
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HandballProfessional()),
              ),
            ),
            _buildImageCard(
              context,
              "assets/Nutrition.jpg",
              "Nutrition",
              "Discover healthy eating habits and nutritious recipes.",
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Nutrition()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(BuildContext context, String imagePath, String title,
      String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
                width: 400,
                height: 200,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
