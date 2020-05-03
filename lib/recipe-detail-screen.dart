import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:flutter/services.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe selectedRecipe;

  RecipeDetailScreen({@required this.selectedRecipe});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Image(
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.2,
                      image: NetworkImage(widget.selectedRecipe.recipeImageUrl),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.selectedRecipe.recipeName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
