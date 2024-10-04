import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_resto_menu/constants.dart';
import 'package:qr_resto_menu/widget/product_card.dart';
import 'package:qr_resto_menu/widget/product_list.dart';

import '../menu_state.dart';
import '../model/menu_items.dart';
import '../widget/parent_title_menu.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  List<MenuItem>? filteredItems;

  @override
  void initState() {
    super.initState();
    Provider.of<MenuState>(context, listen: false).loadMenuItems();
  }

  void _onMenuSelected(String menuType, List<MenuItem>? items) {
    setState(() {
      filteredItems = menuType != 'Semua'
          ? items
              ?.where((element) => element.type == menuType.toLowerCase())
              .toList()
          : items;
    });
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
            floatingActionButton: floatingActionButton(menuState, context),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  ParentTitleMenu(
                    onMenuSelected: (menuType) =>
                        _onMenuSelected(menuType, items?.data),
                  ),
                  const SizedBox(height: 16),
                  items?.areHavePicture == false
                      ? ProductCard(
                          onProductCountChanged: menuState.updateProductCount,
                          items: filteredItems ?? items?.data ?? [],
                        )
                      : ProductList(
                          onProductCountChanged: menuState.updateProductCount,
                          items: filteredItems ?? items?.data ?? [],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
