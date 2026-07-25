import 'package:flutter/material.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _deviceIdController = TextEditingController();

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final deviceId = _deviceIdController.text.trim();

      // Create device info map with minimal info
      Map<String, dynamic> deviceInfo = {
        'name': 'Child Device',
        'status': 'Offline',
        'location': 'Unknown',
        'phoneType': 'Unknown',
        'phoneModel': 'Unknown',
        'battery': 100,
        'isMoving': false,
        'findMeThreshold': 10,
        'findMeMode': false,
        'phoneNumber': deviceId,
      };

      // Pass device info back to connect_to_parent_page.dart
      Navigator.pop(context, deviceInfo);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Request sent to parent')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Child Device')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 12),
                TextFormField(
                  controller: _deviceIdController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.send),
                  label: const Text('Send Request'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                    minimumSize: Size(
                      0,
                      0,
                    ), // Remove default min width to fit text
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // Shrink tap target
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/qr_code_linking');
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
                          Navigator.pushNamed(context, '/pin_linking');
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
      ),
    );
  }
}
