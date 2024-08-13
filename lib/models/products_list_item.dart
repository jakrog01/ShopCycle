import 'package:shopcycle/models/Category/list_product_category.dart';

class ProductsListItem {
  ProductsListItem({required this.itemName, required this.quantity, required this.category,required this.unit});

  final String itemName;
  final int quantity;
  final String unit;
  final ListProductCategory category;
  bool checkState = false;

  Map<String, dynamic> get firestoreData{
    return {
      "name": itemName,
      "quantity": quantity,
      "unit": unit,
      "checkState": false,
      "category": category.name,
    };
  }
}
