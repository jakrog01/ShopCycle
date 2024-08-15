import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/add_new_list.dart';
import 'package:shopcycle/widgets/saved_shopping_list_preview.dart';

class SavedShoppingListView extends StatefulWidget {
  const SavedShoppingListView(
      {super.key,
      required this.savedShoppingList,
      required this.onListPage,
      required this.onAddPage,
      required this.updateIndex});

  final List<ShoppingList> savedShoppingList;
  final Function onListPage;
  final Function onAddPage;
  final Function updateIndex;

  @override
  State<SavedShoppingListView> createState() {
    return _SavedShoppingListViewState();
  }
}

class _SavedShoppingListViewState extends State<SavedShoppingListView> {
  int itemindex = 0;

  void addNewList() async {
    final list = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddNewList()));
    if (list == null) {
      return;
    } else if (list is ShoppingList) {
      setState(() {
        try {
          widget.savedShoppingList.add(list);
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('saved_lists')
              .doc(list.listID)
              .set(list.firestoreData);
        } on FirebaseException catch (error) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              content: Center(
                child: Row(
                  children: [
                    const Icon(Icons.warning),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(error.message ?? 'Communication problem',
                            overflow: TextOverflow.clip))
                  ],
                ),
              )));
        }
      });
    }
  }

  void removeList(ShoppingList list) {
    setState(() {
      try{
      widget.savedShoppingList.remove(list);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('saved_lists')
          .doc(list.listID)
          .delete();} on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            content: Center(
              child: Row(
                children: [
                  const Icon(Icons.warning),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Text(error.message ?? 'Communication problem',
                          overflow: TextOverflow.clip))
                ],
              ),
            )));
      }
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
                if (index == widget.savedShoppingList.length || widget.savedShoppingList.isEmpty) {
                  widget.onAddPage();
                } else if (index != widget.savedShoppingList.length &&
                    itemindex == widget.savedShoppingList.length) {
                  widget.onListPage();
                }
                itemindex = index;
                widget.updateIndex(index);
              });
            },
            children: [
              for (final shoppingList in widget.savedShoppingList)
                SavedShoppingListPreview(
                    displayedShoppingList: shoppingList,
                    removeList: removeList),
              InkWell(
                onTap: addNewList,
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,
                          color: Theme.of(context).colorScheme.onSurface),
                      Text("Add new list",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant)),
                    ],
                  )),
                ),
              ),
            ]),
      ),
    );
  }
}
