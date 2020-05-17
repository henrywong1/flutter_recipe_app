import 'package:flutter/material.dart';
import 'package:recipeapp/network_service/recipe_service.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipeapp/screens/recipe_detail_screen.dart';
import 'package:recipeapp/screens/search_result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum RecipeSection { BREAKFAST, LUNCH, DINNER, DESSERT }

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkTheme = true;
  bool defaultDataLoaded = false;
  String searchQuery;
  bool searchResultLoaded = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipeSections();
  }

  Future<List<Recipe>> breakfasts;
  Future<List<Recipe>> lunch;
  Future<List<Recipe>> dinner;
  Future<List<Recipe>> dessert;

  List<Recipe> recipeSearchResult;

  Map<String, List<Recipe>> recentSearchResults;

  void _fetchRecipeSections() {
    RecipeService recipeService = RecipeService();
    breakfasts =
        recipeService.getRecipe(_getRecipeCategory(RecipeSection.BREAKFAST), 4);
    lunch = recipeService.getRecipe(_getRecipeCategory(RecipeSection.LUNCH), 4);
    dinner =
        recipeService.getRecipe(_getRecipeCategory(RecipeSection.DINNER), 4);
    dessert =
        recipeService.getRecipe(_getRecipeCategory(RecipeSection.DESSERT), 4);
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
          defaultDataLoaded = true;
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
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchResultScreen(
                                    recipeList: snapshot.data);
                              }));
                            },
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
                    String category = _getRecipeCategory(recipeSection);
                    recipe.heroTag = 'recipe-img-$category-$index';
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
                              child: Hero(
                                tag: recipe.heroTag,
                                child: Image(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.height / 4,
                                  image: NetworkImage(recipe.recipeImageUrl),
                                ),
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
        return _showSpinner(defaultDataLoaded,
            height: MediaQuery.of(context).size.height);
      },
    );
  }

  Container _showSpinner(bool loaded, {double height = 0}) {
    if (!loaded) {
      return Container(
        height: height > 0 ? height / 4 : double.infinity,
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
    }
    return Container();
  }

  Future<void> _navigateToSearchResult() async {
    RecipeService recipeService = RecipeService();
//    if (recipeSearchResult == null) {
    recipeSearchResult = await recipeService.getRecipe(searchQuery, 15);
//    } else {}
    for (int i = 0; i < recipeSearchResult.length; i++) {
      recipeSearchResult[i].heroTag = 'recipe-img-$searchQuery-$i';
    }
  }

  Future<void> _modalPopUp(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Center(
              child: Text(
                'No Result Found',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                padding: EdgeInsets.only(bottom: 20.0, right: 20.0),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
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
                            onPressed: () => defaultDataLoaded
                                ? setState(() => isDarkTheme = !isDarkTheme)
                                : null,
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Builder(
                                builder: (context) =>
                                TextField(
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (value) async {
                                    setState(() {
                                      searchResultLoaded = false;
                                    });
                                    await _navigateToSearchResult();
                                    if (recipeSearchResult != null) {
                                      setState(() {
                                        searchResultLoaded = true;
                                      });
                                    }
                                    if (recipeSearchResult.length > 0) {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return SearchResultScreen(
                                                    recipeList: recipeSearchResult);
                                              }));
                                    } else {
                                      // show alert dialog
                                      _modalPopUp(context);
                                    }
                                  },
                                  onChanged: (value) {
                                    searchQuery = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    hintText: 'Search for a recipe!',
                                    suffixIcon: Builder(
                                      builder: (context) => IconButton(
                                        icon: Icon(
                                          Icons.search,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            searchResultLoaded = false;
                                          });
                                          await _navigateToSearchResult();
                                          if (recipeSearchResult != null) {
                                            setState(() {
                                              searchResultLoaded = true;
                                            });
                                          }
                                          print(recipeSearchResult);
                                          if (recipeSearchResult.length > 0) {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SearchResultScreen(
                                                  recipeList: recipeSearchResult);
                                            }));
                                          } else {
                                            // show alert dialog
                                            _modalPopUp(context);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
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
                _showSpinner(searchResultLoaded),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme
          ? ThemeData(brightness: Brightness.light, primaryColor: Colors.black, backgroundColor: Colors.white)
          : ThemeData(brightness: Brightness.dark, primaryColor: Colors.white, backgroundColor: Colors.grey[850]),
    );
  }
}
