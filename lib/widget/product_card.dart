import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_resto_menu/product_add.dart';

class ProductCard extends StatefulWidget {
  final Function(int) onProductCountChanged;

  const ProductCard({super.key, required this.onProductCountChanged});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {

    //TODO : di improve nanti untuk handle flexibilitas
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
      create: (_) => ProductCount(),
      child: Consumer<ProductCount>(
        builder: (context, productCount, child) {
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
                        height: MediaQuery.of(context).size.height * .18,
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
        },
      ),
    );
  }
}
