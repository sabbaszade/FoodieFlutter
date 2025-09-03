import 'package:flutter/material.dart';
import 'package:sanazmeals/models/meal.dart';
import 'package:sanazmeals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen({this.availableMeals});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> categoryMeals;
  @override
  Widget build(BuildContext context) {
    final routeArgs =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categorytitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categorytitle),
      ),
      body: ListView.builder(itemBuilder: (ctx, index){
        return MealItem(id: categoryMeals[index].id,
          title: categoryMeals[index].title,
        imageUrl: categoryMeals[index].imageUrl,
        duration: categoryMeals[index].duration,
        affordability: categoryMeals[index].affordability,
        complexity: categoryMeals[index].complexity,);
      }, itemCount: categoryMeals.length,
      ),
    );
  }
}
