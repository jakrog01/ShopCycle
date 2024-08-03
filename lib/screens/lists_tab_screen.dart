import 'package:flutter/material.dart';
import 'package:shopcycle/screens/shopping_list_page.dart';
import 'package:shopcycle/widgets/add_new_product.dart';
import 'package:shopcycle/widgets/main_drawer.dart';
import 'package:shopcycle/screens/saved_shoppping_list_page.dart';

class ListsTabScreen extends StatefulWidget {
  const ListsTabScreen({super.key});

  @override
  State<ListsTabScreen> createState() {
    return _ListsTabScreenState();
  }
}

class _ListsTabScreenState extends State<ListsTabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const SavedShoppingListsPage();
    var screenTitle = "Saved Shopping Lists";

    void addItem(){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddNewProduct()));
    }

    if (_selectedPageIndex == 1) {
      screenTitle = "Shopping List ";
      activePage = const ShoppingListPage();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      drawer: const MainDrawer(),
      body: activePage,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: (_selectedPageIndex == 0)? null : addItem,
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
