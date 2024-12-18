import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController childNameController = TextEditingController();
  final TextEditingController childAgeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleRegistration(BuildContext context) {
    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        childNameController.text.isNotEmpty &&
        childAgeController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful! Please Log In.")),
      );
      Navigator.pop(context); // Redirect back to Login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Color(0xFF3DBDA7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Parent's Full Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: childNameController,
                decoration: InputDecoration(
                  labelText: "Child's Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: childAgeController,
                decoration: InputDecoration(
                  labelText: "Child's Age",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => handleRegistration(context),
                child: Text("SIGN UP"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3DBDA7),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
