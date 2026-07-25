import 'package:flutter/material.dart';
import 'dart:async';

import 'connect_to_parent_page.dart';
import 'child_settings_screen.dart';

class ChildDashboard extends StatefulWidget {
  const ChildDashboard({super.key});

  @override
  State<ChildDashboard> createState() => _ChildDashboardState();
}

class _ChildDashboardState extends State<ChildDashboard>
    with WidgetsBindingObserver {
  bool isLinked = false;
  bool locationSharing = true;
  String onlineStatus = 'Online';

  String currentLocation = 'Home';
  double distanceFromHome = 0.0;

  Timer? _locationUpdateTimer;

  Widget _buildDrawerTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: title == "Logout" ? Colors.red : Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context); // Close drawer first
        onTap();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startLocationSimulation();
  }

  void _startLocationSimulation() {
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        distanceFromHome = (distanceFromHome + 0.5) % 5.0;
        currentLocation = distanceFromHome < 2.5 ? 'Home' : 'School';
      });
    });
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      if (state == AppLifecycleState.paused) {
        onlineStatus = 'Offline';
        _sendStatusToParent(onlineStatus);
      } else if (state == AppLifecycleState.resumed) {
        onlineStatus = 'Online';
        _sendStatusToParent(onlineStatus);
      }
    });
  }

  void _sendStatusToParent(String status) {
    // TODO: Implement actual communication to parent device
    // For now, just print to console
    print('Child device status changed: $status');
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
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.phone_android, size: 48, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      "find my Kid's Phone",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Child Menu", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              _buildDrawerTile(
                context,
                Icons.group,
                "Connect to Parents",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ConnectToParentPage(),
                  ),
                ),
              ),
              _buildDrawerTile(context, Icons.message, "Messages", () {
                // TODO: Implement unread message count and navigation
                Navigator.pushNamed(context, '/messages');
              }),
              _buildDrawerTile(
                context,
                Icons.settings,
                "Settings",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChildSettingsScreen(),
                  ),
                ),
              ),
              _buildDrawerTile(
                context,
                Icons.logout,
                "Logout",
                () => Navigator.pushReplacementNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
                        ),
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'find my Kid\'s Phone',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Status: $onlineStatus',
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            onlineStatus == 'Online'
                                ? Colors.green
                                : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text("Connection to Parent"),
                        subtitle: Text(
                          isLinked ? "Connected" : "Not Connected",
                        ),
                        trailing:
                            isLinked
                                ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                                : const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.orange,
                                ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        title: const Text("Location Sharing"),
                        subtitle: Text(locationSharing ? "Active" : "Paused"),
                        trailing: Switch(
                          value: locationSharing,
                          onChanged: (value) {
                            setState(() {
                              locationSharing = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.place),
                        title: const Text("Current Location"),
                        subtitle: Text(
                          '$currentLocation – ${distanceFromHome.toStringAsFixed(1)} km from home',
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.sync),
                      label: const Text("Connect to Parent"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConnectToParentPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "This device is under parental monitoring for safety.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
