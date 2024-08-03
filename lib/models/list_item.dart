import 'package:shopcycle/models/Category/list_product_category.dart';

class ListItem {
  const ListItem(
      {required this.itemName, required this.quantity, required this.category});

  final String itemName;
  final int quantity;
  final ListProductCategory category;
}
