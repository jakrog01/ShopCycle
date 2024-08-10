import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/products_list_item.dart';
import 'package:shopcycle/models/shopping_list.dart';

final savedListModel =
    ShoppingList(listName: "DEMO", listID: "aw124", shoppingList: [
  ProductsListItem(
      itemName: "Twaróg", quantity: 250, category: ListProductCategory.dairy),
  ProductsListItem(itemName: "Bułki", quantity: 2, category: ListProductCategory.baking)
]);


final savedListModel2 =
    ShoppingList(listName: "DEMO2", listID: "aw12423", shoppingList: [
  ProductsListItem(
      itemName: "Banan", quantity: 3, category: ListProductCategory.fruits),
  ProductsListItem(itemName: "Sprite", quantity: 250, category: ListProductCategory.drinks)
]);