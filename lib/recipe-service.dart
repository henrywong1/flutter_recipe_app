import 'package:recipeapp/network_request.dart';
import 'models/recipe.dart';
import 'package:recipeapp/secrets.dart';
import 'dart:io';

class RecipeService {

  Future<List<Recipe>> getRecipe(String searchTerm, int maxResults) async {
    print(Secrets.apiKey + '\n');
    print(Secrets.apiId + '\n');
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.edamam.com/search?q=$searchTerm&app_id=${Secrets.apiId}&app_key=${Secrets.apiKey}&from=0&to=$maxResults'
    );
    var recipeDetails = await networkHelper.getData();
    List<Recipe> recipeList = [];
    for (var recipe in recipeDetails["hits"]) {
      recipeList.add(new Recipe(recipe["recipe"]["label"], recipe["recipe"]["image"], recipe["recipe"]["url"]));
    }
    print(recipeList[0].recipeName);
    return recipeList;
  }

}
