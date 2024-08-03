import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/Category/products_categories.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() {
    return _AddNewProductState();
  }
}

class _AddNewProductState extends State<AddNewProduct> {
  String? _title;
  int? _quantity;
  ListProductCategory? _category = ListProductCategory.other;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text("Add a new product"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    decoration:
                        const InputDecoration(labelText: 'Product name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _title = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 50,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.surface),
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a valid quantity';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _quantity = int.parse(newValue!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category: ",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 5,
                    children: [
                      for (final category in productsCategories.entries)
                        ChoiceChip(
                          avatar: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                category.value.color,
                                category.value.color.withOpacity(0.7)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary ,
                          label: Text(
                            category.value.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          selected: _category == category.key,
                          onSelected: (bool selected) {
                            setState(() {
                              _category = selected ? category.key : null;
                            });
                          },
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
