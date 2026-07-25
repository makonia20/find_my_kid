import 'package:flutter/material.dart';
import 'dart:async';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> childDevices = [
    {
      'name': 'James\'s Phone',
      'status': 'Online',
      'location': 'School – 1.2 km',
      'phoneType': 'Android',
      'phoneModel': 'Pixel 6',
      'battery': 14,
      'isMoving': true,
      'findMeThreshold': 10,
      'findMeMode': false,
      'lastKnownLocation': 'Home',
      'distanceFromHome': 1.2,
    },
    {
      'name': 'Sophia\'s Phone',
      'status': 'Offline',
      'location': 'Last seen: Home – 3.4 km',
      'phoneType': 'iPhone',
      'phoneModel': 'iPhone 13',
      'battery': 50,
      'isMoving': false,
      'findMeThreshold': 10,
      'findMeMode': false,
      'lastKnownLocation': 'School',
      'distanceFromHome': 3.4,
    },
  ];

  Timer? _statusUpdateTimer;
  Timer? _locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _updateFindMeModes();
    _startStatusUpdates();
    _startLocationUpdates();

    // Listen for device info passed from scan_qr_code screen
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final deviceInfo = await Navigator.pushNamed(context, '/scan-qr-code');
      if (deviceInfo != null && deviceInfo is Map<String, dynamic>) {
        _addOrUpdateDevice(deviceInfo);
      }
    });
  }

  void _startStatusUpdates() {
    _statusUpdateTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        for (var device in childDevices) {
          // Toggle status for demonstration
          device['status'] =
              device['status'] == 'Online' ? 'Offline' : 'Online';
        }
      });
    });
  }

  void _startLocationUpdates() {
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        for (var device in childDevices) {
          // Simulate location change for demonstration
          device['distanceFromHome'] =
              (device['distanceFromHome'] + 0.5) % 5.0; // cycle 0 to 5 km
          device['location'] =
              'Last seen: ${device['lastKnownLocation']} – ${device['distanceFromHome'].toStringAsFixed(1)} km';
        }
      });
    });
  }

  @override
  void dispose() {
    _statusUpdateTimer?.cancel();
    _locationUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final deviceInfo =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (deviceInfo != null) {
      _addOrUpdateDevice(deviceInfo);
    }
  }

  Color getStatusColor(String status) {
    return status == 'Online' ? Colors.green : Colors.redAccent;
  }

  Color getBatteryColor(int battery) {
    if (battery > 50) {
      return Colors.green;
    } else if (battery > 20) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void _addOrUpdateDevice(Map<String, dynamic> newDevice) {
    setState(() {
      int index = childDevices.indexWhere(
        (device) => device['name'] == newDevice['name'],
      );
      if (index != -1) {
        // Update existing device info
        childDevices[index] = newDevice;
      } else {
        // Add new device
        childDevices.add(newDevice);
      }
      _updateFindMeModes();
    });
  }

  void _updateFindMeModes() {
    setState(() {
      for (var device in childDevices) {
        if (device['battery'] <= 15 &&
            device['battery'] >= device['findMeThreshold']) {
          device['findMeMode'] = true;
        } else {
          device['findMeMode'] = false;
        }
      }
    });
  }

  void _toggleFindMeMode(int index) {
    setState(() {
      childDevices[index]['findMeMode'] = !childDevices[index]['findMeMode'];
    });
  }

  void _updateFindMeThreshold(int index, double value) {
    setState(() {
      childDevices[index]['findMeThreshold'] = value.toInt();
      _updateFindMeModes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Removed the dashboard header name as requested
        // title: const Text('Dashboard'),
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
                    Text(
                      "Parent Menu",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              _buildDrawerTile(context, Icons.add, "Add Device", '/add-device'),
              _buildDrawerTile(context, Icons.map, "Map View", '/map-view'),
              _buildDrawerTile(
                context,
                Icons.notifications,
                "Alerts",
                '/alerts',
              ),
              _buildDrawerTile(
                context,
                Icons.settings,
                "Settings",
                '/settings',
              ),
              _buildDrawerTile(
                context,
                Icons.logout,
                "Logout",
                '/login',
                replace: true,
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: childDevices.length,
                  itemBuilder: (context, index) {
                    final device = childDevices[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.phone_android,
                          color: getStatusColor(device['status']),
                        ),
                        title: Text(
                          device['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${device['status']} - ${device['location']}',
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.location_on,
                                  color:
                                      device['distanceFromHome'] < 1.0
                                          ? Colors.green
                                          : Colors.orange,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  device['distanceFromHome'] < 1.0
                                      ? 'Nearby'
                                      : 'Far',
                                  style: TextStyle(
                                    color:
                                        device['distanceFromHome'] < 1.0
                                            ? Colors.green
                                            : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text('Phone Type: ${device['phoneType']}'),
                            Text('Phone Model: ${device['phoneModel']}'),
                            Row(
                              children: [
                                Text(
                                  'Battery: ${device['battery']}%',
                                  style: TextStyle(
                                    color: getBatteryColor(device['battery']),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  device['isMoving']
                                      ? Icons.directions_run
                                      : Icons.access_time,
                                  color:
                                      device['isMoving']
                                          ? Colors.green
                                          : Colors.grey,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Find Me Threshold: ${device['findMeThreshold']}%',
                                ),
                                Slider(
                                  value: device['findMeThreshold'].toDouble(),
                                  min: 5,
                                  max: 15,
                                  divisions: 10,
                                  label: device['findMeThreshold'].toString(),
                                  onChanged:
                                      (value) =>
                                          _updateFindMeThreshold(index, value),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Find Me Mode: ${device['findMeMode'] ? "ON" : "OFF"}',
                                ),
                                Switch(
                                  value: device['findMeMode'],
                                  onChanged:
                                      (value) => _toggleFindMeMode(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: TextButton(
                          onPressed:
                              () => Navigator.pushNamed(context, '/map-view'),
                          child: const Text("View Map"),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/add-device'),
        label: const Text('Add Child'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Widget _buildDrawerTile(
    BuildContext context,
    IconData icon,
    String title,
    String route, {
    bool replace = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: title == "Logout" ? Colors.red : Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context); // Close drawer first
        replace
            ? Navigator.pushReplacementNamed(context, route)
            : Navigator.pushNamed(context, route);
      },
    );
  }
}
