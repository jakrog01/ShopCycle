import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/saved_shopping_list_view.dart';

class SavedListView extends StatefulWidget {
  const SavedListView({super.key, required this.savedShoppingList});

  final List<ShoppingList> savedShoppingList;

  @override
  State<SavedListView> createState() {
    return _SavedListViewState();
  }
}

class _SavedListViewState extends State<SavedListView> {
  int itemindex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height - 230,
        width: MediaQuery.sizeOf(context).width,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.surface.withOpacity(0.7)),
            child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    itemindex = index;
                  });
                },
                children: [
                  for (final shoppingList in widget.savedShoppingList)
                    SavedShoppingListView(displayedShoppingList: shoppingList),
                  InkWell(
                    onTap: (){},
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
                        ],
                      )),
                    ),
                  ),
                ])),
      ),
    );
  }
}
