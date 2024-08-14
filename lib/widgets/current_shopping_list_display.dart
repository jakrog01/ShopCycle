import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/Category/products_categories.dart';
import 'package:shopcycle/models/products_list_item.dart';

class CurrentShoppingListDisplay extends StatefulWidget {
  const CurrentShoppingListDisplay({super.key, required this.shoppingList});

  final List<ProductsListItem> shoppingList;

  @override
  State<CurrentShoppingListDisplay> createState() {
    return _CurrentShoppingListDisplayState();
  }
}

class _CurrentShoppingListDisplayState
    extends State<CurrentShoppingListDisplay> {
  final Map<ListProductCategory, List<ProductsListItem>> categorizedMap = {};
  void createCategorizedLists() {
    categorizedMap.clear();
    for (var item in widget.shoppingList) {
      categorizedMap.putIfAbsent(item.category, () => []).add(item);
    }
  }

  void _removeItem(ProductsListItem product) {
    setState(() {
      widget.shoppingList.remove(product);

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('current_list')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "products": [
          for (final product in  widget.shoppingList)
            product.newFirestoreData
        ]
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    createCategorizedLists();
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categorizedMap.length,
              itemBuilder: (ctx, index) {
                final category = categorizedMap.keys.elementAt(index);
                final items = categorizedMap[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.surface,
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.7)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                        child: Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              color: productsCategories[category]!.color,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              productsCategories[category]!.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...items.map((item) => Stack(
                          children: [
                            if (item.checkState)
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                    margin: const EdgeInsets.only(
                                        left: 50.0, right: 15),
                                  ),
                                ),
                              ),
                            Container(
                              color: item.checkState
                                  ? Colors.transparent
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                              child: Dismissible(
                                onDismissed: (direction) {
                                  _removeItem(item);
                                },
                                key: ValueKey(item.id),
                                child: CheckboxListTile(
                                  dense: true,
                                  activeColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.4),
                                  value: item.checkState,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      item.checkState = value!;
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('current_list')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "products": [
                                          for (final product
                                              in widget.shoppingList)
                                            product.firestoreData
                                        ]
                                      });
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    item.itemName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                  ),
                                  secondary: Text(
                                    "${item.quantity.toString()}${item.unit}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
