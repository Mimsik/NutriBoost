import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutri_boost/components/my_button.dart';
import 'package:nutri_boost/components/my_textfield.dart';
import 'package:nutri_boost/pages/home_page.dart';
import 'package:nutri_boost/pages/forgot_password_page.dart';
import 'package:nutri_boost/pages/register_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // LogInUser method
  void logInUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If login is successful, navigate to the HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again.'),
      ));
    }
  }

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
                  SizedBox(
                      height: screenHeight * 0.001), // Moved the logo higher

                  // Logo
                  Image.asset(
                    'lib/images/logo.png',
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.22,
                  ),

                  SizedBox(height: screenHeight * 0.03), // Adjusted spacing

                  // email textfield
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // password textfield
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  // forgot password?
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
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
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'JosefinSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04), // Adjusted spacing

                  // Log In button
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1), // Narrowed button
                    child: SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        onTap: () => logInUser(context),
                        text: 'Log In',
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No account yet?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold, // Bold text
                          fontFamily: 'JosefinSans',
                        ),
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
                            color: Color.fromARGB(255, 129, 61, 247),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontFamily: 'JosefinSans',
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
