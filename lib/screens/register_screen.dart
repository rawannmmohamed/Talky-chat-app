import 'package:chat_app/theme/app_theme.dart';
import 'package:chat_app/widgets/circular_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfields.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  static String id = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  String? confirmPassword;
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
                      'Sign Up',
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
              CustomFormTextField(
                obsecure: true,
                  hintText: 'Confirm password',
                  onchange: (data) {
                    confirmPassword = data;
                  }),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                text: 'Sign up',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                     isLoading = true;
                    setState(() {});
                    if (confirmPassword != password) {
                      showSnackBar(context, 'Password is not matched , try again');
                       isLoading = false;
                      setState(() {});
                    }
                    else{
                    try {
                      await regiser();
                      showSnackBar(context, 'successfully registered');
                      Navigator.pop(context);
                      
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(
                            context, 'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context,
                            'The account already exists for that email.');
                      } else {
                        showSnackBar(context, e.message.toString());
                      }
                    }}
                    isLoading = false;
                    setState(() {});
                  } else {}
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ? \t',
                      style: TextStyle(
                          fontSize: 16,
                          color: kTertiaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> regiser() async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
