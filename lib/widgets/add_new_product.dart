import 'package:flutter/material.dart';
import 'package:shopcycle/models/Category/list_product_category.dart';
import 'package:shopcycle/models/Category/products_categories.dart';
import 'package:shopcycle/models/product_units.dart';
import 'package:shopcycle/models/products_list_item.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() {
    return _AddNewProductState();
  }
}

class _AddNewProductState extends State<AddNewProduct> {
  final _form = GlobalKey<FormState>();
  String? _title;
  int? _quantity;
  String? _unit = ListProductUnits.g.name;
  ListProductCategory? _category = ListProductCategory.other;

  void _addProduct() {
    final dataValidation = _form.currentState!.validate();

    if (!dataValidation || _category == null) {
      return;
    }
    _form.currentState!.save();
    if (_unit == "none"){
      _unit = '';
    }
    Navigator.of(context).pop(ProductsListItem(itemName: _title!, quantity: _quantity!.toInt(), 
    category: _category!, unit: _unit!));
  }

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
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    textCapitalization: TextCapitalization.sentences,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          decoration:
                              const InputDecoration(labelText: 'Quantity'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                int.tryParse(value) == null) {
                              return 'Please enter a valid quantity';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _quantity = int.parse(newValue!);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 70,
                        child: DropdownButtonFormField<String>(
                          value: _unit,
                          isDense: true,
                          isExpanded: true,
                          decoration: const InputDecoration(labelText: "Unit"),
                          dropdownColor: Theme.of(context).colorScheme.surface,
                          items: ListProductUnits.values
                              .map((ListProductUnits unit) {
                            return DropdownMenuItem<String>(
                              value: unit.name,
                              child: Center(
                                child: Text(unit.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _unit = value!;
                            });
                          },
                        ),
                      ),
                    ],
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
                    spacing: 7,
                    children: [
                      for (final category in productsCategories.entries)
                        ChoiceChip(
                          padding: const EdgeInsets.all(7),
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          avatar: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    category.value.color,
                                    category.value.color.withOpacity(0.7)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                          ),
                          selectedColor: Theme.of(context).colorScheme.primary,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          labelStyle: _category == category.key
                              ? Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface)
                              : Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                          label: Text(
                            category.value.title,
                          ),
                          selected: _category == category.key,
                          onSelected: (bool selected) {
                            setState(() {
                              _category = category.key;
                            });
                          },
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: _addProduct, child: const Text("Add Product"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
