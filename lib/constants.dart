import 'package:flutter/material.dart';

const supabaseUrl = 'https://jtxaomopwwaluvrgtajd.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp0eGFvbW9wd3dhbHV2cmd0YWpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY5MDEwMDAsImV4cCI6MjA0MjQ3NzAwMH0.TbQ7pTFyMNDu2-TjSjZL73Ie8NyqMk2k0N00JJ-i3IM';

final titleMenu = [
  {'titleMenu': 'Semua', 'iconMenu': Icons.all_inclusive},
  {'titleMenu': 'Promo', 'iconMenu': Icons.local_offer},
  {'titleMenu': 'Makanan', 'iconMenu': Icons.fastfood},
  {'titleMenu': 'Minuman', 'iconMenu': Icons.local_drink_outlined},
  {'titleMenu': 'Snack', 'iconMenu': Icons.icecream},
  {'titleMenu': 'Dessert', 'iconMenu': Icons.cake},
  {'titleMenu': 'Lainnya', 'iconMenu': Icons.more_horiz},
];

final myBackground = Colors.grey[200];

final myAppbar = AppBar(
  backgroundColor: Colors.grey[900],
  leading: Builder(
    builder: (context) => IconButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    ),
  ),
);

final myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  child: Column(
    children: [
      const DrawerHeader(
        child: Text(
          'RestoMoe',
          style: TextStyle(fontSize: 24),
        ),
      ),
      ...titleMenu.map(
        (menu) => ListTile(
          title: Text(menu['titleMenu'].toString()),
          leading: Icon(menu['iconMenu'] as IconData),
        ),
      ),
    ],
  ),
);
