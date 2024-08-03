import 'package:flutter/material.dart';

class AddNewProduct extends StatefulWidget{
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() {
    return _AddNewProductState();
  }
}

class _AddNewProductState extends State<AddNewProduct>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Add a new product"),
      ),
      body: const Center(child: Text("Add new item")),
    );
  }
}