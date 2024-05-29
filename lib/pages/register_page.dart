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

                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Name',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // email textfield
                  MyTextField(
                    controller: emailController,
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

                  // confirm password textfield
                  MyTextField(
                    controller: passwordConfirmationController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 40),

                  // Sign Up button
                  MyButton(
                    onTap: () => signUpUser(
                        context), // Pass the context to the signUpUser method
                    text: 'Sign Up', // Text for the sign up button
                  ),

                  const SizedBox(height: 10),

                  // already a member? log in now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
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
