import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(RecipeApp());

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}
