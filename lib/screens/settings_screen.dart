import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Notification Toggle
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: const Text(
                  'Get alerts about location or device status',
                ),
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
                secondary: const Icon(Icons.notifications),
              ),
            ),

            // Linked Devices
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.devices),
                title: const Text('Manage Linked Devices'),
                subtitle: const Text('Add or remove child phones'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to device management page
                },
              ),
            ),

            // Parental PIN
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Set Parental PIN'),
                subtitle: const Text('Protect access to sensitive features'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to parental pin screen
                },
              ),
            ),

            // Dark Mode
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Reduce eye strain in low light'),
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                    // Add logic to toggle app theme if needed
                  });
                },
                secondary: const Icon(Icons.dark_mode),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
