import 'package:flutter/material.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool _isLocked = false;

  void _lockPhone() {
    if (_isLocked) return;
    setState(() {
      _isLocked = true;
    });
    _showSnackBar("Child's phone is now locked.");
    // Implement actual lock logic here
  }

  void _unlockPhone() {
    if (!_isLocked) return;
    setState(() {
      _isLocked = false;
    });
    _showSnackBar("Child's phone is now unlocked.");
    // Implement actual unlock logic here
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lock Child Phone'),
        actions: [
          if (_isLocked)
            TextButton(
              onPressed: _unlockPhone,
              child: const Text(
                'Unlock',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ElevatedButton(
            onPressed: _isLocked ? null : _lockPhone,
            child: Text(_isLocked ? 'Phone Locked' : 'Lock Child Phone'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
