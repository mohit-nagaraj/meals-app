import 'package:flutter/material.dart';
import 'package:meals/data/meal_data.dart';
import 'package:meals/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(this.meal, this.selectMeal, {super.key});
  final void Function(Meal m) selectMeal;
  final Meal meal;
  String get capitalText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
        onTap: () {
          selectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        //time
                        const Icon(
                          Icons.schedule,
                          color: Color.fromARGB(190, 255, 255, 255),
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${meal.duration} min',
                          style: const TextStyle(
                            color: Color.fromARGB(190, 255, 255, 255),
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        //level
                        Icon(
                          Icons.local_fire_department,
                          color: complexityColors[meal.complexity],
                          size: 18,
                        ),
                        Text(
                          capitalText,
                          style: TextStyle(
                            color: complexityColors[meal.complexity],
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        //affordability
                        Text(
                          '${prices[meal.affordability]}',
                          style: const TextStyle(
                            color: Color.fromARGB(214, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                      /*
                      children: [
                        //time
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              color: Color.fromARGB(190, 255, 255, 255),
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${meal.duration} min',
                              style: const TextStyle(
                                color: Color.fromARGB(190, 255, 255, 255),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: complexityColors[meal.complexity],
                              size: 18,
                            ),
                            Text(
                              capitalText,
                              style: TextStyle(
                                color: complexityColors[meal.complexity],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [],
                        )
                      ],*/
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
