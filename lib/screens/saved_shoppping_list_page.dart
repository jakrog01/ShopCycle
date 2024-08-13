import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/saved_shopping_list_view.dart';

class SavedShoppingListsPage extends StatefulWidget {
  SavedShoppingListsPage({super.key, required this.savedShoppingList});
  final List<ShoppingList> savedShoppingList;

  @override
  State<SavedShoppingListsPage> createState() => _SavedShoppingListsPageState();
}

class _SavedShoppingListsPageState extends State<SavedShoppingListsPage> {
  late bool pageIsAddPage = widget.savedShoppingList.isEmpty ? true : false;

  void onAddPage() {
    setState(() {
      pageIsAddPage = true;
    });
  }

  void onListPage() {
    setState(() {
      pageIsAddPage = false;
    });
  }

  String? usedListTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          pageIsAddPage ? "ADD NEW LIST" : "CHOOSE YOUR LIST",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        SavedShoppingListView(
          savedShoppingList: widget.savedShoppingList,
          onAddPage: onAddPage,
          onListPage: onListPage,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: !pageIsAddPage ? () {} : null,
                  child: Row(
                    children: [
                      Icon(Icons.add_shopping_cart),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Add to shopping list")
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
