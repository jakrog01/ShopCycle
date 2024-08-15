import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/Category/product_category.dart';

const productsCategories = {
  ListProductCategory.fruits:
      ProductCategory(title: "Fruits", color: Color.fromARGB(255, 251, 255, 0)),
  ListProductCategory.vegetables: ProductCategory(
      title: "Vegetables", color: Color.fromARGB(255, 4, 151, 9)),
  ListProductCategory.meat:
      ProductCategory(title: "Meat", color: Color.fromARGB(255, 210, 18, 18)),
  ListProductCategory.deli:
      ProductCategory(title: "Deli", color: Color.fromARGB(255, 210, 18, 165)),
  ListProductCategory.dairy: ProductCategory(
      title: "Dairy", color: Color.fromARGB(255, 255, 255, 255)),
  ListProductCategory.grains: ProductCategory(
      title: "Grains", color: Color.fromARGB(255, 207, 218, 160)),
  ListProductCategory.drinks: ProductCategory(
      title: "Drinks", color: Color.fromARGB(255, 155, 233, 45)),
  ListProductCategory.snacks: ProductCategory(
      title: "Snacks", color: Color.fromARGB(255, 18, 210, 191)),
  ListProductCategory.bakery: ProductCategory(
      title: "Bakery", color: Color.fromARGB(255, 226, 177, 120)),
  ListProductCategory.baking: ProductCategory(
      title: "Baking", color: Color.fromARGB(255, 238, 103, 155)),
  ListProductCategory.frozen:
      ProductCategory(title: "Frozen", color: Color.fromARGB(255, 4, 192, 255)),
  ListProductCategory.personalCare: ProductCategory(
      title: "Personal care", color: Color.fromARGB(255, 174, 27, 200)),
  ListProductCategory.healthCare: ProductCategory(
      title: "Health care", color: Color.fromARGB(255, 209, 111, 19)),
  ListProductCategory.spices:
      ProductCategory(title: "Spices", color: Color.fromARGB(255, 248, 81, 81)),
  ListProductCategory.householdSupplies: ProductCategory(
      title: "Household Supplies", color: Color.fromARGB(255, 86, 32, 79)),
  ListProductCategory.other: ProductCategory(
      title: "Other", color: Color.fromARGB(255, 102, 102, 102)),
};
