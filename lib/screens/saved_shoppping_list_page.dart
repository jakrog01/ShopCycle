import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/saved_list_view.dart';

class SavedShoppingListsPage extends StatelessWidget {
  SavedShoppingListsPage({super.key, required this.savedShoppingList});

  final List<ShoppingList> savedShoppingList;
  String? usedListTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_shopping_cart)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SavedListView(
          savedShoppingList: savedShoppingList,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
