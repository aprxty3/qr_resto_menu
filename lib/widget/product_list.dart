import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final Function(int) onProductCountChanged;

  const ProductList({super.key, required this.onProductCountChanged});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<int> totals = List<int>.filled(20, 0);

  void _incrementTotal(int index) {
    setState(() {
      totals[index]++;
      widget.onProductCountChanged(totals.reduce((a, b) => a + b));
    });
  }

  void _decrementTotal(int index) {
    setState(() {
      if (totals[index] > 0) {
        totals[index]--;
        widget.onProductCountChanged(totals.reduce((a, b) => a + b));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => _decrementTotal(index),
                  icon: const Icon(Icons.remove),
                ),
                Text(totals[index].toString()),
                IconButton(
                  onPressed: () => _incrementTotal(index),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
