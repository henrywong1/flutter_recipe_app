import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/recipe_detail_list.dart';
import 'package:recipeapp/widgets/recipe_detail_row.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe selectedRecipe;
  RecipeDetailScreen({@required this.selectedRecipe});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Widget _buildRecipeInfo() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RecipeDetailRow(
              icon: Icons.access_time,
              context: "Cooking Time: ",
              recipeResult: widget.selectedRecipe.time > 0
                  ? widget.selectedRecipe.time.toStringAsFixed(0) + ' min'
                  : 'N/A',
              color: Colors.deepOrangeAccent),
          RecipeDetailRow(
            icon: Icons.face,
            context: "Serves: ",
            recipeResult: widget.selectedRecipe.servings.toStringAsFixed(0),
            color: Colors.purple,
          ),
          RecipeDetailRow(
              icon: Icons.fastfood,
              context: "Calories: ",
              recipeResult:
                  widget.selectedRecipe.calories.toStringAsFixed(0) + ' cal',
              color: Colors.amber),
          RecipeDetailList(
              iconData: Icons.local_dining,
              detailDescription: "Ingredients ",
              recipeDetailList: widget.selectedRecipe.ingredients,
              iconColor: Colors.red),
          RecipeDetailList(
              iconData: Icons.local_dining,
              detailDescription: "Diet ",
              recipeDetailList: widget.selectedRecipe.dietLabel,
              iconColor: Colors.red),
          RecipeDetailList(
              iconData: Icons.local_dining,
              detailDescription: "Health ",
              recipeDetailList: widget.selectedRecipe.healthLabel,
              iconColor: Colors.red),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: widget.selectedRecipe.heroTag,
                        child: Image(
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.2,
                          image: NetworkImage(
                              widget.selectedRecipe.recipeImageUrl),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 40.0),
                  child: Text(
                    widget.selectedRecipe.recipeName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                _buildRecipeInfo(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Go To Recipe',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/web-view',
                        arguments: widget.selectedRecipe.recipeUrl),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
