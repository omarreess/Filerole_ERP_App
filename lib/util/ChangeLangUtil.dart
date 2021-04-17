
//current app language
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangeLangUtil {

  SharedPreferences prefs ;

  String currentAppLanguage;

  ChangeLangUtil ({this.currentAppLanguage});

  Future<String> initShPref() async {

      prefs =  await  SharedPreferences.getInstance();
      if(_checkDataExist())
      {
        return currentAppLanguage = _getCurrentLang();
      }
      else {
        return  currentAppLanguage = AppLanguages.en.toShortString();
      }



  }

  bool  _checkDataExist()  {

    return  prefs.containsKey('appLang') ;

  }

  String   _getCurrentLang(){

     return  prefs.getString('appLang');

  }

  Future<bool> changeLang ({@required String lang  } ) async{
   if (currentAppLanguage != lang )
     {
       await _saveLang(lang).then(
               (value) {
                 return true ;
               }
       );

     }
   else {return false ;}

 }

  Future<void> _saveLang(String lang ) async{
     prefs.setString('appLang', lang);
 }

}


//constant languages names
enum AppLanguages {
  ar,
  en
}
extension ParseToString on AppLanguages {

  String toShortString() {
    return this.toString().split('.').last;
  }


}


