import 'package:flutter/material.dart';

class ScanPinScreen extends StatefulWidget {
  const ScanPinScreen({super.key});

  @override
  State<ScanPinScreen> createState() => _ScanPinScreenState();
}

class _ScanPinScreenState extends State<ScanPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  String statusMessage = '';

  void verifyPin(String enteredPin) {
    // Simulate checking the pin (replace with real check in production)
    const exampleValidPin = '1234'; // For testing
    setState(() {
      if (enteredPin == exampleValidPin) {
        statusMessage = '✅ Successfully linked to parent!';

        // Simulate device info for demonstration
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

        // Pass device info back to previous screen
        Navigator.pop(context, deviceInfo);
      } else {
        statusMessage = '❌ Invalid PIN. Please try again.';
      }
    });

    // You can now trigger actual backend/API logic here
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
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: const Color(0xFFF2F6FF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter PIN from Parent',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.indigo, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _pinController.text.length > index
                                ? _pinController.text[index]
                                : '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      width: 240,
                      height: 50,
                      child: TextField(
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        style: const TextStyle(color: Colors.transparent),
                        cursorColor: Colors.indigo,
                        onChanged: (value) {
                          if (value.length > 4) {
                            _pinController.text = value.substring(0, 4);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => verifyPin(_pinController.text),
                  icon: const Icon(Icons.link),
                  label: const Text('Link to Parent'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  statusMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        statusMessage.contains('✅') ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
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
