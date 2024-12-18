import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'auth_screens.dart'; // Login/Registration screen
import 'home_screen.dart'; // Home screen after successful login
import 'firebase_options.dart'; // Firebase options for your app

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LittleVerse',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthScreen(), // Start with AuthScreen (Login/Registration)
    );
  }
}
