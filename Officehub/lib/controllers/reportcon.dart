import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Officehub/models/reportmodel.dart';
import '../models/holidaymodel.dart';

class reportcon {
  static Future<void> addToFirestore(
      BuildContext context, report reportmodel) async {
    try {
      await FirebaseFirestore.instance
          .collection("report")
          .add(reportmodel.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report sudah terkirim!')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Report gagal terkirim! Error: $error'), // Display the error message
        ),
      );
    }
  }
}
