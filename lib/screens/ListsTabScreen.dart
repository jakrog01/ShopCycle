import 'package:flutter/material.dart';
import 'package:shopcycle/widgets/main_drawer.dart';
import 'package:shopcycle/screens/SavedShoppingListScreen.dart';

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
    Widget activePage = const Savedshoppinglistscreen();
    var _screenTitle = "Saved Shopping Lists";

    if (_selectedPageIndex == 1) {
      setState(() {
        _screenTitle = "Shopping List ";
      });
      ;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(_screenTitle),
      ),
      drawer: const MainDrawer(),
      body: const Savedshoppinglistscreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
