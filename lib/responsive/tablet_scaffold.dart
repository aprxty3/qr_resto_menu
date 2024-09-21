import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_resto_menu/constants.dart';
import 'package:qr_resto_menu/widget/product_card.dart';
import 'package:qr_resto_menu/widget/product_list.dart';

import '../menu_state.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  void initState() {
    super.initState();
    Provider.of<MenuState>(context, listen: false).loadMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuState>(
      builder: (context, menuState, child) {
        final items = menuState.menuItems.result;

        return Visibility(
          visible: items != null,
          replacement: const Center(child: CircularProgressIndicator()),
          child: Scaffold(
            backgroundColor: myBackground,
            appBar: myAppbar,
            drawer: myDrawer,
            floatingActionButton: floatingActionButton(menuState),
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
                  if (items?.areHavePicture == true)
                    ProductCard(
                      onProductCountChanged: menuState.updateProductCount,
                    )
                  else
                    ProductList(
                      onProductCountChanged: menuState.updateProductCount,
                    ),
                ],
              ),
            ),
          ),
        );
      },
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
