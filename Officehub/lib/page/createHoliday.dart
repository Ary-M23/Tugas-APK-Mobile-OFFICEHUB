import 'package:flutter/material.dart';
import 'package:Officehub/controllers/holidaycon.dart';
import 'package:Officehub/models/holidaymodel.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

class createHoliday extends StatefulWidget {
  const createHoliday({Key? key}) : super(key: key);

  @override
  State<createHoliday> createState() => _createHoliday();
}

class _createHoliday extends State<createHoliday> {
  Random random = Random();
  DateTime selectedDate = DateTime.now();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _tanggal = TextEditingController();
  final TextEditingController _alasan = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day,
            selectedDate.hour, selectedDate.minute, selectedDate.second);
        _tanggal.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Holiday Request',
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
              height: 15,
            ),
            Text(
              'Date',
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
            TextFormField(
              controller: _tanggal,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Date',
                labelStyle: TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              style: TextStyle(color: Colors.black),
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
                controller: _alasan,
                decoration: const InputDecoration(
                  labelText: 'Enter your reason',
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
                      holiday _holiday = holiday(
                        id: randomNumber.toString(),
                        namaEmployee: _nama.text,
                        date: selectedDate.toString(),
                        alasan: _alasan.text,
                        guid: FirebaseAuth.instance.currentUser!.uid,
                      );
                      holidaycon.addToFirestore(context, _holiday);
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
