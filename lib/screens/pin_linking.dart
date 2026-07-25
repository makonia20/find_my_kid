import 'dart:math';
import 'package:flutter/material.dart';

class PinLinkingScreen extends StatefulWidget {
  const PinLinkingScreen({super.key});

  @override
  State<PinLinkingScreen> createState() => _PinLinkingScreenState();
}

class _PinLinkingScreenState extends State<PinLinkingScreen> {
  String generatedPin = '';

  void generatePin() {
    final rand = Random();
    final pin = rand.nextInt(9000) + 1000; // ensures a 4-digit number
    setState(() {
      generatedPin = pin.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    generatePin();
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Your Linking PIN:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      generatedPin,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: generatePin,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Generate New PIN'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Give this PIN to your child to scan and link their device.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
