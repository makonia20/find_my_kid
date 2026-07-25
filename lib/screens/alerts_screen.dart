import 'package:flutter/material.dart';
import 'phone_status_page.dart';
import 'location_status_page.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  // Dummy event data
  final List<Map<String, String>> alerts = const [
    {
      'event': 'Phone went offline',
      'timestamp': '2025-06-01 18:45',
      'deviceName': 'James\'s Phone',
    },
    {
      'event': 'Phone moved to new location',
      'timestamp': '2025-06-01 17:22',
      'deviceName': 'Sophia\'s Phone',
    },
    {
      'event': 'Phone came back online',
      'timestamp': '2025-06-01 16:05',
      'deviceName': 'James\'s Phone',
    },
    {
      'event': 'Location updated',
      'timestamp': '2025-06-01 15:30',
      'deviceName': 'Sophia\'s Phone',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.notifications,
                  color: Colors.redAccent,
                ),
                title: Text(
                  alert['event']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Time: ${alert['timestamp']}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  final eventLower = alert['event']!.toLowerCase();
                  if (eventLower.contains('offline') ||
                      eventLower.contains('online')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PhoneStatusPage(
                              deviceName:
                                  alert['deviceName'] ?? 'Unknown Device',
                            ),
                      ),
                    );
                  } else if (eventLower.contains('moved to new location') ||
                      eventLower.contains('location updated')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => LocationStatusPage(
                              deviceName:
                                  alert['deviceName'] ?? 'Unknown Device',
                            ),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
