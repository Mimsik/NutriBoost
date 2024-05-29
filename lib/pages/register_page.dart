import 'package:flutter/material.dart';
import 'package:nutri_boost/components/my_button.dart';
import 'package:nutri_boost/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key});

  // text editing controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  // Sign user up method
  void signUpUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordConfirmation = passwordConfirmationController.text.trim();

    if (password != passwordConfirmation) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match'),
      ));
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // You can also update the user's display name with the username here
      await userCredential.user
          ?.updateDisplayName(usernameController.text.trim());

      // If sign-up is successful, navigate to the LogInPage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LogInPage()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
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
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/images/background_image.jpeg'), // Set your image path here
            fit: BoxFit
                .cover, // You can change the BoxFit according to your requirement
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
                  Image.asset('lib/images/logo.png',
                      width: screenWidth * 0.5, height: screenHeight * 0.25),

                  SizedBox(height: screenHeight * 0.05),

                  // username textfield
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: MyTextField(
                      controller: usernameController,
                      hintText: 'Name',
                      obscureText: false,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

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

                  SizedBox(height: screenHeight * 0.02),

                  // confirm password textfield
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: MyTextField(
                      controller: passwordConfirmationController,
                      hintText: 'Confirm password',
                      obscureText: true,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Sign Up button
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        onTap: () => signUpUser(
                            context), // Pass the context to the signUpUser method
                        text: 'Sign Up', // Text for the sign up button
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // already a member? log in now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPage()),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Color.fromARGB(255, 129, 61, 247),
                            fontWeight: FontWeight.bold,
                            decoration:
                                TextDecoration.underline, // Add underline style
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
