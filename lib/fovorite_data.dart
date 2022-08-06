import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavData extends ChangeNotifier{
  final String _author= "author";
  final String _quote="quote";



  List<Map> _FavListData=[];
  List<Map> _favSearchList=[];

   List<Map> get FavListData {
    return _FavListData;
  }
  List<Map> get favSearchList{
     return _favSearchList;
  }
  String get author{
     return _author;
  }
  String get quote{
     return _quote;
  }
  int get FavListLength{
     return _FavListData.isNotEmpty? _FavListData.length : 0;
  }

  int get favSearchListLength{
    return _FavListData.isNotEmpty? _FavListData.length : 0;
  }

  void addFavData(String auth, String content){

        Map<String,dynamic> FavMap={
          _author : auth,
          _quote :content,
        };
        FavListData.add(FavMap);
        notifyListeners();
  }

   bool searchFor (String word){
     bool isPresent=false;
       for (var item in _FavListData) {
         print('adding data');
         var itemQuote = item[_quote];
         RegExp exp = RegExp("\\b" + word + "\\b", caseSensitive: false);
         isPresent = exp.hasMatch(itemQuote);
         print(isPresent);
         if (isPresent) {
           _favSearchList.add(item);
         }
     }
     notifyListeners();
       return isPresent;
  }
  void deleteFromFavItem(int index){
     _FavListData.removeAt(index);
     notifyListeners();
  }

  void deleteFromSearchList(int index){
    for(var item in _FavListData){
      if(item[_quote]==_favSearchList[index][quote]){
        _FavListData.remove(item);
        _favSearchList.removeAt(index);
        notifyListeners();
      }
    }
  }

  void deleteAllFromFavList(){
    _FavListData.clear();
    notifyListeners();
  }

}

