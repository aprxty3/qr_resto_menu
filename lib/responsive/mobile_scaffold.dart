import 'package:flutter/material.dart';
import 'package:qr_resto_menu/constants.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      appBar: myAppbar,
      drawer: myDrawer,
    );
  }
}
