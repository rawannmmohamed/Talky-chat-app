import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/forgot_password.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const talky());
}

class talky extends StatelessWidget {
  const talky({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LogIn.id: (context) => LogIn(),
        SignUp.id: (context) => SignUp(),
        ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
        Chat.id: (context) =>  Chat(),
        
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LogIn.id,
    );
  }
}
