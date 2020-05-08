import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeDetailList extends StatelessWidget {
  IconData iconData;
  String detailDescription;
  List<dynamic> recipeDetailList;
  Color iconColor;

  RecipeDetailList(
      {@required this.iconData,
      this.detailDescription,
      this.recipeDetailList,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: iconColor.withAlpha(100),
                  ),
                  child: Icon(
                    iconData,
                    size: 34,
                    color: iconColor,
                  ),
                ),
                Text(
                  detailDescription,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: recipeDetailList
                .map(
                  (recipeDetail) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      title: Text(
                        recipeDetail,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
