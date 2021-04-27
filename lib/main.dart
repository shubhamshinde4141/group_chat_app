import 'package:flutter/material.dart';
import 'package:group_chat_app/Screens/chat_screen.dart';
import 'package:group_chat_app/Screens/registration_screen.dart';
import 'package:group_chat_app/Screens/login_screen.dart';
import 'package:group_chat_app/splash_screen.dart';

import 'Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
//import 'To-Do/provider/todos.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splashscreen',
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        'splashscreen': (context) => SplashScreen(),
        //  'register':(context)=> RegistrationScreen()
      },
    );
  }
}
