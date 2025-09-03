import 'package:flutter/material.dart';
import 'package:sanazmeals/models/meal.dart';
import 'package:sanazmeals/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteeeMeals;

  FavoritesScreen({this.favoriteeeMeals});

  @override
  Widget build(BuildContext context) {
    if (favoriteeeMeals.isEmpty) {
      return Center(
        child: Text('You have no favorite yet! start adding some'),
      );
    }
    else{
      return ListView.builder(itemBuilder: (ctx, index){
        return MealItem(id: favoriteeeMeals[index].id,
          title: favoriteeeMeals[index].title,
          imageUrl: favoriteeeMeals[index].imageUrl,
          duration: favoriteeeMeals[index].duration,
          affordability: favoriteeeMeals[index].affordability,
          complexity: favoriteeeMeals[index].complexity,);
      }, itemCount: favoriteeeMeals.length,
      );
    }
  }
}
