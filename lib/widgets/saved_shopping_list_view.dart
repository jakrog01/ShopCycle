import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/add_new_list.dart';
import 'package:shopcycle/widgets/saved_shopping_list_preview.dart';

class SavedShoppingListView extends StatefulWidget {
  const SavedShoppingListView(
      {super.key,
      required this.savedShoppingList,
      required this.onListPage,
      required this.onAddPage});

  final List<ShoppingList> savedShoppingList;
  final Function onListPage;
  final Function onAddPage;

  @override
  State<SavedShoppingListView> createState() {
    return _SavedShoppingListViewState();
  }
}

class _SavedShoppingListViewState extends State<SavedShoppingListView> {
  int itemindex = 0;

  void addNewList() async {
    final list = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddNewList()));
    if (list == null){
      return;
    }
    else{
      setState(() {
        widget.savedShoppingList.add(list);
      });
    }
  }

  void removeList(ShoppingList list){
    setState(() {
      widget.savedShoppingList.remove(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 2 + 50,
        width: MediaQuery.sizeOf(context).width,
        child: PageView(
            onPageChanged: (index) {
              setState(() {
                if (index == widget.savedShoppingList.length) {
                  widget.onAddPage();
                } else if (index != widget.savedShoppingList.length &&
                    itemindex == widget.savedShoppingList.length) {
                  widget.onListPage();
                }
                itemindex = index;
              });
            },
            children: [
              for (final shoppingList in widget.savedShoppingList)
                SavedShoppingListPreview(displayedShoppingList: shoppingList, removeList: removeList),
              InkWell(
                onTap: addNewList,
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
                      Text("Add new list",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurfaceVariant)),
                    ],
                  )),
                ),
              ),
            ]),
      ),
    );
  }
}
