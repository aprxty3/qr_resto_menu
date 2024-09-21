import 'package:flutter/material.dart';

import '../constants.dart';

class ParentTitleMenu extends StatefulWidget {
  const ParentTitleMenu({super.key});

  @override
  State<ParentTitleMenu> createState() => _ParentTitleMenuState();
}

class _ParentTitleMenuState extends State<ParentTitleMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: titleMenu
              .map((menuName) =>
                  categoryMenu(menuName: menuName['titleMenu'].toString()))
              .toList(),
        ),
      ),
    );
  }

  Widget categoryMenu({required String menuName}) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[600],
      ),
      child: Center(
        child: Text(
          menuName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
