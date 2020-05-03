import 'package:flutter/material.dart';
import 'package:recipeapp/recipe-service.dart';
import 'models/recipe.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  List<Recipe> recipes;

  void callRecipe() async {
    RecipeService recipeService = RecipeService();
    recipes = await recipeService.getRecipe("chicken", 4);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callRecipe();
  }

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'RECIPE APP DUUDE',
            ),
          ),
        ),
      );
    }
}

