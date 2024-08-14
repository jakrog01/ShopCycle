import 'package:flutter/material.dart';
import 'package:shopcycle/models/shopping_list.dart';
import 'package:shopcycle/widgets/add_new_product.dart';
import 'package:shopcycle/models/products_list_item.dart';
import 'package:shopcycle/widgets/shopping_list_edit_view.dart';

class AddNewList extends StatefulWidget {
  final ShoppingList? shoppingList;

  const AddNewList({super.key}) : shoppingList = null;
  const AddNewList.edit({super.key, required this.shoppingList});

  @override
  State<AddNewList> createState() {
    return _AddNewListState();
  }
}

class _AddNewListState extends State<AddNewList> {
  final _form = GlobalKey<FormState>();
  String? id;
  String? title;
  String? description;
  List<ProductsListItem> shoppingList = [];

  @override
  void initState() {
    super.initState();

    if (widget.shoppingList != null) {
      id = widget.shoppingList!.listID;
      title = widget.shoppingList!.listName;
      description = widget.shoppingList!.description;
      shoppingList = widget.shoppingList!.shoppingList;
    } else {
      id = null;
      title = null;
      description = null;
      shoppingList = [];
    }
  }

  void _addProduct() async {
    final newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddNewProduct()));

    if (newItem == null) {
      return;
    }

    setState(() {
      shoppingList.add(newItem);
    });
  }

  void _saveList() {
    final dataValidation = _form.currentState!.validate();

    if (!dataValidation) {
      return;
    }

    if (shoppingList.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
        child: Row(
          children: [
            Icon(Icons.warning),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text('Products list must not be empty',
                    overflow: TextOverflow.clip))
          ],
        ),
      )));
      return;
    }

    _form.currentState!.save();

    if (id == null) {
      Navigator.of(context).pop(ShoppingList(
          listName: title!,
          shoppingList: shoppingList,
          description: description));
    } else {
      Navigator.of(context).pop(ShoppingList.withID(
          listName: title!,
          shoppingList: shoppingList,
          description: description,
          listID: id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text("Create new list"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: title,
                    maxLength: 50,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    decoration: const InputDecoration(labelText: 'List name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      title = newValue!;
                    },
                  ),
                  TextFormField(
                    initialValue: description,
                    minLines: 2,
                    maxLines: 3,
                    maxLength: 150,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    decoration: const InputDecoration(labelText: 'Description'),
                    onSaved: (newValue) {
                      description = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Shopping list: ",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: _addProduct,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Add new product")
                        ],
                      )),
                  ShoppingListEditView(shopping_list: shoppingList),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: _saveList, child: const Text("Save list"))
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
