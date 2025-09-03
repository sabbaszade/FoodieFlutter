import 'package:flutter/material.dart';
import 'package:sanazmeals/dummy_data.dart';
import 'package:sanazmeals/models/meal.dart';
import 'package:sanazmeals/screens/category_meals_screen.dart';
import 'package:sanazmeals/screens/filters_screen.dart';
import 'package:sanazmeals/screens/meal_detail_screen.dart';
import 'package:sanazmeals/screens/tabs_screen.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(214, 41, 118, .1),
  100: Color.fromRGBO(214, 41, 118, .2),
  200: Color.fromRGBO(214, 41, 118, .3),
  300: Color.fromRGBO(214, 41, 118, .4),
  400: Color.fromRGBO(214, 41, 118, .5),
  500: Color.fromRGBO(214, 41, 118, .6),
  600: Color.fromRGBO(214, 41, 118, .7),
  700: Color.fromRGBO(214, 41, 118, .8),
  800: Color.fromRGBO(214, 41, 118, .9),
  900: Color.fromRGBO(214, 41, 118, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFd62976, color);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _setFilters (Map<String, bool> filterData){
setState(() {
  _filters = filterData;
  _availableMeals = DUMMY_MEALS.where((meal){
if(_filters['gluten'] && !meal.isGlutenFree){
  return false;
}
if(_filters['lactose'] && !meal.isLactoseFree){
  return false;
}
if(_filters['vegan'] && !meal.isVegan){
  return false;
}
if(_filters['vegetarian'] && !meal.isVegetarian){
  return false;
}
return true;
  }).toList();
});
  }
  
  // for favorite
  void _toggleFavorite(String mealId){
    final existingIndex = _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0){
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
      );
    });
  }
  }
  bool _isMealFavorite(String id){
    return _favoritedMeals.any((meal) => meal.id == id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanazMeals',
      theme: ThemeData(
          primarySwatch: colorCustom,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
              )),
    //  home: TabsScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals: _favoritedMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(toggleeeFavorite: _toggleFavorite,isMealFavoriteee: _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(currentFilters: _filters , saveFilters: _setFilters),
      },
    );
  }
}
