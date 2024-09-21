import 'package:flutter/material.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cooming Soon'),
      ),
      // backgroundColor: myBackground,
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[900],
      // ),
      // body: Row(
      //   children: [
      //     myDrawer,
      //     Expanded(
      //       child: Container(
      //         color: Colors.white,
      //         child: const Center(
      //           child: Text('Desktop Scaffold'),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
