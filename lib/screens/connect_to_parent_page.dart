import 'package:flutter/material.dart';

class ConnectToParentPage extends StatefulWidget {
  const ConnectToParentPage({super.key});

  @override
  State<ConnectToParentPage> createState() => _ConnectToParentPageState();
}

class _ConnectToParentPageState extends State<ConnectToParentPage> {
  Map<String, dynamic>? addedDevice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connect to Parent")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "You have a linking request from parent.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Accept request directly and show success message
                  setState(() {
                    addedDevice = {
                      'name': 'Child Device',
                      'phoneNumber': 'Unknown',
                    };
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Request accepted successfully'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
                child: const Text("Accept Request"),
              ),
              const SizedBox(height: 20),
              if (addedDevice != null) ...[
                Text(
                  'Added Device: \${addedDevice!["name"]}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Phone Number: \${addedDevice!["phoneNumber"]}'),
                const SizedBox(height: 20),
              ],
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to QR code scanning screen
                        Navigator.pushNamed(context, '/scan_qr_code');
                      },
                      icon: const Icon(Icons.qr_code),
                      label: const Text('Add with QR Code'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to PIN linking screen
                        Navigator.pushNamed(context, '/pin_entry');
                      },
                      icon: const Icon(Icons.pin),
                      label: const Text('Add with Pin'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
