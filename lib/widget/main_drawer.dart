import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer(this.selectedFilter, {super.key});
  final void Function(String name) selectedFilter;
  @override
  Widget build(context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
            ])),
            child: const Row(
              children: [
                Icon(
                  Icons.fastfood,
                  color: Color.fromARGB(255, 255, 174, 0),
                  size: 48,
                ),
                SizedBox(width: 8),
                Text(
                  'Cooking up !',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 174, 0),
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.restaurant_menu,
              size: 30,
              color: Colors.white,
            ),
            title: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              selectedFilter('menu');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
            title: const Text(
              'Filters',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              selectedFilter('filter');
            },
          ),
        ],
      ),
    );
  }
}
