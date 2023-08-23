import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(this.category, this.onSelect, {super.key});
  final Category category;

  final void Function() onSelect;
  @override
  Widget build(context) {
    return InkWell(
      onTap: onSelect,
      splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.45),
              category.color.withOpacity(1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(category.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
