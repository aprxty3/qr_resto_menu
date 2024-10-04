import 'package:flutter/material.dart';

import '../responsive/desktop_scaffold.dart';
import '../responsive/mobile_scaffold.dart';
import '../responsive/responsive_layour.dart';
import '../responsive/tablet_scaffold.dart';

class MenuListImage extends StatefulWidget {
  final String argument;

  const MenuListImage({super.key, required this.argument});

  @override
  State<MenuListImage> createState() => _MenuListImageState();
}

class _MenuListImageState extends State<MenuListImage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: MobileScaffold(
        typeList: widget.argument,
      ),
      tabletScaffold: TabletScaffold(
        typeList: widget.argument,
      ),
      desktopScaffold: const DesktopScaffold(),
    );
  }
}
