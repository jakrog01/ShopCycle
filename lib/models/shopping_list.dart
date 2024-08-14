import 'package:shopcycle/models/products_list_item.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ShoppingList {
  ShoppingList(
      {required this.listName, required this.shoppingList, this.description})
      : listID = uuid.v4();

  ShoppingList.withID(
      {required this.listName,
      required this.shoppingList,
      this.description,
      required this.listID});

  final String listID;
  final String listName;
  final String? description;
  final List<ProductsListItem> shoppingList;

  Map<String, dynamic> get firestoreData {
    return {
      "ID": listID,
      "list_name": listName,
      "description": description,
      "shopping_list": [
        for (final product in shoppingList) product.firestoreData
      ]
    };
  }
}
