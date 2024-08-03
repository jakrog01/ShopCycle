import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/list_item_category.dart';
import 'package:shopcycle/models/Category/product_category.dart';

const productsCategories = {
  ListItemCategory.fruits : ProductCategory(
    title: "Fruits", 
    color: Color.fromARGB(255, 202, 205, 35)
    ),
  ListItemCategory.vegetables : ProductCategory(
    title: "Vegetables", 
    color: Color.fromARGB(255, 4, 151, 9)
    ),
  ListItemCategory.meat : ProductCategory(
    title: "Meat", 
    color: Color.fromARGB(255, 210, 18, 18)
    ),
  ListItemCategory.deli : ProductCategory(
    title: "Deli", 
    color: Color.fromARGB(255, 210, 18, 165)
    ),
  ListItemCategory.dairy : ProductCategory(
    title: "Dairy", 
    color: Color.fromARGB(255, 255, 255, 255)
    ),
  ListItemCategory.snacks : ProductCategory(
    title: "Snacks", 
    color: Color.fromARGB(255, 18, 210, 191)
    ),
  ListItemCategory.bakery : ProductCategory(
    title: "Bakery", 
    color: Color.fromARGB(255, 226, 177, 120)
    ),
  ListItemCategory.baking : ProductCategory(
    title: "Baking", 
    color: Color.fromARGB(255, 238, 103, 155)
    ),
  ListItemCategory.frozen : ProductCategory(
    title: "Frozen", 
    color: Color.fromARGB(255, 4, 192, 255)
    ),
  ListItemCategory.personalCare : ProductCategory(
    title: "Personal care", 
    color: Color.fromARGB(255, 174, 27, 200)
    ),
  ListItemCategory.healthCare : ProductCategory(
    title: "Health care", 
    color: Color.fromARGB(255, 209, 111, 19)
    ),
  ListItemCategory.spices : ProductCategory(
    title: "Health care", 
    color: Color.fromARGB(255, 248, 81, 81)
    ),
  ListItemCategory.householdSupplies : ProductCategory(
    title: "Health care", 
    color: Color.fromARGB(255, 86, 32, 79)
    ),
  ListItemCategory.other : ProductCategory(
    title: "Health care", 
    color: Color.fromARGB(255, 102, 102, 102)
    ),
};