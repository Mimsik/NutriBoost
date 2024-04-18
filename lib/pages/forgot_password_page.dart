import 'package:flutter/material.dart';
import 'package:nutri_boost/components/my_button.dart';
import 'package:nutri_boost/components/my_textfield.dart';
import 'package:nutri_boost/components/square_tile.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void ForgotPassword() {}

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
                  Positioned(
                    left: 250,
                    top: 0,
                    child: Image.asset('lib/images/logo.png',
                        width: 200, height: 200),
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Email',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'New Password',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 40),

                  // Change password button
                  MyButton(
                    onTap: () {
                      // Navigate to LogInPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInPage()),
                      );
                    },
                    text: 'Change password', // Text for the button
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
                            color: Color.fromARGB(255, 173, 126, 255),
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
