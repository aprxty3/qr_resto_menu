import 'package:flutter/material.dart';

var myBackground = Colors.grey[200];

var myAppbar = AppBar(
  backgroundColor: Colors.grey[900],
  leading: Builder(
    builder: (context) => IconButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: const Icon(
        Icons.south_america_rounded,
        color: Colors.white,
      ),
    ),
  ),
);

var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  child: const Column(
    children: [
      DrawerHeader(child: Icon(Icons.headphones)),
      ListTile(
        title: Text('Home'),
        leading: Icon(Icons.home),
      ),
      ListTile(
        title: Text('About'),
        leading: Icon(Icons.info),
      ),
      ListTile(
        title: Text('Contact'),
        leading: Icon(Icons.contact_mail),
      ),
      ListTile(
        title: Text('Exit'),
        leading: Icon(Icons.exit_to_app),
      )
    ],
  ),
);
