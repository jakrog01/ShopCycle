import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/Category/products_categories.dart';
import 'package:shopcycle/models/products_list_item.dart';

class ShoppingListEditView extends StatefulWidget {
  const ShoppingListEditView({super.key, required this.shoppingList});

  final List<ProductsListItem> shoppingList;

  @override
  State<ShoppingListEditView> createState() {
    return _ShoppingListEditViewState();
  }
}

class _ShoppingListEditViewState extends State<ShoppingListEditView> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    createCategorizedLists();
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3,
      width: MediaQuery.sizeOf(context).width - 50,
      child: widget.shoppingList.isEmpty
          ? Center(
              child: Text("List is empty",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold)))
          : ListView.builder(
              itemCount: categorizedMap.length,
              itemBuilder: (ctx, index) {
                final category = categorizedMap.keys.elementAt(index);
                final items = categorizedMap[category]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10.0),
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
                                .titleSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ...items.map(
                      (item) => Dismissible(
                        onDismissed: (direction) {
                          _removeItem(item);
                        },
                        key: ValueKey(item.id),
                        child: ListTile(
                          title: Text(
                            item.itemName,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                          trailing: Text(
                            "${item.quantity.toString()}${item.unit}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
