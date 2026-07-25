import 'package:flutter/material.dart';

class ChildSettingsScreen extends StatefulWidget {
  const ChildSettingsScreen({super.key});

  @override
  State<ChildSettingsScreen> createState() => _ChildSettingsScreenState();
}

class _ChildSettingsScreenState extends State<ChildSettingsScreen> {
  bool locationSharing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Settings'),
        backgroundColor: const Color(0xFFF2F6FF),
        foregroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.indigo),
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Location Sharing Toggle
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('Location Sharing'),
                subtitle: const Text('Allow parents to see your live location'),
                value: locationSharing,
                onChanged: (value) {
                  setState(() {
                    locationSharing = value;
                    // You can integrate backend sync here
                  });
                },
                secondary: const Icon(Icons.location_on),
              ),
            ),

            // Change Phone Number
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Change Phone Number'),
                subtitle: const Text('Update your registered number'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to phone number change screen
                },
              ),
            ),

            // Update PIN
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.pin),
                title: const Text('Update PIN'),
                subtitle: const Text('Change your connection PIN'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to PIN update screen
                },
              ),
            ),

            // Paired Parent Info
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Parent Info'),
                subtitle: const Text('View connected parent account'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to parent info screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
