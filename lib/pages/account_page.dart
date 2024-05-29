import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'add_details_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String username = 'John Doe';
  String email = 'john.doe@example.com';
  String? gender;
  int? age;
  double? weight; // kg
  double? height; // cm

  File? _profileImage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final data = userDoc.data()!;
        setState(() {
          email = user.email ?? 'Email not available';
          username = user.displayName ?? 'John Doe';
          gender = data['gender'];
          age = data['age'];
          weight = data['weight'];
          height = data['height'];
        });
      }
    }
  }

  double calculateCalories() {
    if (weight == null || height == null || age == null || gender == null) {
      return 0.0;
    }
    // Folosind formula Mifflin-St Jeor pentru calcularea caloriilor necesare
    return 10 * weight! +
        6.25 * height! -
        5 * age! +
        (gender == 'Male' ? 5 : -161);
  }

  Map<String, double> calculateNutrients() {
    double calories = calculateCalories();
    double protein =
        weight != null ? weight! * 1.2 : 0.0; // 1.2 g per kg of body weight
    double fat = (calories * 0.25) / 9; // 25% of calories from fat
    double carbs = (calories - (protein * 4 + fat * 9)) /
        4; // remaining calories from carbs
    double fiber =
        weight != null ? weight! * 0.035 : 0.0; // 0.035 g per kg of body weight

    final nutrients = {
      'Protein': protein,
      'Fat': fat,
      'Carbs': carbs,
      'Fiber': fiber,
    };

    _storeNutrientData(calories, nutrients);

    return nutrients;
  }

  Future<void> _storeNutrientData(
      double calories, Map<String, double> nutrients) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'calories': calories,
        'protein': nutrients['Protein'],
        'fat': nutrients['Fat'],
        'carbs': nutrients['Carbs'],
        'fiber': nutrients['Fiber'],
      }, SetOptions(merge: true));
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _updateDetails(
      String newGender, int newAge, double newHeight, double newWeight) {
    setState(() {
      gender = newGender;
      age = newAge;
      height = newHeight;
      weight = newWeight;
    });

    _storeUserDetails();
  }

  Future<void> _storeUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'gender': gender,
        'age': age,
        'height': height,
        'weight': weight,
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final nutrients = calculateNutrients();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Account Page', style: TextStyle(fontFamily: 'JosefinSans')),
        backgroundColor: Color(0xFF6E944F),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 244, 239, 228), // Culoare crem
        padding: EdgeInsets.all(screenWidth * 0.11),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.15,
                  backgroundColor: Color(0xFF6A68C9), // Culoare mov inițială
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                          size: screenWidth * 0.15,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              username,
              style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'JosefinSans'),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              email,
              style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black,
                  fontFamily: 'JosefinSans'),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text('Gender: ${gender ?? 'Not specified'}',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            Text('Age: ${age ?? 'Not specified'}',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            Text('Weight: ${weight != null ? '$weight kg' : 'Not specified'}',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            Text('Height: ${height != null ? '$height cm' : 'Not specified'}',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Daily Nutritional Needs',
              style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'JosefinSans'),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text('Protein: ${nutrients['Protein']?.toStringAsFixed(2)} g',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            Text('Fat: ${nutrients['Fat']?.toStringAsFixed(2)} g',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            Text('Carbs: ${nutrients['Carbs']?.toStringAsFixed(2)} g',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            Text('Fiber: ${nutrients['Fiber']?.toStringAsFixed(2)} g',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'JosefinSans')),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6E944F), // Culoare buton
                foregroundColor: Colors.black, // Culoare text
                minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  side: BorderSide(color: Colors.black), // Contur negru
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddDetailsPage(onSave: _updateDetails)),
                );
              },
              child: Text('Add your personal details',
                  style: TextStyle(fontFamily: 'JosefinSans')),
            ),
          ],
        ),
      ),
    );
  }
}
