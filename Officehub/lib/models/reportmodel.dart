import 'package:cloud_firestore/cloud_firestore.dart';

class report {
  final String id;
  final String namaEmployee;
  final String reportalasan;
  final String guid;

  report({
    required this.id,
    required this.namaEmployee,
    required this.reportalasan,
    required this.guid,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'namaEmployee': namaEmployee,
        'reportalasan': reportalasan,
        'guid': guid,
      };
}
