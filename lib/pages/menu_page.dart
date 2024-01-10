import 'package:flutter/material.dart';
import '../data_manager.dart';
import '../data_model.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({
    Key? key,
    required this.dataManager,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: dataManager.getMenu(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //the future is finished and data is ready
              var categories = snapshot.data!;

              return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    var category = categories[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, bottom: 8.0, left: 8.0),
                          child: Text(category.name),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: category.products.length,
                          itemBuilder: (context, index) {
                            var product = category.products[index];
                            return ProductItem(
                              product: product,
                              onAdd: (addedProduct) {
                                dataManager.cartAdd(addedProduct);
                              },
                            );
                          },
                        )
                      ],
                    );
                  });
            } else {
              if (snapshot.hasError) {
                //data not found, because of error
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else {
                //data is in progress( the future didnt finish yet)
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onAdd;
  const ProductItem({Key? key, required this.product, required this.onAdd})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(product.name,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$${product.price.toStringAsFixed(2)}"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onAdd(product);
                    },
                    child: const Text("Add"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
