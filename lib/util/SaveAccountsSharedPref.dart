

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SaveAccountsSharedPref {
  SharedPreferences prefs ;
  Map< String , dynamic > userMap;

 Future<void> initShPref() async {
           prefs =  await  SharedPreferences.getInstance();

 }

  void savingAccount () async {

    await initShPref() ;
    if ( checkDataExist()   ) {

      //getting saved account to know the index to increment then setting new account
      userMap =  getSavedAccounts();


      //mock data
      userMap[ ( int.parse(userMap.keys.last)+1).toString()] =
      {
        'img':'https://api.time.com/wp-content/uploads/2018/08/thrift-stores.jpg?w=800&quality=85'       ,
        'storeName': ' ${userMap.length.toString()} Market Shop',
        'domain' :'omar.store.com'  }  ;
      print('kkkk ${( int.parse(userMap.keys.last)).toString()}');

      //saving new accounts
      await prefs.setString('userAccounts', jsonEncode(userMap));
      print('aaaa ${userMap['0']['storeName']} ') ;
    }
    else {
      //setting for 1st time
      _saveForFirstTime();





    }




  }
  void deleteingAccounts( int index ) async {

    //clearing sh pref then re-saving
    userMap.remove(index.toString());

    await    prefs.clear();

    if(userMap.isNotEmpty){ await    prefs.setString('userAccounts', jsonEncode(userMap));}


  }

  bool  checkDataExist()  {
    return  prefs.containsKey('userAccounts') ;
  }
  Map< String , dynamic>  getSavedAccounts(){

    //gettin data  first
    String  userPref =   prefs.getString('userAccounts');
    return jsonDecode(userPref) as Map<String, dynamic>;

  }

  void _saveForFirstTime () async {

    userMap =  {
      '0':
      {'img':'https://api.time.com/wp-content/uploads/2018/08/thrift-stores.jpg?w=800&quality=85'       ,
        'storeName': 'Market Shop',
        'domain' :'omar.store.com'  }
    };

    await prefs.setString('userAccounts', jsonEncode(userMap));

  }
}