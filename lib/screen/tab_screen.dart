import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favorite_provider.dart';
import 'package:meals/provider/filter_provider.dart';
import 'package:meals/provider/meal_provider.dart';

import 'package:meals/screen/category_screen.dart';
import 'package:meals/screen/filter_screen.dart';
import 'package:meals/screen/meal_screen.dart';
import 'package:meals/widget/main_drawer.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void selectFilter(String s) async {
    Navigator.pop(context);
    if (s == 'filter') {
      await Navigator.push<Map<Filter, bool>>(
          context, MaterialPageRoute(builder: (ctx) => FiltersScreen()));
      //print(result);
      //selectedFilters = result ?? selectedFilters;
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => TabScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(availableMeals);

    if (_selectedPageIndex == 1) {
      final favorMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favorMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(selectFilter),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
