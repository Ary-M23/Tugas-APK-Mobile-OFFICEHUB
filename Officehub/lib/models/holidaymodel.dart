import 'package:cloud_firestore/cloud_firestore.dart';

class holiday {
  final String id;
  final String namaEmployee;
  final String date;
  final String alasan;
  final String guid;

  holiday({
    required this.id,
    required this.namaEmployee,
    required this.date,
    required this.alasan,
    required this.guid,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'namaEmployee': namaEmployee,
        'date': date,
        'alasan': alasan,
        'guid': guid,
      };
}
