import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddDetailsPage extends StatefulWidget {
  final Function(String, int, double, double) onSave;

  const AddDetailsPage({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddDetailsPageState createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _gender = '';
  int _age = 0;
  double _height = 0.0;
  double _weight = 0.0;

  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

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
          _gender = data['gender'] ?? '';
          _age = data['age'] ?? 0;
          _height = data['height'] ?? 0.0;
          _weight = data['weight'] ?? 0.0;

          _genderController.text = _gender;
          _ageController.text = _age.toString();
          _heightController.text = _height.toString();
          _weightController.text = _weight.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _genderController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Personal Details',
            style: TextStyle(fontFamily: 'JosefinSans')),
        backgroundColor: Color(0xFF6E944F),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: TextStyle(fontFamily: 'JosefinSans'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
                onSaved: (value) {
                  _gender = value!;
                },
                style: TextStyle(fontFamily: 'JosefinSans'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: TextStyle(fontFamily: 'JosefinSans'),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
                style: TextStyle(fontFamily: 'JosefinSans'),
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: TextStyle(fontFamily: 'JosefinSans'),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
                onSaved: (value) {
                  _height = double.parse(value!);
                },
                style: TextStyle(fontFamily: 'JosefinSans'),
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  labelStyle: TextStyle(fontFamily: 'JosefinSans'),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
                onSaved: (value) {
                  _weight = double.parse(value!);
                },
                style: TextStyle(fontFamily: 'JosefinSans'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6E944F), // Culoare buton
                  foregroundColor: Colors.black, // Culoare text
                  textStyle:
                      TextStyle(fontFamily: 'JosefinSans'), // Fontul textului
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onSave(_gender, _age, _height, _weight);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
