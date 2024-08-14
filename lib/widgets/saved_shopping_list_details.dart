import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/products_categories.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/products_list_item.dart';
import 'package:shopcycle/widgets/add_new_list.dart';

class SavedShoppingListDetalisView extends StatefulWidget {
  SavedShoppingListDetalisView(
      {super.key, required this.displayedShoppingList, required this.removeList});

  ShoppingList displayedShoppingList;
  final Function removeList;

  @override
  State<SavedShoppingListDetalisView> createState() =>
      _SavedShoppingListDetalisViewState();
}

class _SavedShoppingListDetalisViewState
    extends State<SavedShoppingListDetalisView> {
  final Map<ListProductCategory, List<ProductsListItem>> categorizedMap = {};

  void createCategorizedLists() {
    categorizedMap.clear();
    for (var item in widget.displayedShoppingList.shoppingList) {
      categorizedMap.putIfAbsent(item.category, () => []).add(item);
    }
  }

  void editList() async {
    var edited_list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            AddNewList.edit(shoppingList: widget.displayedShoppingList)));

    if (edited_list == null) {
      return;
    } else {
      setState(() {
        widget.displayedShoppingList = edited_list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createCategorizedLists();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 0) {
                  editList();
                } else if (value == 1) {
                  Navigator.of(context).pop();
                  widget.removeList(widget.displayedShoppingList);
                }
              },
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(
                            width: 2,
                          ),
                          Text("Edit")
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                            width: 2,
                          ),
                          Text("Delete")
                        ],
                      ),
                    ),
                  ])
        ],
        title: Text(widget.displayedShoppingList.listName),
      ),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
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