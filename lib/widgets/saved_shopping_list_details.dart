import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/products_categories.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/products_list_item.dart';

class SavedShoppingListDetalisView extends StatelessWidget {
  SavedShoppingListDetalisView({super.key, required this.displayedShoppingList}) {
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
      actions: [PopupMenuButton(itemBuilder: (context) => [
        const PopupMenuItem(
          child: Row(children: [Icon(Icons.edit), SizedBox(width: 2,), Text("Edit")],)),
          const PopupMenuItem(
          child: Row(children: [Icon(Icons.delete), SizedBox(width: 2,), Text("Delete")],))
      ])],
      title: Text(displayedShoppingList.listName),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                        child: Row(
                          children: [
                            Container(width: 15, height: 15, color: productsCategories[category]!.color,),
                            const SizedBox(width: 5,),
                            Text(
                              productsCategories[category]!.title,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
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
                                        Theme.of(context).colorScheme.onSurface),
                          ),
                          trailing: Text(
                            "${item.quantity.toString()}${item.unit}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface),
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
      ),
    );
  }
}
