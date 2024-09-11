import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/holidaymodel.dart';

class holidaycon {
  static Future<void> addToFirestore(
      BuildContext context, holiday holidaymodel) async {
    try {
      await FirebaseFirestore.instance
          .collection("holiday")
          .add(holidaymodel.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request sudah terkirim!')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Request gagal terkirim! Error: $error'), // Display the error message
        ),
      );
    }
  }
}
