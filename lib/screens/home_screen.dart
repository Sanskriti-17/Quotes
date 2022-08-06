import 'package:flutter/material.dart';
import 'package:quotes/constant.dart';
import 'package:quotes/screens/Search_screen.dart';
import 'author_quote_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const id='home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote'),
        centerTitle: true,
        backgroundColor: kMainColor,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, FavoriteScreen.id);
              },
              icon: Icon(
                  Icons.bookmark,
                color: Colors.white,
              ),
          tooltip: 'Favorite',)
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SimpleButton(label: 'Author Quote',
                  onpressed: (){Navigator.pushNamed(context, AuthorScreen.id);}),
              const SizedBox(
                height: 20,
              ),
              SimpleButton(label: 'Search any Quote',
                  onpressed: (){Navigator.pushNamed(context, SearchScreen.id);}),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  SimpleButton({required this.label, required this.onpressed});
  String label;
  VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
          elevation: 3,
          color: kMainColor,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 17
          ),
          child: MaterialButton(
            onPressed: onpressed,
            minWidth: 500,
            child: Text(label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),),
          ),

      ),
    );
  }
}