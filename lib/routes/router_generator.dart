import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/screens/home_screen.dart';
import 'package:recipeapp/screens/recipe_detail_screen.dart';
import 'package:recipeapp/screens/recipe_web_view_screen.dart';
import 'package:recipeapp/screens/search_result_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // arguments passed in Navigator.pushNamed
    final args = settings.arguments;
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/results':
        // Check if passed in data to route is of type List<Recipe>
        if (args is List<Recipe>) {
          return MaterialPageRoute(builder: (_) => SearchResultScreen(
            recipeList: args,
          ));
        }
        break;
      case '/details':
        if (args is Recipe) {
          return MaterialPageRoute(builder: (_) => RecipeDetailScreen(
            selectedRecipe: args,
          ));
        }
        break;
      case '/web-view':
        return MaterialPageRoute(builder: (_) => RecipeWebViewScreen(
          recipeUrl: args,
        ));
    }
  }


}