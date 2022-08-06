import 'package:flutter/material.dart';
import 'package:quotes/constant.dart';
import 'package:provider/provider.dart';
import 'package:quotes/fovorite_data.dart';

class FavoriteSearchScreen extends StatefulWidget {
  const FavoriteSearchScreen({Key? key}) : super(key: key);
  static const id='favorite_search_screen';
  @override
  State<FavoriteSearchScreen> createState() => _FavoriteSearchScreenState();
}

class _FavoriteSearchScreenState extends State<FavoriteSearchScreen> {
  bool isPresent=false;
  int listCount=0;
  FavoriteListItems SearchFavList(context, index){
    print('builder of fav search');
    var item= Provider.of<FavData>(context).favSearchList[index];
    print(item);
    var author=item[Provider.of<FavData>(context).author];
    var quote=item[Provider.of<FavData>(context).quote];
    return FavoriteListItems(author: author, quote:quote,index:index );
  }

 TextEditingController searchbarCtrl=TextEditingController();
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

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color: Colors.grey.shade100,
            child:  Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchbarCtrl,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        )
                    ),
                  ),
                ),

                IconButton(
                    onPressed: (){
                      print('button pressed');
                      searchbarCtrl.text.isEmpty? null
                          : {isPresent=Provider.of<FavData>(context,listen: false).searchFor(searchbarCtrl.text)};
                      setState(() {

                        isPresent? {listCount=Provider.of<FavData>(context,listen: false).favSearchListLength}
                            :{listCount=0};
                        searchbarCtrl.clear();
                      });
                    },
                    icon: Icon(Icons.search,
                      color:kMainColor,
                      size: 30,))
              ],
            ),
          ),

          Expanded(
             child: ListView.builder(
                itemCount:listCount,
                itemBuilder: SearchFavList,
              ),
          ),

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
            Provider.of<FavData>(context,listen: false).deleteFromSearchList(index);
          },
          color: kMainColor,
        ),
      ),
    );
  }
}
