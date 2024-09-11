import 'package:flutter/material.dart';

class start extends StatelessWidget {
  const start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset(
                'assets/img/—Pngtree—2 1.png', // Ganti dengan path gambar baru
              ),
            ),
          ],
        ),
      ),
    );
  }
}
