import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/saved_shopping_list_preview.dart';
import 'package:shopcycle/widgets/saved_shopping_list_details.dart';

class SavedShoppingListView extends StatefulWidget {
  const SavedShoppingListView(
      {super.key, required this.savedShoppingList});

  final List<ShoppingList> savedShoppingList;

  @override
  State<SavedShoppingListView> createState() {
    return _SavedShoppingListViewState();
  }
}

class _SavedShoppingListViewState
    extends State<SavedShoppingListView> {
  int itemindex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 2 + 50,
        width: MediaQuery.sizeOf(context).width,
        child: PageView(
            onPageChanged: (index) {
              setState(() {
                itemindex = index;
              });
            },
            children: [
              for (final shoppingList in widget.savedShoppingList)
                SavedShoppingListPreview(displayedShoppingList: shoppingList),
              InkWell(
                onTap: () {},
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      Text("Add new list",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                    ],
                  )),
                ),
              ),
            ]),
      ),
    );
  }
}
