import 'package:flutter/material.dart';
import 'package:quotes/constant.dart';
import 'package:provider/provider.dart';
import 'package:quotes/fovorite_data.dart';
import 'favorite_searched_screen.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const id='favorite_screen';
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  TextEditingController favSearchCtrl=TextEditingController();
  bool isItemSearched=false;

  FavoriteListItems normalFavList(context, index){
  print('builder');
  var item= Provider.of<FavData>(context).FavListData[index];
  print(item);
  var author=item[Provider.of<FavData>(context).author];
  var quote=item[Provider.of<FavData>(context).quote];
  return FavoriteListItems(author: author, quote:quote,index:index );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),

      body: Column(
        children: [

          GestureDetector(
            onTap: (){
                Navigator.pushNamed(context, FavoriteSearchScreen.id);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              color: Colors.grey.shade100,
              child:  Row(
                children: [
                  Expanded(
                    child: Text(
                            'Search',
                            style: TextStyle(
                            color: kMainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                      ),
                    ),
                     Icon(
                     Icons.search,
                     color:kMainColor,
                     size: 30,)
                     ]
              )

                  ),
          ),

          Expanded(
            child: ListView.builder(
            itemCount:Provider.of<FavData>(context).FavListLength,
            itemBuilder: normalFavList,
            ),
          ),


          Container(
            child: MaterialButton(
              onPressed: (){
                Provider.of<FavData>(context,listen: false).deleteAllFromFavList();
              },
              child: Text('Delete All',
              style: TextStyle(
                color: kMainColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
            ),
          )
        ],
      ),
    );
  }
}


class FavoriteListItems extends StatelessWidget {
  FavoriteListItems({
    required this.author,
    required this.quote,
    required this.index
  });

  final String author;
  final String quote;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      child: ListTile(
        title: Text(author,
          style: TextStyle(
              fontSize: 17
          ),),
        subtitle:Text(quote),
          trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: (){
            Provider.of<FavData>(context,listen: false).deleteFromFavItem(index);
          },
          color: kMainColor,),
      ),
    );
  }
}
