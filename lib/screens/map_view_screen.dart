// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late GoogleMapController mapController;

  final LatLng _childLocation = const LatLng(
    37.7749,
    -122.4194,
  ); // Example: San Francisco
  String _lastSeen = "Just now";
  bool _autoUpdate = true;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _refreshLocation() {
    setState(() {
      _lastSeen = "Updated at ${TimeOfDay.now().format(context)}";
      // Here you’d fetch new coordinates and update _childLocation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshLocation,
            tooltip: "Refresh Location",
          ),
        ],
      ),
      body: Column(
        children: [
          // Map View
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _childLocation,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('childPhone'),
                  position: _childLocation,
                  infoWindow: const InfoWindow(title: 'Child’s Phone'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                ),
              },
            ),
          ),

          // Info + Actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 5),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // Last Seen Timestamp
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Last seen: $_lastSeen",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Auto-update"),
                        Switch(
                          value: _autoUpdate,
                          onChanged: (val) {
                            setState(() {
                              _autoUpdate = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _actionButton(
                      icon: Icons.volume_up,
                      label: 'Ring',
                      onTap: () {
                        Navigator.pushNamed(context, '/ring');
                      },
                    ),
                    _actionButton(
                      icon: Icons.lock,
                      label: 'Lock',
                      onTap: () {
                        Navigator.pushNamed(context, '/lock');
                      },
                    ),
                    _actionButton(
                      icon: Icons.message,
                      label: 'Message',
                      onTap: () {
                        Navigator.pushNamed(context, '/messages');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade100,
            child: Icon(icon, size: 28, color: Colors.blue.shade800),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showAction(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
