import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/scanmodel.dart';

class ScanCon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  static Future<void> addToFirestore(
      BuildContext context, scan_model scan) async {
    try {
      await FirebaseFirestore.instance.collection("Absen").add(scan.toMap());
      // Show success message or navigate to another screen

      Navigator.pop(context);
    } catch (error) {
      print(error); // Assuming this is in a new screen
    }
  }
}
