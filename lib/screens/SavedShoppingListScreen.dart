import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopcycle/widgets/main_drawer.dart';

class Savedshoppinglistscreen extends StatelessWidget {
  const Savedshoppinglistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Shop Cycle"),
      ),
      drawer: const MainDrawer(),
    );
  }
}
