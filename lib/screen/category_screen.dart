import 'package:flutter/material.dart';

import 'package:meals/data/category_data.dart';
import 'package:meals/data/meal_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/widget/category_item.dart';
import 'package:meals/screen/meal_screen.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen(this.availableMeals, {super.key});
  List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationControl;

  @override
  void initState() {
    super.initState();
    _animationControl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationControl.forward();
  }

  @override
  void dispose() {
    _animationControl.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredlist = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.name, meals: filteredlist),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationControl,
        child: GridView(
          padding: const EdgeInsets.all(24),
          clipBehavior: Clip.hardEdge,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
            for (final category in availableCategories)
              CategoryItem(
                category,
                () {
                  _selectCategory(context,
                      category); //using the same category from the loop
                },
              )
          ],
        ),
        builder: (context,
                child) => //Padding(padding: EdgeInsets.only(top: 50 - _animationControl.value * 50),child: child)
            SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.2),
                end: const Offset(0, 0),
              ).animate(CurvedAnimation(
                  parent: _animationControl, curve: Curves.easeOut)),
              child: child,
            ));
  }
}
