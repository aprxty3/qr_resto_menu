import 'package:flutter/material.dart';
import 'package:qr_resto_menu/responsive/desktop_scaffold.dart';
import 'package:qr_resto_menu/responsive/mobile_scaffold.dart';
import 'package:qr_resto_menu/responsive/responsive_layour.dart';
import 'package:qr_resto_menu/responsive/tablet_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: AA(),
      home: ResponsiveLayout(
        mobileScaffold: MobileScaffold(),
        tabletScaffold: TabletScaffold(),
        desktopScaffold: DesktopScaffold(),
      ),
    );
  }
}

class AA extends StatefulWidget {
  const AA({super.key});

  @override
  State<AA> createState() => _AAState();
}

class _AAState extends State<AA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(),
    );
  }
}
