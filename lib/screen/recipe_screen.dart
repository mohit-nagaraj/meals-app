import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/provider/favorite_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/filter_provider.dart';

class RecipeScreen extends ConsumerWidget {
  RecipeScreen(this.meal, {super.key});
  final Meal meal;
  @override
  Widget build(context, WidgetRef ref) {
    bool isFav = ref.watch(favoriteMealsProvider).contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? 'Added to favorites'
                        : 'Removed from favorites')));
              },
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Icon(
                  isFav ? Icons.star : Icons.star_border_outlined,
                  key: ValueKey(isFav),
                ),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                    child: RotationTransition(
                      turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                      child: child,
                    ),
                  );
                  /*RotationTransition(
                    turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                    child: child,
                  ); */
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Hero(
                tag: meal.id,
                child: Container(
                  child: Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  clipBehavior: Clip.hardEdge,
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Text(
                'Ingredients',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 157, 64),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...meal.ingredients.map((e) => Text(
                    e,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 162, 162, 162),
                      fontSize: 13,
                    ),
                  )),
              SizedBox(height: 16),
              Text(
                'Steps',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 157, 64),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...meal.steps.map((e) => Text(
                    e,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 162, 162, 162),
                      fontSize: 13,
                    ),
                  )),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
