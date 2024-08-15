import 'package:shopcycle/models/products_list_item.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ShoppingList {
  ShoppingList(
      {required this.listName, required this.products, this.description})
      : listID = uuid.v4();

  ShoppingList.withID(
      {required this.listName,
      required this.products,
      this.description,
      required this.listID});

  factory ShoppingList.fromMap(Map<String, dynamic> data) {
    return ShoppingList.withID(
      listName: data['list_name'] as String,
      listID: data['ID'] as String,
      description: data['description'] as String,
      products: (data['products'] as List<dynamic>)
          .map((productData) =>
              ProductsListItem.fromMap(productData as Map<String, dynamic>))
          .toList(),
    );
  }

  final String listID;
  final String listName;
  final String? description;
  List<ProductsListItem> products;

  Map<String, dynamic> get firestoreData {
    return {
      "ID": listID,
      "list_name": listName,
      "description": description,
      "products": [for (final product in products) product.newFirestoreData]
    };
  }
}
