import 'package:flutter/material.dart' show AssetImage, BoxDecoration, BoxFit, BuildContext, Center, Color, Colors, Column, Container, DecorationImage, EdgeInsets, FontWeight, GestureDetector, Image, Key, MainAxisAlignment, MaterialPageRoute, MediaQuery, Navigator, Padding, Positioned, Row, SafeArea, Scaffold, SingleChildScrollView, SizedBox, StatelessWidget, Text, TextDecoration, TextEditingController, TextStyle, Widget;
import 'package:nutri_boost/components/my_button.dart';
import 'package:nutri_boost/components/my_textfield.dart';
import 'package:nutri_boost/pages/home_page.dart';
import 'package:nutri_boost/pages/forgot_password_page.dart';
import 'package:nutri_boost/pages/register_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key});

  // LogInUser method
  void LogInUser(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/background_image.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.02),

                  // Logo
                  Positioned(
                    left: screenWidth * 0.65,
                    top: screenHeight * 0.02,
                    child: Image.asset(
                      'lib/images/logo.png',
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.25,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // username textfield
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: MyTextField(
                      controller: usernameController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // password textfield
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // forgot password?
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Log In button
                  MyButton(
                    onTap: () => LogInUser(context),
                    text: 'Log In',
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No account yet?',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromARGB(255, 173, 126, 255),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
