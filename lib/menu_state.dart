import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_resto_menu/product_add.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'model/menu_items.dart';

class MenuState extends ChangeNotifier {
  final SupabaseClient _supabaseClient;

  MenuState(this._supabaseClient);

  int productCount = 0;
  MenuItems _menuItems = MenuItems();

  Map<int, int> productCountList = {};

  MenuItems get menuItems => _menuItems;

  Future<void> loadMenuItems({String? menuType}) async {
    final data = await _supabaseClient.from('menu_items').select();

    bool areHavePicture =
        data.any((item) => item['imgurl'] != null && item['imgurl'].isNotEmpty);

    List<MenuItem> menuItemsList =
        List<MenuItem>.from(data.map((item) => MenuItem.fromJson(item)));

    const categoryOrder = [
      'promo',
      'makanan',
      'minuman',
      'snack',
      'dessert',
      'lainnya'
    ];

    menuItemsList.sort((a, b) {
      int indexA = categoryOrder.indexOf(a.type.toLowerCase());
      int indexB = categoryOrder.indexOf(b.type.toLowerCase());
      return indexA.compareTo(indexB);
    });

    MenuItems menuItems = MenuItems(
      result: Result(
        areHavePicture: areHavePicture,
        data: menuItemsList,
      ),
    );

    _menuItems = menuItems;

    notifyListeners();
  }

  void updateProduct(int productId, int increment) {
    if (productCountList.containsKey(productId)) {
      productCountList[productId] = (productCountList[productId]! + increment)
          .clamp(0, double.infinity)
          .toInt();
      if (productCountList[productId] == 0) {
        productCountList.remove(productId);
      }
    } else if (increment > 0) {
      productCountList[productId] = 1;
    }

    productCount = productCountList.values.fold(0, (a, b) => a + b);
    notifyListeners();
  }

  void clearProductCount(BuildContext context) {
    Provider.of<ProductAdd>(context, listen: false).clearTotals();
    productCountList.clear();
    productCount = 0;
    notifyListeners();
  }

  void updateProductCount(int count) {
    productCount = count;
    log('Product count: $count');
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    productCountList.forEach((productId, count) {
      final item = _menuItems.result?.data.firstWhere(
          (element) => element.id == productId,
          orElse: () =>
              MenuItem(id: 0, name: '', price: 0, imgurl: '', type: ''));
      if (item != null) {
        total += item.price * count;
      }
    });
    return total;
  }
}
