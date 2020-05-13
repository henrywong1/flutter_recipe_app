import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';

class SearchResultScreen extends StatelessWidget {
  final List<Recipe> recipeList;

  SearchResultScreen({@required this.recipeList});

  Widget _buildDetailRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildInfoContainer(Icons.whatshot, recipeList[index].calories.toStringAsFixed(0) + " CAL"),
          _buildInfoContainer(Icons.alarm, recipeList[index].time != 0 ? recipeList[index].time.toStringAsFixed(0) + ' MIN.' : "N/A"),
        ],
      ),
    );
  }
  
  Widget _buildInfoContainer(IconData iconData, String recipeInfo) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: Row(
        children: <Widget>[
          Icon(iconData),
          Text(recipeInfo),
        ],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: double.infinity,
                    image: NetworkImage(recipeList[index].recipeImageUrl),
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
          );
        },
      ),
    );
  }
}
