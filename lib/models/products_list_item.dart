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
      required this.id,
      required this.checkState});

  factory ProductsListItem.fromMap(Map<String, dynamic> data) {
    return ProductsListItem.withID(
      unit: data['unit'] as String,
      quantity: data['quantity'] as int,
      itemName: data['name'] as String,
      checkState: data['checkState'] as bool,
      id: data['id'] as String,
      category: ListProductCategory.values.firstWhere(
        (e) => e.toString().split('.').last == data['category'],
        orElse: () => ListProductCategory.other,
      ),
    );
  }

  final String id;
  final String itemName;
  final int quantity;
  final String unit;
  final ListProductCategory category;
  bool checkState = false;

  Map<String, dynamic> get newFirestoreData {
    return {
      "name": itemName,
      "id": id,
      "quantity": quantity,
      "unit": unit,
      "checkState": false,
      "category": category.name,
    };
  }

  Map<String, dynamic> get firestoreData {
    return {
      "name": itemName,
      "id": id,
      "quantity": quantity,
      "unit": unit,
      "checkState": checkState,
      "category": category.name,
    };
  }
}
