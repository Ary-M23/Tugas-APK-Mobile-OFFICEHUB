import 'package:flutter/material.dart';
import 'package:Officehub/page/login.dart';
import 'package:Officehub/page/signup.dart';

class landing_page extends StatelessWidget {
  const landing_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding:
          const EdgeInsets.only(top: 120.0, bottom: 60, left: 80, right: 80),
      child: Container(
        width: 400,
        child: Column(
          children: [
            Text(
              "OfficeHub",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'K2D',
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4), // x offset 0, y offset 4
                    blurRadius: 4, // blur radius 4
                    color: Color.fromRGBO(
                        0, 0, 0, 0.25), // warna hitam dengan opasitas 25%
                  ),
                ],
              ),
            ),
            Text(
              "Sign in or create a new account",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4), // x offset 0, y offset 4
                    blurRadius: 4, // blur radius 4
                    color: Color.fromRGBO(
                        0, 0, 0, 0.25), // warna hitam dengan opasitas 25%
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                width: 250,
                height: 250,
                child: Image.asset(
                  'assets/img/—Pngtree—2 1.png', // Ganti dengan path gambar baru
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFF8964F), // background (button) color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // radius 20 px
                    ),
                    shadowColor: Colors.black.withOpacity(0.25), // Shadow color
                    elevation: 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Go to Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Commissioner',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25), // Shadow color
                      offset: Offset(0, 4), // Offset
                      blurRadius: 4, // Blur radius
                      spreadRadius: 0, // Spread radius
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: SizedBox(
                  width: 300, // Set the desired width here
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // background (button) color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // radius 20 px
                      ),
                      elevation: 0, // No default elevation
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 15, top: 15),
                      child: Row(
                        children: [
                          Text(
                            'No Account yet?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            ' Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFFF8964F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
