import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeWebViewScreen extends StatefulWidget {
  final String recipeUrl;
  final String recipeTitle;

  RecipeWebViewScreen({@required this.recipeUrl, this.recipeTitle});

  @override
  _RecipeWebViewScreenState createState() => _RecipeWebViewScreenState();
}

class _RecipeWebViewScreenState extends State<RecipeWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.recipeUrl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
