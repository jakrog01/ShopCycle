import 'package:shopcycle/models/Category/list_product_category.dart';

class ProductsListItem {
  ProductsListItem({required this.itemName, required this.quantity, required this.category});

  final String itemName;
  final int quantity;
  final ListProductCategory category;
  bool checkState = false;

  Map<String, dynamic> get firestoreData{
    return {
      "name": itemName,
      "quantity": quantity,
      "checkState": false,
      "category": category.name,
    };
  }
}
