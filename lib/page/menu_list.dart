import 'package:flutter/material.dart';

import '../responsive/desktop_scaffold.dart';
import '../responsive/mobile_scaffold.dart';
import '../responsive/responsive_layour.dart';
import '../responsive/tablet_scaffold.dart';

class MenuList extends StatefulWidget {
  final String argument;

  const MenuList({super.key, required this.argument});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: MobileScaffold(typeList: widget.argument),
      tabletScaffold: TabletScaffold(typeList: widget.argument),
      desktopScaffold: DesktopScaffold(typeList: widget.argument),
    );
  }
}
