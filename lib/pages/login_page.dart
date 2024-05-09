import 'package:flutter/material.dart';
import 'package:nutri_boost/components/my_button.dart';
import 'package:nutri_boost/components/my_textfield.dart';
import 'package:nutri_boost/pages/home_page.dart'; // Asigură-te că această cale este corectă
import 'package:nutri_boost/pages/forgot_password_page.dart';
import 'package:nutri_boost/pages/register_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key});

    // LogInUser method
  void LogInUser(BuildContext context) {
    // Aici vei verifica credențialele și vei naviga către HomePage dacă sunt corecte.
    // Pentru demonstrație, presupunem că autentificarea a reușit și navigăm direct.
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

                  const SizedBox(height: 25),

                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to ForgotPasswordPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0,
                                  0), // Change text color to indicate it's a link
                              decoration: TextDecoration
                                  .underline, // Add underline to indicate it's clickable
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Log In button
                  MyButton(
                    onTap: () => LogInUser(context), // Modifică aici pentru a trece contextul
                    text: 'Log In',
                  ),

                  const SizedBox(height: 10),

                  // not a member? register now
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No account yet?',
                        style: TextStyle(
                            color: Colors
                                .black), // Set text color to match your background
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          // Navigate to SignUpPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromARGB(255, 173, 126, 255),
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
