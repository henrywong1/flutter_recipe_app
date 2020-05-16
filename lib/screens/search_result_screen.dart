import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/screens/recipe_detail_screen.dart';


class SearchResultScreen extends StatelessWidget {
  final List<Recipe> recipeList;

  SearchResultScreen({@required this.recipeList});


  Widget _buildDetailRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildInfoContainer(Icons.whatshot, recipeList[index].calories.toStringAsFixed(0) + " CAL", Colors.orange),
          _buildInfoContainer(Icons.alarm, recipeList[index].time != 0 ? recipeList[index].time.toStringAsFixed(0) + ' MIN.' : "N/A", Colors.blueAccent),
          _buildInfoContainer(Icons.people, recipeList[index].recipeSource, Colors.green),
        ],
      ),
    );
  }
  
  Widget _buildInfoContainer(IconData iconData, String recipeInfo, Color iconColor) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(
              iconData,
              color: iconColor,
            ),
          ),
          Text(
            recipeInfo,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return RecipeDetailScreen(
                          selectedRecipe: recipeList[index]);
                    }));
              },
              child: Card(
                elevation: 10,
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Image(
                        fit: BoxFit.fitWidth,
                        height: MediaQuery.of(context).size.height / 4,
                        width: double.infinity,
                        image: NetworkImage(recipeList[index].recipeImageUrl),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        recipeList[index].recipeName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          //color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    _buildDetailRow(index),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
