import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/recipe_screen.dart';
import 'package:meals/widget/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => RecipeScreen(meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try something new ヾ(≧▽≦*)o',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meals[index],
          (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/recipe_screen.dart';
import 'package:meals/widget/meal_item.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({required this.title, required this.meals, super.key});

  final String title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal m) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => RecipeScreen(m)));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: (meals.isNotEmpty)
          ? ListView.builder(
              itemCount: meals.length,
              itemBuilder: (ctx, index) {
                MealItem(meals[index], (m) {
                  selectMeal(context, m);
                });
              },
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('UhOh!...Nothing to display',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  SizedBox(height: 8),
                  Text('Select another category',
                      style: TextStyle(
                          color: const Color.fromARGB(153, 255, 255, 255),
                          fontSize: 12)),
                ],
              ),
            ),
    );
  }
}
*/