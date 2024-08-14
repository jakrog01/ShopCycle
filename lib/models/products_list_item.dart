import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ProductsListItem {
  ProductsListItem(
      {required this.itemName,
      required this.quantity,
      required this.category,
      required this.unit})
      : id = uuid.v4();

  ProductsListItem.withID(
      {required this.itemName,
      required this.quantity,
      required this.category,
      required this.unit,
      required this.id});

  final String id;
  final String itemName;
  final int quantity;
  final String unit;
  final ListProductCategory category;
  bool checkState = false;

  Map<String, dynamic> get firestoreData {
    return {
      "name": itemName,
      "id": id,
      "quantity": quantity,
      "unit": unit,
      "checkState": false,
      "category": category.name,
    };
  }
}
