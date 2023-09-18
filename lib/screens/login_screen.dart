import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/forgot_password.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/snack_bar.dart';
import '../widgets/circular_button.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});
  static String id = 'login';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  String? userEmail;
  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: kSecondaryColor,
      ),
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
        ),
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Talky',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: kTertiaryColor,
                        fontFamily: 'Inter',
                      )),
                  Text(
                    '.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 55,
                        color: kSecondaryColor,
                        fontFamily: 'Inter'),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          color: kTertiaryColor),
                    ),
                  ),
                ],
              ),
              CustomFormTextField(
                obsecure: false,
                hintText: 'Email',
                onchange: (data) {
                  email = data;
                },
              ),
              CustomFormTextField(
                obsecure: true,
                hintText: 'Password',
                onchange: (data) {
                  password = data;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: GestureDetector(
                      child: const Text(
                        'Forgot password ?',
                        style: TextStyle(
                            fontSize: 16,
                            color: kTertiaryColor,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPasswordScreen.id);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                text: 'Sign in',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await login();
                      showSnackBar(context, 'Successfully loged in');
                      Navigator.pushNamed(context, Chat.id,
                          arguments: FirebaseAuth.instance.currentUser!.email.toString());
                          
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(
                            context, 'Wrong password provided for that user.');
                      } else {
                        showSnackBar(context, e.message.toString());
                      }
                    }
                    isLoading = false;
                    setState(() {});
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ? \t',
                      style: TextStyle(
                          fontSize: 16,
                          color: kTertiaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '_____________\t  or  \t_____________',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 142),
                child: Text(
                  'Sign in with',
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: 17, color: kTertiaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularButton(
                      image: 'images/google.jpeg',
                      ontap: () {
                        try {
                          signInWithGoogle();
                          Navigator.pushNamed(context, Chat.id,
                              arguments:
                                  FirebaseAuth.instance.currentUser!.email.toString());
                          
                        } catch (e) {
                          showSnackBar(context, 'error');
                        }
                      },
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> login() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
