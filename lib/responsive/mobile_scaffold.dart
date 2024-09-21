import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_resto_menu/constants.dart';
import 'package:qr_resto_menu/main.dart';
import 'package:qr_resto_menu/model/menu_items.dart';
import 'package:qr_resto_menu/widget/product_list.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  int productCount = 0;
  var _menuItems = MenuItems();

  void updateProductCount(int count) {
    setState(() {
      log('Product count: $count');
      productCount = count;
    });
  }

  Future<void> loadMenuItems({String? menuType}) async {
    final data = await supabase.from('menu_items').select();

    bool areHavePicture =
        data.any((item) => item['imgurl'] != null && item['imgurl'].isNotEmpty);

    MenuItems menuItems = MenuItems(
      result: Result(
        areHavePicture: areHavePicture,
        data: List<Menu>.from(data.map((item) => Menu.fromJson(item))),
      ),
    );

    _menuItems = menuItems;

    log('MenuItems: ${_menuItems.result?.toJson()}');
  }

  @override
  void initState() {
    super.initState();
    loadMenuItems();
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
            // if (_menuItems.result?.areHavePicture == true)
            //   Container()
            // else
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
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
