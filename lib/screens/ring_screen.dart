import 'dart:async';

import 'package:flutter/material.dart';

class RingScreen extends StatefulWidget {
  const RingScreen({super.key});

  @override
  State<RingScreen> createState() => _RingScreenState();
}

class _RingScreenState extends State<RingScreen> {
  bool _isContinuousRinging = false;
  Timer? _ringTimer;

  void _startContinuousRing() {
    if (_isContinuousRinging) return;
    setState(() {
      _isContinuousRinging = true;
    });
    _showSnackBar("Continuous ringing started. It will ring until cancelled.");
    // Simulate continuous ringing by showing snackbar repeatedly every 10 seconds
    _ringTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!_isContinuousRinging) {
        timer.cancel();
      } else {
        _showSnackBar("Phone is ringing continuously...");
      }
    });
  }

  void _cancelContinuousRing() {
    if (!_isContinuousRinging) return;
    _ringTimer?.cancel();
    setState(() {
      _isContinuousRinging = false;
    });
    _showSnackBar("Continuous ringing cancelled.");
  }

  void _ringForDuration(int seconds) {
    _showSnackBar("Phone will ring for $seconds seconds.");
    // Simulate ringing for the duration by showing snackbar once
    // In real app, implement actual ringing logic here
    Timer(Duration(seconds: seconds), () {
      _showSnackBar("Ring for $seconds seconds ended.");
    });
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _ringTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringCommands = [
      {
        'title': 'Continuous Ring',
        'description':
            'Rings continuously until you cancel. Child cannot cancel this.',
        'action': _startContinuousRing,
        'showCancel': _isContinuousRinging,
      },
      {
        'title': 'Ring for 2 Minutes',
        'description': 'Rings for 2 minutes when you click ring.',
        'action': () => _ringForDuration(120),
        'showCancel': false,
      },
      {
        'title': 'Ring for 30 Seconds',
        'description': 'Rings for 30 seconds when you click ring.',
        'action': () => _ringForDuration(30),
        'showCancel': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ring Commands'),
        actions: [
          if (_isContinuousRinging)
            TextButton(
              onPressed: _cancelContinuousRing,
              child: const Text(
                'Cancel',
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
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: ringCommands.length,
          itemBuilder: (context, index) {
            final command = ringCommands[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      command['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      command['description'] as String,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: command['action'] as void Function()?,
                          child: const Text('Ring'),
                        ),
                        if (command['showCancel'] == true)
                          const SizedBox(width: 12),
                        if (command['showCancel'] == true)
                          OutlinedButton(
                            onPressed: _cancelContinuousRing,
                            child: const Text('Cancel'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
