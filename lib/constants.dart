import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu_state.dart';
import 'model/menu_items.dart';

const supabaseUrl = 'https://jtxaomopwwaluvrgtajd.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp0eGFvbW9wd3dhbHV2cmd0YWpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY5MDEwMDAsImV4cCI6MjA0MjQ3NzAwMH0.TbQ7pTFyMNDu2-TjSjZL73Ie8NyqMk2k0N00JJ-i3IM';

final titleMenu = [
  {'titleMenu': 'Semua', 'iconMenu': Icons.all_inclusive},
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

Widget floatingActionButton(MenuState menuState, BuildContext context) {
  TextEditingController nameController = TextEditingController();
  TextEditingController tableController = TextEditingController();

  Future<void> sendToWhatsApp() async {
    final name = nameController.text;
    final table = tableController.text;
    final productList = menuState.productCountList.entries.map((entry) {
      final item = menuState.menuItems.result?.data.firstWhere(
        (element) => element.id == entry.key,
        orElse: () => MenuItem(id: 0, name: '', price: 0, imgurl: '', type: ''),
      );
      return '${item?.name ?? ''} x${entry.value}';
    }).join('\n');

    final message =
        'Nama Pemesan: $name\nNomor Meja: $table\nPesanan: $productList\nTotal: Rp ${menuState.totalPrice}';
    final whatsappUrl =
        'https://wa.me/6285156454374?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  return Badge(
    label: Text('${menuState.productCount}'),
    child: FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            log('data ${menuState.productCountList}');
            return Dialog(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Keranjang Belanja'),
                      trailing: Icon(Icons.shopping_cart),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nama Pemesan',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: TextField(
                              controller: tableController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nomor Meja',
                              ),
                            ),
                          ),
                          ...menuState.productCountList.entries.map(
                            (entry) {
                              final item = menuState.menuItems.result?.data
                                  .firstWhere(
                                      (element) => element.id == entry.key,
                                      orElse: () => MenuItem(
                                          id: 0,
                                          name: '',
                                          price: 0,
                                          imgurl: '',
                                          type: ''));
                              return ListTile(
                                title: Text(item?.name ?? ''),
                                subtitle: Text('Rp ${item?.price}'),
                                trailing: Text('x${entry.value}'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text('Total'),
                      trailing: Text('Rp ${menuState.totalPrice}'),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendToWhatsApp();
                        menuState.clearProductCount(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Beli',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.shopping_cart),
    ),
  );
}
