import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../menu_state.dart';
import '../model/menu_items.dart';
import '../product_add.dart';

class ProductList extends StatefulWidget {
  final List<MenuItem> items;
  final Function(int) onProductCountChanged;

  const ProductList(
      {super.key, required this.onProductCountChanged, required this.items});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductAdd(),
      child: Consumer<ProductAdd>(
        builder: (context, productCount, child) {
          return Visibility(
            visible: widget.items.isNotEmpty,
            replacement: const Center(
              child: Text('Produk Sedang Kosong'),
            ),
            child: Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(item.name),
                                  subtitle: Text(item.price.toString()),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Provider.of<MenuState>(context, listen: false)
                                      .updateProduct(item.id, -1);
                                  productCount.decrementTotal(item.id);
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
                                  Provider.of<MenuState>(context, listen: false)
                                      .updateProduct(item.id, 1);
                                  productCount.incrementTotal(item.id);
                                  widget.onProductCountChanged(
                                      productCount.getTotalCount());
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
