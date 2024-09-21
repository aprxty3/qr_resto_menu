import 'package:flutter/material.dart';
import 'package:qr_resto_menu/constants.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
      ),
      body: Row(
        children: [
          myDrawer,
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text('Desktop Scaffold'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
