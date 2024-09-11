import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Officehub/page/login.dart';

class ProfileKaryawanPage extends StatefulWidget {
  const ProfileKaryawanPage({super.key});

  @override
  State<ProfileKaryawanPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileKaryawanPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String fullname = user?.displayName ?? 'User';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 50,
              ),
              Card(
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14), // Reduced corner radius
                ),
                child: SizedBox(
                  height: 250,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.red,
                          backgroundImage: AssetImage(
                              'assets/img/pp.png'), //pp.png ga muncul, padahal klo pake login1.png bisa
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 60),
                            Text(
                              fullname,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'UI Designer',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  _auth.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 12,
                  backgroundColor: Colors.red, // Background color
                  padding: EdgeInsets.symmetric(
                      horizontal: 25, vertical: 15), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14), // Reduced corner radius
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
