import 'package:chat_app/helper/snack_bar.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static String id = 'forgotpassword';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;


  

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
        showSnackBar(context, 'Password reset email sent.');
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        forceMaterialTransparency: true,
        foregroundColor: kSecondaryColor,
      ),
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            
            children: [
              Image.asset('images/undraw_Forgot_password_re_hxwm (1).png'),
            const  SizedBox(height: 100,),
              CustomFormTextField(
                onchange: (data) {
                  email = data;
                  
                },
                obsecure: false,
                hintText: 'Enter your email ',
              ),
              const SizedBox(height: 20),
            CustomButton(text: 'Reset password',onTap: () => _resetPassword(),),
            
            ],
          ),
        ),
      ),
    );
  }
}
