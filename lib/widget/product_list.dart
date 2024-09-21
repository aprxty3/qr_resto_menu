import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/menu_items.dart';
import '../product_add.dart';

class ProductList extends StatefulWidget {
  final List<MenuItem> items;
  final Function(int) onProductCountChanged;

  const ProductList({super.key, required this.onProductCountChanged, required this.items});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductAdd(widget.items.length),
      child: Consumer<ProductAdd>(
        builder: (context, productCount, child) {
          return Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text('Nama Menu $index'),
                          subtitle: const Text('Rp 10.000'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          productCount.decrementTotal(index);
                          widget.onProductCountChanged(
                              productCount.getTotalCount());
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(productCount.totals[index].toString()),
                      IconButton(
                        onPressed: () {
                          productCount.incrementTotal(index);
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
          );
        },
      ),
    );
  }
}
