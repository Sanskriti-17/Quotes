import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/fovorite_data.dart';
import 'screens/home_screen.dart';
import 'screens/author_quote_screen.dart';
import 'screens/Search_screen.dart';
import 'screens/favorite_screen.dart';
import 'package:provider/provider.dart';
import 'screens/favorite_searched_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> FavData(),
      child: MaterialApp(
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id : (context) => HomeScreen(),
          AuthorScreen.id : (context) => AuthorScreen(),
          SearchScreen.id : (context) => SearchScreen(),
          FavoriteScreen.id : (context) => FavoriteScreen(),
          FavoriteSearchScreen.id : (context) => FavoriteSearchScreen(),
         },
      ),
    );
  }
}
