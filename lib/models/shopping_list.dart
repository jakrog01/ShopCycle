import 'package:shopcycle/models/list_item.dart';

class ShoppingList{
  const ShoppingList({required this.listName, required this.shoppingList});

  final String listName;
  final List<ListItem> shoppingList;
}