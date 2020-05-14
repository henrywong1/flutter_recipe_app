import 'package:recipeapp/network_service/network_request.dart';
import '../models/recipe.dart';
import 'package:recipeapp/secrets.dart';

class RecipeService {
  Future<List<Recipe>> getRecipe(String searchTerm, int maxResults) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.edamam.com/search?q=$searchTerm&app_id=${Secrets.apiId}&app_key=${Secrets.apiKey}&from=0&to=$maxResults');
    var recipeDetails = await networkHelper.getData();

    List<Recipe> recipeList = [];
    for (var recipe in recipeDetails["hits"]) {
      recipeList.add(Recipe.fromJson(recipe));
    }

    return recipeList;
  }
}
