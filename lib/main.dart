import 'package:flutter/material.dart';
import 'package:recipeapp/recipe-service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  RecipeService recipeService = new RecipeService();
  callRecipe() {
    recipeService.getRecipe("chicken", 4);
  }

  @override
    Widget build(BuildContext context) {
      callRecipe();
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

