import 'package:flutter/material.dart';

class PhoneStatusPage extends StatefulWidget {
  final String deviceName;
  const PhoneStatusPage({super.key, required this.deviceName});

  @override
  State<PhoneStatusPage> createState() => _PhoneStatusPageState();
}

class _PhoneStatusPageState extends State<PhoneStatusPage> {
  // Simulated list of children with offline/online timestamps and states
  final List<Map<String, dynamic>> childrenStatus = [
    {
      'name': 'James\'s Phone',
      'offlineTime': DateTime.now().subtract(Duration(hours: 3, minutes: 15)),
      'offlineState': 'Offline',
      'onlineTime': DateTime.now().subtract(Duration(hours: 1, minutes: 5)),
      'onlineState': 'Online',
    },
    {
      'name': 'Sophia\'s Phone',
      'offlineTime': DateTime.now().subtract(Duration(hours: 5, minutes: 30)),
      'offlineState': 'Offline',
      'onlineTime': DateTime.now().subtract(Duration(hours: 2, minutes: 45)),
      'onlineState': 'Online',
    },
    {
      'name': 'Liam\'s Phone',
      'offlineTime': DateTime.now().subtract(Duration(days: 1, hours: 2)),
      'offlineState': 'Offline',
      'onlineTime': DateTime.now().subtract(Duration(days: 1)),
      'onlineState': 'Online',
    },
  ];

  String formatDateTime(DateTime dt) {
    return '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.deviceName} Status')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F6FF), Color(0xFFBBD7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          columnSpacing: 30,
          columns: const [
            DataColumn(
              label: Expanded(
                child: Text("Child's Name", textAlign: TextAlign.center),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text("Phone Went Offline", textAlign: TextAlign.center),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Phone Came Back Online",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          rows:
              childrenStatus.map((child) {
                bool isOnline = child['onlineState'].toLowerCase() == 'online';
                return DataRow(
                  cells: [
                    DataCell(Center(child: Text(child['name']))),
                    DataCell(
                      isOnline
                          ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(formatDateTime(child['offlineTime'])),
                              Text(
                                'Online',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          )
                          : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(formatDateTime(child['offlineTime'])),
                              Text(
                                child['offlineState'],
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                    ),
                    DataCell(
                      isOnline
                          ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(formatDateTime(child['onlineTime'])),
                              Text(
                                'Online',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          )
                          : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(formatDateTime(child['onlineTime'])),
                              Text(
                                child['onlineState'],
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
