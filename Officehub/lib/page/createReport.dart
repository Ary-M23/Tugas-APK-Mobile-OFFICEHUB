import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Officehub/controllers/reportcon.dart';

import '../models/reportmodel.dart';
import 'home.dart';

class createReport extends StatefulWidget {
  const createReport({Key? key}) : super(key: key);

  @override
  State<createReport> createState() => _createReport();
}

class _createReport extends State<createReport> {
  Random random = Random();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _reportalasan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Color(0xFFF8964F), // Set the background color
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Employee name',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
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
              controller: _nama,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              'Reason',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
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
                controller: _reportalasan,
                decoration: const InputDecoration(
                  labelText: 'Enter your report reason',
                  border: UnderlineInputBorder(),
                )),
            SizedBox(
              height: 70,
            ),
            Center(
              child: SizedBox(
                width: 200, // Set your desired width
                height: 50, // Set your desired height
                child: ElevatedButton(
                  onPressed: () {
                    int randomNumber = random.nextInt(101);
                    Future.delayed(Duration.zero, () {
                      report _report = report(
                        id: randomNumber.toString(),
                        namaEmployee: _nama.text,
                        reportalasan: _reportalasan.text,
                        guid: FirebaseAuth.instance.currentUser!.uid,
                      );
                      reportcon.addToFirestore(context, _report);
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400], // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(19), // Reduced corner radius
                    ),
                  ),
                  child: Text(
                    'Submit',
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
