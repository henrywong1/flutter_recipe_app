import 'package:flutter/material.dart';

class RecipeDetailRow extends StatefulWidget {
  IconData icon;
  String context;
  String recipeResult;
  Color color;

  RecipeDetailRow({@required this.icon, this.context, this.recipeResult, this.color});

  @override
  _RecipeDetailRowState createState() => _RecipeDetailRowState();
}

class _RecipeDetailRowState extends State<RecipeDetailRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: widget.color.withAlpha(100),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: 20,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.context,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Text(
              widget.recipeResult,
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
