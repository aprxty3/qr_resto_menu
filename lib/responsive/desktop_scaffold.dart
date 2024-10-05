import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../menu_state.dart';
import '../model/menu_items.dart';
import '../widget/product_card.dart';
import '../widget/product_list.dart';

class DesktopScaffold extends StatefulWidget {
  final String typeList;

  const DesktopScaffold({super.key, required this.typeList});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
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
            appBar: AppBar(backgroundColor: Colors.grey[900]),
            floatingActionButton: floatingActionButton(menuState, context),
            body: Row(
              children: [
                myDrawer(context,
                    (menuType) => _onMenuSelected(menuType, items?.data)),
                Expanded(
                  child: widget.typeList == 'image'
                      ? ProductCard(
                          onProductCountChanged: menuState.updateProductCount,
                          items: filteredItems ?? items?.data ?? [],
                        )
                      : ProductList(
                          onProductCountChanged: menuState.updateProductCount,
                          items: filteredItems ?? items?.data ?? [],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
