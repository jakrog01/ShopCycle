import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/products_categories.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/products_list_item.dart';

class SavedShoppingListView extends StatelessWidget {
  SavedShoppingListView({super.key, required this.displayedShoppingList}) {
    createCategorizedLists();
  }

  final ShoppingList displayedShoppingList;
  final Map<ListProductCategory, List<ProductsListItem>> categorizedMap = {};

  void createCategorizedLists() {
    for (var item in displayedShoppingList.shoppingList) {
      categorizedMap.putIfAbsent(item.category, () => []).add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(displayedShoppingList.listName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
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
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                      child: Row(
                        children: [
                          Container(width: 20, height: 20, color: productsCategories[category]!.color,),
                          const SizedBox(width: 5,),
                          Text(
                            productsCategories[category]!.title,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ...items.map(
                      (item) => ListTile(
                        title: Text(
                          item.itemName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                        trailing: Text(
                          item.quantity.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
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
