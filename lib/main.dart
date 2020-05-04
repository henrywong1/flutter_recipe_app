import 'package:flutter/material.dart';
import 'package:recipeapp/recipe-service.dart';
import 'models/recipe.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Recipe>> recipes;
  bool recipeLoaded = false;

  void callRecipe() {
    RecipeService recipeService = RecipeService();
    // print('loading');
    recipes = recipeService.getRecipe("breakfast", 4);
    // print('loaded');
    // recipeLoaded = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callRecipe();
  }

  Widget recipeListView() {
    return FutureBuilder(
      future: recipes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data);
          int counter = 0; // counter used to display button at end of listview
          return Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: counter <= snapshot.data.length ? snapshot.data.length + 1 : snapshot.data.length,
              itemBuilder: (context, index) {
                if (index == snapshot.data.length) {
                  return Center(
                    child: Icon(
                      Icons.arrow_forward,
                      size: 30.0,
                    ),
                  );
                }
                Recipe recipe = snapshot.data[index];
                // print(recipe);
                return Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.height / 3.5,
                          image: NetworkImage(recipe.recipeImageUrl),
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
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return CircularProgressIndicator();
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
                  TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      hintText: 'Search for a recipe!',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Text(
                          "Breakfast",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        recipeListView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}
