import 'package:flutter/material.dart';
import 'package:quotes/constant.dart';
import 'package:quotes/networking.dart';
import 'favorite_screen.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({Key? key}) : super(key: key);
  static const id= 'author_screen';

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {

  dynamic bio;
  TextEditingController authorNameCtrl= TextEditingController();

  Future getAuthorQuotes(String author)async {
    Uri url = Uri.parse('$kAuthorApi$author');
    Network network = Network(url: url);
    var quote = await network.getData();
    return quote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author Quote'),
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

      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
      Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: kCardColor,
      child:  Row(
        children: [
          Expanded(
            child: TextField(
              controller: authorNameCtrl,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Author name',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  )
              ),
            ),
          ),

          IconButton(
              onPressed: ()async{
                bio= await getAuthorQuotes(authorNameCtrl.text);
                authorNameCtrl.clear();
                print(bio['results'][0]['name']);
                setState((){
                });
              },
              icon: Icon(Icons.search,
                color:kMainColor,
                size: 25,))
        ],
      ),
    ),

      Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Card(
              color: kCardColor,
              elevation: 2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(bio !=null ? bio['results'][0]['name'] :' ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: kMainColor,
                  ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(bio !=null ? bio['results'][0]['bio'] : 'No Author searched',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                     fontSize: 20,
                      color: Colors.black87
      ),),
                  ),
                ],
              ),
            ),
    ))
    ],
    ),
    );
  }
}
