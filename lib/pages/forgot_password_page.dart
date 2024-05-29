import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutri_boost/components/my_button.dart';
import 'package:nutri_boost/components/my_textfield.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key});

  // text editing controllers
  final emailController = TextEditingController();

  // reset password method
  void resetPassword(BuildContext context) async {
    final email = emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent')),
      );

      // Navigate to LogInPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogInPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 10),
                  //Logo
                  Image.asset('lib/images/logo.png', width: 200, height: 200),

                  const SizedBox(height: 10),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 40),

                  // Change password button
                  MyButton(
                    onTap: () => resetPassword(context),
                    text: 'Reset Password', // Text for the button
                  ),

                  const SizedBox(height: 10),

                  // remembered your password?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you remember your password?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
