import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Officehub/controllers/auth_controller.dart';
import 'package:camera/camera.dart';

import 'contacts.dart';
import 'createReport.dart';
import 'holidayReq.dart';
import 'messages.dart';
import 'profileHRD.dart';
import 'profileKaryawan.dart';
import 'scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraDescription _camera;
  late PageStorageBucket _bucket;
  String role = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _bucket = PageStorageBucket();
    _fetchUserRole();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      setState(() {
        _camera = cameras.first;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _fetchUserRole() async {
    AuthService _authService = AuthService();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? fetchedRole = await _authService.getUserRole(uid);
    setState(() {
      role = fetchedRole ?? 'Unknown';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String fullname = user?.displayName ?? 'User';
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 600,
            height: 140,
            decoration: BoxDecoration(
              color: Color(0xFFF8964F),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  offset: Offset(3, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Inter',
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      _isLoading
                          ? CircularProgressIndicator()
                          : GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Container(
                                  width: 120,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.25),
                                        offset: Offset(3, 4),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(17),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          role,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.person,
                                            size: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (role == 'HRD') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileHRDPage()),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileKaryawanPage()),
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      fullname,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 400,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 40),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to the left
                children: [
                  Text(
                    "Schedule today",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: 300,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 40, // Adjust based on text height
                            child: Image.asset(
                              'assets/img/WhatsApp_Image_2024-05-16_at_19.45 1.png', // Replace with your local image path
                              width: 100,
                              height: 50,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Text(
                                'No schedule',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
          Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 20),
            child: Container(
              width: 430,
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Application features",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Commissioner',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MenuCard(
                            iconImagePath:
                                'assets/img/WhatsApp_Image_2024-05-16_at_22.18 2.png',
                            text: 'Attendance',
                            page: Scan(camera: _camera),
                          ),
                        ),
                        Expanded(
                          child: MenuCard(
                            iconImagePath:
                                'assets/img/WhatsApp_Image_2024-05-16_at_23.01 2.png',
                            text: 'Report',
                            page: createReport(),
                          ),
                        ),
                        Expanded(
                          child: MenuCard(
                            iconImagePath:
                                'assets/img/WhatsApp_Image_2024-05-16_at_22.03 2.png',
                            text: 'Holiday',
                            page: holidayReq(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MenuCard(
                          iconImagePath:
                              'assets/img/WhatsApp_Image_2024-05-16_at_21.44 2.png',
                          text: 'Instant Message',
                          page: Messages(),
                        ),
                      ),
                      Expanded(
                        child: MenuCard(
                          iconImagePath:
                              'assets/img/WhatsApp_Image_2024-05-16_at_21.59 2.png',
                          text: 'Contact',
                          page: Contact(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String iconImagePath;
  final String text;
  final Widget page;

  MenuCard({
    required this.iconImagePath,
    required this.text,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Image.asset(
                iconImagePath,
                width: 50.0,
                height: 50.0,
              ),
              SizedBox(height: 8.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
