import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/saved_shopping_list_details.dart';

class SavedShoppingListPreview extends StatelessWidget {
  const SavedShoppingListPreview({super.key, required this.displayedShoppingList});

  final ShoppingList displayedShoppingList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => SavedShoppingListDetalisView(
                  displayedShoppingList: displayedShoppingList)));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  displayedShoppingList.listName,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 150,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      Center(
                        child: displayedShoppingList.description == null
                            ? null
                            : Text(
                                displayedShoppingList.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        overflow: TextOverflow.clip),
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
