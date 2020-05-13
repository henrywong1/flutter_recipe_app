import 'package:flutter/material.dart';
import 'package:recipeapp/network_service/recipe_service.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipeapp/screens/recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum RecipeSection { BREAKFAST, LUNCH, DINNER, DESSERT }

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkTheme = true;
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchRecipeSections();
  }

  Future<List<Recipe>> breakfasts;
  Future<List<Recipe>> lunch;
  Future<List<Recipe>> dinner;
  Future<List<Recipe>> dessert;

  void _fetchRecipeSections() {
    RecipeService recipeService = RecipeService();
    breakfasts = recipeService.getRecipe(_getRecipeCategory(RecipeSection.BREAKFAST), 4);
    lunch = recipeService.getRecipe(_getRecipeCategory(RecipeSection.LUNCH), 4);
    dinner = recipeService.getRecipe(_getRecipeCategory(RecipeSection.DINNER), 4);
    dessert = recipeService.getRecipe(_getRecipeCategory(RecipeSection.DESSERT), 4);
  }

  Future<List<Recipe>> _getRecipeList(RecipeSection recipeSection) {
    switch (recipeSection) {
      case RecipeSection.BREAKFAST:
        return breakfasts;
      case RecipeSection.LUNCH:
        return lunch;
      case RecipeSection.DINNER:
        return dinner;
      case RecipeSection.DESSERT:
        return dessert;
    }
    return null;
  }

  String _getRecipeCategory(RecipeSection recipeSection) {
    switch (recipeSection) {
      case RecipeSection.BREAKFAST:
        return 'Breakfast';
      case RecipeSection.LUNCH:
        return 'Lunch';
      case RecipeSection.DINNER:
        return 'Dinner';
      case RecipeSection.DESSERT:
        return 'Dessert';
    }
    return '';
  }

  Widget _buildRecipeListView(RecipeSection recipeSection) {
    return FutureBuilder(
      future: _getRecipeList(recipeSection),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dataLoaded = true;
          int counter = 0; // counter used to display button at end of listview
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _getRecipeCategory(recipeSection),
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: counter <= snapshot.data.length
                      ? snapshot.data.length + 1
                      : snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (index == snapshot.data.length) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward,
                              size: 30.0,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4 / 2,
                          ),
                        ],
                      );
                    }
                    Recipe recipe = snapshot.data[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return RecipeDetailScreen(
                                      selectedRecipe: recipe);
                                }),
                              ),
                              child: Image(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.height / 4,
                                image: NetworkImage(recipe.recipeImageUrl),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 200.0,
                            child: Text(
                              '${recipe.recipeName}',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w600),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.2,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Center(
            child: SpinKitWave(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                      color: index.isEven ? Colors.white54 : Colors.black38,
                      borderRadius: BorderRadius.circular(20.0)),
                );
              },
              size: 100.0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        disabledColor: Colors.blueGrey[300],
                        icon: Icon(
                          Icons.lightbulb_outline,
                          size: 30,
                        ),
                        onPressed: () => dataLoaded ? setState(() => isDarkTheme = !isDarkTheme) : null,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              hintText: 'Search for a recipe!',
                              suffixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(),
                      children: <Widget>[
                        _buildRecipeListView(RecipeSection.BREAKFAST),
                        _buildRecipeListView(RecipeSection.LUNCH),
                        _buildRecipeListView(RecipeSection.DINNER),
                        _buildRecipeListView(RecipeSection.DESSERT),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme
          ? ThemeData(brightness: Brightness.dark, primaryColor: Colors.white)
          : ThemeData(brightness: Brightness.light, primaryColor: Colors.black),
    );
  }
}
