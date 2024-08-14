import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/saved_shopping_list_view.dart';

class SavedShoppingListsPage extends StatefulWidget {
  const SavedShoppingListsPage({super.key, required this.savedShoppingList, required this.addToCurrentList});
  final List<ShoppingList> savedShoppingList;
  final Function addToCurrentList;

  @override
  State<SavedShoppingListsPage> createState() => _SavedShoppingListsPageState();
}

class _SavedShoppingListsPageState extends State<SavedShoppingListsPage> {
  late bool pageIsAddPage = widget.savedShoppingList.isEmpty ? true : false;
  int pageIndex = 0;

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

  void updatePageIndex(int index){
      pageIndex = index;
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
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        SavedShoppingListView(
          savedShoppingList: widget.savedShoppingList,
          onAddPage: onAddPage,
          onListPage: onListPage,
          updateIndex: updatePageIndex,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: !pageIsAddPage ? () {
                    widget.addToCurrentList(pageIndex);
                  } : null,
                  child: const Row(
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
