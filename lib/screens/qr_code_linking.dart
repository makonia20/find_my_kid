import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeLinking extends StatelessWidget {
  final String parentId = "parent_ABC123"; // Replace with dynamic ID if needed

  const QRCodeLinking({super.key});

  @override
  Widget build(BuildContext context) {
    String qrData = "link-device:\$parentId";

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
        backgroundColor: const Color(0xFFF2F6FF),
        foregroundColor: Colors.indigo,
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Scan this QR code with your child\'s phone to link it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.indigo),
                ),
                const SizedBox(height: 30),
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 240.0,
                ),
                const SizedBox(height: 30),
                Text(
                  'Parent ID: \$parentId',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
