import 'package:flutter/material.dart';

class RecipeDetailList extends StatelessWidget {
  final IconData iconData;
  final String detailDescription;
  final List<dynamic> recipeDetailList;
  final Color iconColor;

  RecipeDetailList(
      {@required this.iconData,
      this.detailDescription,
      this.recipeDetailList,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return recipeDetailList.length > 0 ? Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  detailDescription,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: recipeDetailList
                        .map(
                          (recipeDetail) => Container(
                            width: recipeDetailList.length > 3 ? MediaQuery.of(context).size.width / 3 : MediaQuery.of(context).size.width / (recipeDetailList.length + (recipeDetailList.length / 10)),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
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
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    ) : Container();
  }
}
