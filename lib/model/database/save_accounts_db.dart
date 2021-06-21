import 'dart:io';

import 'package:Filerole/model/pojo/MasterAccountModel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

 
class SavedAccountsDb {
  String boxName = 'saved_accounts';

  initHiveDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    Hive.registerAdapter<MasterAccountModel>(MasterAccountModelAdapter());
    Hive.openBox(boxName);
  }

  bool checkAccountExist(String url) {
    return Hive.box(boxName).containsKey(url);
  }

  addAccount(MasterAccountModel account) {
    if (!checkAccountExist(account.domain!)) {
      Hive.box(boxName).put(account.domain, account);
    }
  }

  removeAccount(MasterAccountModel account) {
    account.delete();
     
  }

  List<MasterAccountModel> getSavedAccounts() {
    List<MasterAccountModel> list = List<MasterAccountModel>.empty(
      growable: true,
    );

    Hive.box(boxName).toMap().forEach((key, value) {
      if (value != null) list.add(value);
    });
    return list;
  }
}
