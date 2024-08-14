import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/products_list_item.dart';
import 'package:shopcycle/models/shopping_list.dart';

final savedListModel =
    ShoppingList(listName: "DEMO", shoppingList: [
  ProductsListItem(
      itemName: "Twaróg", quantity: 250, category: ListProductCategory.dairy, unit: "g"),
  ProductsListItem(itemName: "Bułki", quantity: 2, category: ListProductCategory.baking, unit: "")
], description: "To po prostu twaróg i dwie bułki");


final savedListModel2 =
    ShoppingList(listName: "DEMO2", shoppingList: [
  ProductsListItem(
      itemName: "Banan", quantity: 3, category: ListProductCategory.fruits, unit: ""),
  ProductsListItem(itemName: "Sprite", quantity: 250, category: ListProductCategory.drinks, unit:"ml")
]);