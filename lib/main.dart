import 'package:flutter/material.dart';
import 'package:recipeapp/recipe-service.dart';
import 'models/recipe.dart';
import 'package:recipeapp/recipe-detail-screen.dart';


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
        home: new HomeScreen(recipes[0])
      );
    }
}

class HomeScreen extends StatefulWidget {
  Recipe recipe;
  HomeScreen(this.recipe);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RaisedButton(
            color: Colors.blue,
            child: Text('RECIPE APP DUDE'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RecipeDetailScreen(selectedRecipe: widget.recipe);
              }));
            },
          )
      ),
    );
  }
}

