import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_resto_menu/model/menu_items.dart';
import 'package:qr_resto_menu/product_add.dart';

import '../menu_state.dart';

class ProductCard extends StatefulWidget {
  final List<MenuItem> items;
  final Function(int) onProductCountChanged;

  const ProductCard(
      {super.key, required this.onProductCountChanged, required this.items});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 2;
    if (MediaQuery.of(context).size.width < 600) {
      crossAxisCount = 2;
    } else if (MediaQuery.of(context).size.width < 800) {
      crossAxisCount = 3;
    } else if (MediaQuery.of(context).size.width < 1200) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 5;
    }

    return ChangeNotifierProvider(
      create: (_) => ProductAdd(),
      child: Consumer<ProductAdd>(
        builder: (context, productCount, child) {
          return Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: widget.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .11,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(item.imgurl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item.price.toString()),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Provider.of<MenuState>(context,
                                                      listen: false)
                                                  .updateProduct(item.id, -1);
                                              productCount
                                                  .decrementTotal(item.id);
                                              widget.onProductCountChanged(
                                                  productCount.getTotalCount());
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(productCount
                                              .getTotalForProduct(item.id)
                                              .toString()),
                                          IconButton(
                                            onPressed: () {
                                              Provider.of<MenuState>(context,
                                                      listen: false)
                                                  .updateProduct(item.id, 1);
                                              productCount
                                                  .incrementTotal(item.id);
                                              widget.onProductCountChanged(
                                                  productCount.getTotalCount());
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          );
        },
      ),
    );
  }
}
