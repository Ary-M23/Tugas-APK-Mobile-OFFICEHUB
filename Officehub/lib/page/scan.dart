import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:Officehub/controllers/scan_controller.dart';
import 'package:Officehub/models/scanmodel.dart';
import 'package:Officehub/page/home.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  final CameraDescription camera;

  const Scan({Key? key, required this.camera}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<Scan> {
  late QRViewController qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController jawabController = TextEditingController();
  Barcode? result;
  bool scanned = false; // Flag to track whether QR code is scanned or not

  @override
  void reassemble() {
    super.reassemble();
    if (mounted) {
      qrController.pauseCamera();
      qrController.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          title: const Text(
            'Scan Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 25,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Center(
                      child: Text('Data: ${result!.code}'),
                    )
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!scanned) {
        // Check if QR code is not scanned already
        setState(() {
          scanned = true; // Set scanned flag to true
          result = scanData;
        });
        Future.delayed(Duration.zero, () async {
          scan_model _report = scan_model(
            uid: FirebaseAuth.instance.currentUser!.uid,
            absen: "Hadir",
            nama: FirebaseAuth.instance.currentUser?.displayName ?? 'User',
          );
          await ScanCon.addToFirestore(context, _report);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Absen berhasil!')));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }
}
