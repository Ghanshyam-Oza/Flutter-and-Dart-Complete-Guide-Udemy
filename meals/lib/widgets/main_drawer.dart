import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onChangePage});

  final void Function(String identifier) onChangePage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Coooking Up!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              onChangePage("meals");
            },
            leading: Icon(
              Icons.restaurant,
              color: Theme.of(context).colorScheme.onBackground,
              size: 26,
            ),
            title: Text(
              "Meals",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20,
                  ),
            ),
          ),
          ListTile(
            onTap: () {
              onChangePage("filters");
            },
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onBackground,
              size: 26,
            ),
            title: Text(
              "Filters",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
