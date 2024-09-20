import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_resto_menu/constants.dart';
import 'package:qr_resto_menu/widget/product_list.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  int productCount = 0;

  void updateProductCount(int count) {
    setState(() {
      log('Product count: $count');
      productCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      appBar: myAppbar,
      drawer: myDrawer,
      floatingActionButton: floatingActionButton(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: titleMenu
                      .map((menuName) => categoryMenu(
                          menuName: menuName['titleMenu'].toString()))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ProductList(
              onProductCountChanged: (p0) => updateProductCount(p0),
            ),
          ],
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

  Widget floatingActionButton() {
    return Badge(
      label: Text('$productCount'),
      // badgeContent: Text(
      //   _productCount.toString(),
      //   style: const TextStyle(color: Colors.white),
      // ),
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
