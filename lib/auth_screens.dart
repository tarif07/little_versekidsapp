import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController childNameController = TextEditingController();

  bool isLogin = true; // Toggle between login and registration
  bool isConsentGiven = false; // Parental consent for registration

  // Show Snackbar for Errors
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.white))),
    );
  }

  // Handle Login
  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showError('Please fill all fields');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      showError('Invalid email or password');
    }
  }

  // Handle Registration
  Future<void> registerUser() async {
    if (parentNameController.text.isEmpty ||
        childNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showError('Please fill all fields');
      return;
    }

    if (!isConsentGiven) {
      showError('Please accept parental consent to proceed');
      return;
    }

    if (passwordController.text.length < 6) {
      showError('Password must be at least 6 characters');
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        isLogin = true;
      });
      showError('Registration Successful! Please log in.');
    } catch (e) {
      showError('Error: Unable to register');
    }
  }

  // Forgot Password
  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      showError('Please enter your email to reset password');
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      showError('Password reset link sent to your email.');
    } catch (e) {
      showError('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevent shrinking with keyboard
      body: Container(
        width: double.infinity, // Full width
        height: MediaQuery.of(context).size.height, // Full height
        color: Color(0xFF3DBDA7), // Blue background
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isLogin ? 'Welcome Back!' : 'Create Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  isLogin
                      ? 'Log in to access LittleVerse'
                      : 'Sign up to get started with LittleVerse',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                _buildFormFields(), // Form Fields
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        if (!isLogin) ...[
          TextField(
            controller: parentNameController,
            decoration: InputDecoration(
              hintText: 'Parent Name',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: childNameController,
            decoration: InputDecoration(
              hintText: 'Child Name',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.child_care),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
        ],
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        if (!isLogin)
          Row(
            children: [
              Checkbox(
                value: isConsentGiven,
                onChanged: (value) {
                  setState(() {
                    isConsentGiven = value ?? false;
                  });
                },
              ),
              Expanded(
                child: Text(
                  'I accept the parental consent terms.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        if (isLogin)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: resetPassword,
              child: Text('Forgot Password?',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLogin ? loginUser : registerUser,
          child: Text(isLogin ? 'LOGIN' : 'SIGN UP'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF3DBDA7),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin
                ? 'Don’t have an account? Sign Up'
                : 'Already have an account? Login',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
