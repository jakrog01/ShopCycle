import 'package:flutter/material.dart';
import 'package:shopcycle/widgets/add_new_product.dart';
import 'package:shopcycle/models/products_list_item.dart';

class AddNewList extends StatefulWidget {
  const AddNewList({super.key});

  @override
  State<AddNewList> createState() {
    return _AddNewListState();
  }
}

class _AddNewListState extends State<AddNewList> {
  final _form = GlobalKey<FormState>();
  String? _title;
  String? _description;
  List<ProductsListItem> _shoppingList = [];

  void _addProduct() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddNewProduct()));
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
                      _title = newValue!;
                    },
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 3,
                    maxLength: 150,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    decoration: const InputDecoration(labelText: 'Description'),
                    onSaved: (newValue) {
                      _description = newValue!;
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
                        onPressed: (){}, child: const Text("Save list"))
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
