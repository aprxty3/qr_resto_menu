import 'package:flutter/material.dart';
import 'package:qr_resto_menu/product_add.dart';

class ProductCard extends StatefulWidget {
  final Function(int) onProductCountChanged;

  const ProductCard({super.key, required this.onProductCountChanged});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with ProductCountMixin<ProductCard> {
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

    return Expanded(
      child: GridView.builder(
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemBuilder: (context, index) {
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
                  height: MediaQuery.of(context).size.height * .17,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama Menu $index'),
                          const SizedBox(height: 4),
                          const Text('Rp 10.000'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementTotal(index),
                            icon: const Icon(Icons.remove),
                          ),
                          Text(totals[index].toString()),
                          IconButton(
                            onPressed: () => incrementTotal(index),
                            icon: const Icon(Icons.add),
                          ),
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
    );
  }
}
