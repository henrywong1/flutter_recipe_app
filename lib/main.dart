import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/routes/router_generator.dart';
import 'package:recipeapp/themes/theme_manager.dart';
import 'screens/home_screen.dart';

void main() => runApp(ChangeNotifierProvider<ThemeManager>(
    builder: (context) => ThemeManager(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: Provider.of<ThemeManager>(context).themeData,
    );
  }
}
