import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:flutter/services.dart';
import 'package:recipeapp/recipe-detail-row.dart';

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RecipeDetailRow(icon: Icons.access_time, context: "Cooking Time: ", recipeResult: widget.selectedRecipe.time.toStringAsFixed(0) + ' min', color: Colors.deepOrangeAccent),
            Divider(
              color: Colors.black38,
            ),
            RecipeDetailRow(icon: Icons.face, context: "Serves: ", recipeResult: widget.selectedRecipe.servings.toStringAsFixed(0), color: Colors.purple,),
            Divider(
              color: Colors.black38,
            ),
            RecipeDetailRow(icon: Icons.fastfood, context: "Calories: ", recipeResult: widget.selectedRecipe.calories.toStringAsFixed(0) + ' cal', color: Colors.amber),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
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
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                widget.selectedRecipe.recipeName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            _buildRecipeInfo(),
          ],
        ),
      ),
    );
  }
}
