




import 'package:Filerole/util/ChangeLangUtil.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {

  //initialized with en language
  String languageApp = AppLanguages.en.toShortString();
  ChangeLangUtil changeLangUtil  ;

  Future<void> initChangeLangUtil(  ) async {
      changeLangUtil = ChangeLangUtil(currentAppLanguage: languageApp);
       changeLang( await changeLangUtil.initShPref());
  }

  void changeLang(String lang) async {
    //await changeLangUtil??initChangeLangUtil() ;

    changeLangUtil.changeLang(lang: lang).then(
            (value)
        {
          languageApp = lang;
          notifyListeners();
        }
        );

  }

}