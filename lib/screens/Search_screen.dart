import 'package:flutter/material.dart';
import 'package:quotes/constant.dart';
import 'package:quotes/networking.dart';
import 'favorite_screen.dart';
import 'package:quotes/fovorite_data.dart';
import 'package:provider/provider.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const id='search_screen';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchedQuote;
  int listLeangth=0;
  int count=10;
  TextEditingController searchCtrl=TextEditingController();

  Future getQuotes(String data,int limit)async {
    Uri url = Uri.parse(kSearchApi+data);
    Network network = Network(url: url);
    var forCheckingLimit =await network.getData();
    print(forCheckingLimit);
    int checkCount=forCheckingLimit['count'];
    print(checkCount);
    if(checkCount<limit){
      listLeangth=checkCount;
    }else{
      listLeangth=limit;
    }
    url = Uri.parse('$kSearchApi$data&$listLeangth');
    network = Network(url: url);
    var quotes =await network.getData();
    return quotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
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
            color: Colors.grey.shade100,
            child:  Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchCtrl,
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
                    onPressed: ()async{
                      searchedQuote= await getQuotes(searchCtrl.text,count);
                      searchCtrl.clear();
                      setState((){
                      });
                    },
                    icon: Icon(Icons.search,
                      color:kMainColor,
                      size: 30,))
              ],
            ),
          ),

          ListTile(
            tileColor:kMainColor ,
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.minimize),
              onPressed: () {
                count!=1? count-- : null;
                setState(() {
                });
              },
            ),
            title: Text('$count',
            textAlign: TextAlign.center,
            style: TextStyle(
            fontWeight: FontWeight.bold
            ),),
            trailing: IconButton(
              icon: Icon(Icons.add),
                onPressed: () {
                count!=100? count++ :null;
                setState(() {
                });
                }
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text('Only $listLeangth quote available',
            style: TextStyle(
              color: Colors.black54,
            ),),
          ),

          Expanded(
            child: searchedQuote==null ? const Center(
                     child: Text('Search for quotes',
                    style:TextStyle(fontSize: 16)),
                   )
                : ListView.builder(
                  itemCount: listLeangth,
                    itemBuilder: (context, index){
                      print('builder $listLeangth');
                        return searchListItems(searchedQuote: searchedQuote,index: index,);
                    } ),
          )

        ],
      ),
    );
  }
}

class searchListItems extends StatelessWidget {
  searchListItems({
    required this.searchedQuote,
    required this.index,
  });
  final searchedQuote;
  FavData favData=FavData();
  int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      child: ListTile(
        title: Text(searchedQuote['results'][index]['author'],
        style: TextStyle(
          fontSize: 17
        ),),
      subtitle:Text( searchedQuote['results'][index]['content']),
        trailing: IconButton(
          icon: Icon(Icons.bookmark),
            onPressed: (){
            print('button pressed');
            String authName=searchedQuote['results'][index]['author'];
            String quoteContent=searchedQuote['results'][index]['content'];
            Provider.of<FavData>(context,listen: false).addFavData(authName, quoteContent);
            print('data added');
        },
        color: kMainColor,),
      ),
    );
  }
}
