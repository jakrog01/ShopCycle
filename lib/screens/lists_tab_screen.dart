import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopcycle/models/products_list_item.dart';
import 'package:shopcycle/screens/shopping_list_page.dart';
import 'package:shopcycle/widgets/add_new_product.dart';
import 'package:shopcycle/widgets/main_drawer.dart';
import 'package:shopcycle/screens/saved_shoppping_list_page.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'dart:async';

class ListsTabScreen extends StatefulWidget {
  const ListsTabScreen({super.key});

  @override
  State<ListsTabScreen> createState() {
    return _ListsTabScreenState();
  }
}

class _ListsTabScreenState extends State<ListsTabScreen> {
  int _selectedPageIndex = 0;
  late ShoppingList _currentShoppingList;
  StreamSubscription<DocumentSnapshot>? currentListSubscription;
  StreamSubscription<QuerySnapshot>? savedListsSubscription;

  final List<ShoppingList> _savedShoppingLists = [];

  @override
  void initState() {
    try {
      currentListSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('current_list')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        final data = event.data();
        if (data != null && data['products'] != null) {
          _currentShoppingList = ShoppingList(
              listName: "current_lsit",
              products: (data['products'] as List<dynamic>)
                  .map((productData) => ProductsListItem.fromMap(productData))
                  .toList());
        }
      });

      savedListsSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('saved_lists')
          .snapshots()
          .listen((snapshot) {
        final List<ShoppingList> updatedSavedLists = snapshot.docs.map((doc) {
          return ShoppingList.fromMap(doc.data());
        }).toList();
        setState(() {
          _savedShoppingLists.clear();
          _savedShoppingLists.addAll(updatedSavedLists);
        });
      });
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

    super.initState();
  }

  @override
  void dispose() {
    currentListSubscription?.cancel();
    savedListsSubscription?.cancel();
    super.dispose();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void addListToCurrent(int index) {
    List<ProductsListItem> newList = [];

    for (final product in _savedShoppingLists[index].products) {
      newList.add(ProductsListItem(
          itemName: product.itemName,
          quantity: product.quantity,
          category: product.category,
          unit: product.unit));
    }
    setState(() {
      try {
        _currentShoppingList.products.addAll(newList);
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('current_list')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "products": [
            for (final product in _currentShoppingList.products)
              product.newFirestoreData
          ]
        });
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
      return;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      content: Row(
        children: [
          Icon(Icons.add_shopping_cart),
          SizedBox(width: 8),
          Expanded(
            child: Text("List added to shopping list"),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = SavedShoppingListsPage(
      savedShoppingList: _savedShoppingLists,
      addToCurrentList: addListToCurrent,
    );
    var screenTitle = "Saved Shopping Lists";

    void addItem() async {
      var product = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const AddNewProduct()));

      if (product == null) {
        return;
      }

      setState(() {
        _currentShoppingList.products.add(product);
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('current_list')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "products": [
            for (final product in _currentShoppingList.products)
              product.newFirestoreData
          ]
        });
      });
    }

    if (_selectedPageIndex == 1) {
      screenTitle = "Shopping List ";
      activePage = ShoppingListPage(currentShoppingList: _currentShoppingList);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        actions: [
          _selectedPageIndex == 1
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _currentShoppingList.products.clear();
                      try {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('current_list')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "products": [
                            for (final product in _currentShoppingList.products)
                              product.newFirestoreData
                          ]
                        });
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
                                      child: Text(
                                          error.message ??
                                              'Communication problem',
                                          overflow: TextOverflow.clip))
                                ],
                              ),
                            )));
                      }
                    });
                  },
                  icon: Icon(
                    Icons.clear_all,
                    color: Theme.of(context).colorScheme.onSurface,
                  ))
              : const SizedBox()
        ],
        title: Text(screenTitle),
      ),
      drawer: const MainDrawer(),
      body: activePage,
      floatingActionButton: (_selectedPageIndex == 0)
          ? null
          : FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: addItem,
              child: const Icon(Icons.add),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: "Saved shopping lists",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.onSurface),
              label: "Shopping list")
        ],
      ),
    );
  }
}
