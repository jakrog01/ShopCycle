import 'package:shopcycle/models/products_list_item.dart';

class ShoppingList{
  const ShoppingList({required this.listName, required this.shoppingList, required this.listID});
  final String listID;
  final String listName;
  final List<ProductsListItem> shoppingList;

  Map<String, dynamic> get firestoreData{
    return {
      "ID": listID,
      "list_name": listName,
      "shopping_list": [for (final product in shoppingList) product.firestoreData]
    };
  }
}