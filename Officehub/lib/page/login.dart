import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Officehub/controllers/auth_controller.dart';
import 'package:Officehub/page/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false; // Track the switch state
  final AuthService _authService = AuthService(); // Initialize AuthService

  @override
  void initState() {
    super.initState();
  }

  void _saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        User? user =
            await _authService.signInWithEmailAndPassword(email, password);
        if (user != null) {
          // Successfully signed in
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign in successful!')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage()), // Navigate to home page
            );
          }
        } else {
          // Sign in failed
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign in failed! Please try again.')),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase specific errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      } catch (e) {
        // Handle general errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
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
              'Welcome\nback!',
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
                'assets/img/login1.png',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Email',
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
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Password',
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remember me',
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
                Switch(
                  inactiveThumbColor: Colors.white,
                  activeColor: Colors.grey.shade900,
                  value: _rememberMe,
                  onChanged: (bool value) {
                    setState(() {
                      _rememberMe = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: 200, // Set your desired width
                height: 50, // Set your desired height
                child: ElevatedButton(
                  onPressed: _signIn, // Call the signIn method
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(19), // Reduced corner radius
                    ),
                  ),
                  child: Text(
                    'Sign In!',
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
