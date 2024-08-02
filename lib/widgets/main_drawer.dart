import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surface.withOpacity(0.7)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 80,
                      child: Image.asset('assets/images/slicon.png')),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Shop Cycle",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  )
                ],
              )),
          ListTile(
            leading: Icon(Icons.list,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "My lists",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            ),
            onTap: () {
              return;
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            ),
            onTap: () {
              return;
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(Icons.logout,
                    color: Theme.of(context).colorScheme.onSurface),
                title: Text(
                  "Log out",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
