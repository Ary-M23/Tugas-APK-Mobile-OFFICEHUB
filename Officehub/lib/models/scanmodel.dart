class scan_model {
  final String uid;
  final String absen;
  final String nama;

  scan_model({
    required this.uid,
    required this.absen,
    required this.nama,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'absen': absen,
        'nama': nama,
      };
}
