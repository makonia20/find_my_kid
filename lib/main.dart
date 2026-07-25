import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_device_screen.dart';
import 'screens/map_view_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/child_dashboard.dart';
import 'screens/connect_to_parent_page.dart';
import 'screens/qr_code_linking.dart';
import 'screens/scan_qr_code.dart';
import 'screens/pin_linking.dart';
import 'screens/scan_pin.dart';
import 'screens/ring_screen.dart';
import 'screens/lock_screen.dart';
import 'screens/messages_screen.dart';

void main() {
  runApp(const FindMyKidApp());
}

class FindMyKidApp extends StatelessWidget {
  const FindMyKidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find My Kid',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/child-dashboard': (context) => const ChildDashboard(),
        '/connect-to-parent': (context) => const ConnectToParentPage(),
        '/add-device': (context) => const AddDeviceScreen(),
        '/map-view': (context) => const MapViewScreen(),
        '/alerts': (context) => const AlertsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/qr_code_linking': (context) => const QRCodeLinking(),
        '/scan_qr_code': (context) => const ScanQRCode(),
        '/pin_linking': (context) => const PinLinkingScreen(),
        '/pin_entry': (context) => const ScanPinScreen(),
        '/ring': (context) => const RingScreen(),
        '/lock': (context) => const LockScreen(),
        '/messages': (context) => const MessagesScreen(),
      },
    );
  }
}
