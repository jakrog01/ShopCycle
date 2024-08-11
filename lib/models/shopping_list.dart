import 'package:shopcycle/models/products_list_item.dart';

class ShoppingList{
  const ShoppingList({required this.listName, required this.shoppingList, required this.listID, this.description});
  final String listID;
  final String listName;
  final String? description;
  final List<ProductsListItem> shoppingList;

  Map<String, dynamic> get firestoreData{
    return {
      "ID": listID,
      "list_name": listName,
      "description": description,
      "shopping_list": [for (final product in shoppingList) product.firestoreData]
    };
  }
}