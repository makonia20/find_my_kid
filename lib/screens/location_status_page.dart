import 'package:flutter/material.dart';

class LocationStatusPage extends StatelessWidget {
  final String deviceName;
  const LocationStatusPage({super.key, required this.deviceName});

  // Dummy location data for demonstration
  final List<Map<String, String>> locationUpdates = const [
    {
      'childName': 'James',
      'timestamp': '2025-06-01 17:22',
      'location': '2.1 km from home',
      'mode': 'Walking',
    },
    {
      'childName': 'Sophia',
      'timestamp': '2025-06-01 15:30',
      'location': '1.8 km from home',
      'mode': 'Stationary',
    },
  ];

  Color _getModeColor(String mode) {
    switch (mode.toLowerCase()) {
      case 'walking':
        return Colors.green;
      case 'stationary':
        return Colors.orange;
      case 'driving':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Updates')),
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
          child: Column(
            children: [
              const Text(
                'Location Updates',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: DataTable(
                          columnSpacing: 30,
                          columns: const [
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  "Child's Name",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Timestamp',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Location',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Mode',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                          rows:
                              locationUpdates.map((update) {
                                final mode = update['mode'] ?? '';
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(child: Text(update['childName']!)),
                                    ),
                                    DataCell(
                                      Center(child: Text(update['timestamp']!)),
                                    ),
                                    DataCell(
                                      Center(child: Text(update['location']!)),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          mode,
                                          style: TextStyle(
                                            color: _getModeColor(mode),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
