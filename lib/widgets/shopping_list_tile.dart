import 'package:flutter/material.dart';

class ShoppingListTile extends StatelessWidget {
  const ShoppingListTile({super.key, required this.listTitle});

  final String listTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.45),
                  Theme.of(context).colorScheme.primary.withOpacity(0.85)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
        ),
        Icon(Icons.shopping_cart_rounded,
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
        size: 40,
        ),
        Text(listTitle,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
      ],
    ));
  }
}
