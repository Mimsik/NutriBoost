import 'package:flutter/material.dart';
import 'home_page.dart'; // Ensure this import path is correct

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _foodList =
      []; // List of foods containing the searched macronutrient
  final Map<String, List<String>> _macronutrientFoods = {
    'proteins': ['Meat', 'Eggs', 'Nuts', 'Mushrooms'],
    'carbs': ['Bread', 'Pasta', 'Rice', 'Potatoes'],
    'fats': ['Avocado', 'Cheese', 'Nuts', 'Olive Oil'],
  };

  void _searchMacronutrient(String query) {
    setState(() {
      _foodList = _macronutrientFoods[query.toLowerCase()] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Fixed background image
          Positioned.fill(
            child: Image.asset(
              'lib/images/avocado_image.jpeg', // Ensure this image path is correct
              fit: BoxFit.cover,
            ),
          ),
          // Search bar and food list
          SafeArea(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search macronutrients',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: _searchMacronutrient,
                  ),
                ),
                SizedBox(height: 16),
                // Food list
                Expanded(
                  child: Container(
                    color: Colors.transparent, // Keep background transparent
                    child: SingleChildScrollView(
                      child: Column(
                        children: _foodList.map((food) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              leading: Icon(Icons.food_bank),
                              title: Text(
                                food,
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
