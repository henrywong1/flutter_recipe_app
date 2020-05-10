import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeDetailView extends StatefulWidget {
  final String recipeUrl;
  final String recipeTitle;

  RecipeDetailView({@required this.recipeUrl, this.recipeTitle});

  @override
  _RecipeDetailViewState createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.recipeUrl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
