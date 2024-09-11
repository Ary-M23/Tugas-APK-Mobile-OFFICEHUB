import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Officehub/controllers/auth_controller.dart';
import 'package:Officehub/page/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Initialize AuthService

  @override
  void initState() {
    super.initState();
  }

  void _register() async {
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      User? user = await _authService.registerUser(email, password, fullName);
      if (user != null) {
        // Successfully registered
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration successful!')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ); // Navigate to the login screen
        }
      } else {
        // Registration failed
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed! Please try again.')),
          );
        }
      }
    } else {
      // Display error if fields are empty
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all fields.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create new\naccount',
              style: TextStyle(
                fontSize: 32,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0), // Position of the shadow
                    blurRadius: 5.0, // Blur effect of the shadow
                    color: Color.fromARGB(128, 0, 0, 0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'assets/img/signup1.png',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Full name',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 15,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0), // Position of the shadow
                    blurRadius: 5.0, // Blur effect of the shadow
                    color: Color.fromARGB(128, 0, 0, 0),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Email address',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 15,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0), // Position of the shadow
                    blurRadius: 5.0, // Blur effect of the shadow
                    color: Color.fromARGB(128, 0, 0, 0),
                  ),
                ],
              ),
            ),
            TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'name@example.com',
                  border: UnderlineInputBorder(),
                )),
            SizedBox(
              height: 45,
            ),
            Text(
              'Create new password',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 15,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0), // Position of the shadow
                    blurRadius: 5.0, // Blur effect of the shadow
                    color: Color.fromARGB(128, 0, 0, 0),
                  ),
                ],
              ),
            ),
            TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter your password',
                  border: UnderlineInputBorder(),
                )),
            SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                width: 200, // Set your desired width
                height: 50, // Set your desired height
                child: ElevatedButton(
                  onPressed: _register, // Call the register method
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(19), // Reduced corner radius
                    ),
                  ),
                  child: Text(
                    'Sign Up!',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
