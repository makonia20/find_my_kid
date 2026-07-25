// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required.')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    controller!.scannedDataStream.listen((scanData) {
      if (scannedData == null) {
        setState(() {
          scannedData = scanData.code;
        });
        controller!.pauseCamera();

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Linked to: \$scannedData')));

        // Simulate device info from scannedData for demonstration
        Map<String, dynamic> deviceInfo = {
          'name': 'Sophia\'s Phone',
          'status': 'Offline',
          'location': 'Last seen: Home – 3.4 km',
          'phoneType': 'iPhone',
          'phoneModel': 'iPhone 13',
          'battery': 50,
          'isMoving': false,
          'findMeThreshold': 10,
          'findMeMode': false,
        };

        // Pass deviceInfo back to previous screen
        Navigator.pop(context, deviceInfo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
        backgroundColor: const Color(0xFFF2F6FF),
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.indigo,
                  borderRadius: 12,
                  borderLength: 20,
                  borderWidth: 8,
                  cutOutSize: 260,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child:
                    scannedData == null
                        ? const Text(
                          'Scan a QR code to link device',
                          style: TextStyle(color: Colors.indigo),
                        )
                        : Text(
                          'Linked: \$scannedData',
                          style: const TextStyle(color: Colors.indigo),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
