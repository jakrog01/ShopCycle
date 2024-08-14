import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/current_shopping_list_display.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key, required this.currentShoppingList});
  final ShoppingList currentShoppingList;

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return widget.currentShoppingList.products.isEmpty
        ? Center(
            child: Text("ADD SOMETHING",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)))
        : CurrentShoppingListDisplay(
            shoppingList: widget.currentShoppingList.products);
  }
}
