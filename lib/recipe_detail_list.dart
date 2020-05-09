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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              detailDescription,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: recipeDetailList
                    .map(
                      (recipeDetail) => Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        //color: Colors.white,
                        elevation: 2,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              recipeDetail,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            )],
        ),
      ),
    );
  }
}
