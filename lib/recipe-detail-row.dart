import 'package:flutter/material.dart';

class RecipeDetailRow extends StatefulWidget {
  IconData icon;
  String context;
  String recipeResult;

  RecipeDetailRow({@required this.icon, this.context, this.recipeResult});

  @override
  _RecipeDetailRowState createState() => _RecipeDetailRowState();
}

class _RecipeDetailRowState extends State<RecipeDetailRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(widget.icon),
          Text(widget.context),
          Text(
            widget.recipeResult,
          ),
        ],
      ),
    );
  }
}
