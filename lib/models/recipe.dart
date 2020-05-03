class Recipe {
  String recipeName;
  String recipeImageUrl;
  String recipeUrl;
  double calories;
  List<dynamic> ingredients;
  double servings;
  double time;
  List<dynamic> healthLabel;
  List<dynamic> dietLabel;

  Recipe(
      {this.recipeName,
      this.recipeImageUrl,
      this.recipeUrl,
      this.calories,
      this.ingredients,
      this.servings,
      this.time,
      this.healthLabel,
      this.dietLabel});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        recipeName: json['recipe']['label'],
        recipeImageUrl: json['recipe']['image'],
        recipeUrl: json['recipe']['url'],
        calories: json['recipe']['calories'],
        ingredients: json['recipe']['ingredientLines'],
        servings: json['recipe']['yield'],
        time: json['recipe']['totalTime'],
        healthLabel: json['recipe']['healthLabels'],
        dietLabel: json['recipe']['dietLabels']);
  }

  String toString() {
    return 'Recipe Name: $recipeName\n img: $recipeImageUrl\n url: $recipeUrl\n calories: $calories\n ingredients: $ingredients\n time:$time';
  }
}
