import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/database/save_accounts_db.dart';
import 'package:Filerole/model/pojo/MasterAccountModel.dart';
import 'package:Filerole/model/providers/LanguageProvider.dart';
import 'package:Filerole/ui/master/master_main/MasterMainScreen.dart';
import 'package:Filerole/ui/notifications/notification_screen.dart';
import 'package:Filerole/util/SaveAccountsSharedPref.dart';
import 'package:Filerole/util/ToastHelper.dart';
import 'package:Filerole/util/check_network_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SavedAccountsScreen extends StatefulWidget {
  @override
  _SavedAccountsScreenState createState() => _SavedAccountsScreenState();
}

class _SavedAccountsScreenState extends State<SavedAccountsScreen> {
  var acountsDb = SavedAccountsDb();

  List<MasterAccountModel> masterAccountsArr = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrGreen2,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              indent: double.infinity,
              height: 15,
              endIndent: double.infinity,
            ),
            logoWidget(),
            Divider(
              indent: double.infinity,
              height: 28,
              endIndent: double.infinity,
            ),
            (masterAccountsArr.isNotEmpty)
                ? accountsListWidgets()
                : FutureBuilder<bool>(
                    future: gettingData(), // asyncdownloadData  work
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text('Loading....');
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else {
                            if (snapshot.data!) {
                              return accountsListWidgets();
                            } else {
                              return Container(
                                width: 300,
                                height: 150,
                                child: Card(
                                    elevation: 5,
                                    child: Center(
                                        child: Text(
                                      'No Accounts Saved',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                    ))),
                              );
                            }
                          }
                      }
                    },
                  ),
            addNewAccBtn(),
          ],
        ),
      ),
    );
  }

  Widget logoWidget() {
    return Image(
      width: 150,
      color: Colors.white,
      image: AssetImage(
        'assets/filerolebanner.png',
      ),
    );
  }

  Widget accountsListWidgets() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(height: 7, color: Colors.transparent),
          itemCount: masterAccountsArr.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 100,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          VerticalDivider(
                            width: 5,
                          ),
                          Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    //  prefss.deleteingAccounts(index);

                    setState(() {
                      acountsDb.removeAccount(masterAccountsArr[index]);
                      masterAccountsArr.removeAt(index);
                    });
                  },
                  child: ListTile(
                    onTap: () => loginMaster(masterAccountsArr[index]),
                    leading: Image.network(
                      masterAccountsArr[index].img!,
                      height: 80,
                      width: 80,
                    ),
                    title: Text(
                      masterAccountsArr[index].name!,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(masterAccountsArr[index].domain!,
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addNewAccBtn() {
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 15),
      child: FlatButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        padding: EdgeInsets.symmetric(horizontal: 30),
        height: 45,
        icon: Icon(Icons.add),
        //icon image
        label: Text(
          'Add a New Account',
          style: TextStyle(fontWeight: FontWeight.bold, wordSpacing: 1.5),
        ), //text to show in button
        textColor: Colors.white, //button text and icon color.
        color: Colors.black54, //button background color
        onPressed: () {
          Navigator.pushNamed(context, 'login');
        },
      ),
    );
  }

  Future<bool> gettingData() async {
    masterAccountsArr = acountsDb.getSavedAccounts();
    if (masterAccountsArr.isEmpty) {
      //data  not saved  yet
      return false;
    } else {
      return true;
    }
  }

  void loginMaster(MasterAccountModel masterAccount)async {
    // print(masterAccount.password??'a8a');
   
    await StaticMasterClient.client
        .loginService(
      mail: masterAccount.email!,
      pass: masterAccount.password!,
      serverUrl: masterAccount.domain!,
      type: masterAccount.userType??'owner',
    )
        .then(
          (response) {
      //checking status code
      if (checkNetworkResponseStatusCode(response)) {
        //checking User Type
        if (response?['userType'] == 'owner') {
          StaticUserVar.userAccount 
          
            ..accessToken = response?['token']
            ..domain = response?['url']
            ..name =
                response?['user']['name'] + ' ' + response?['user']['name_en']
            ..firstName = response?['user']['name']
            ..lastName = response?['user']['name_en']
             ..email = response?['user']['email']
            ..phoneNumber = response?['user']['phone_number'].toString()
            ..img = response?['user']['profile_image'];
          //posting device Fcm token
          FirebaseMessaging.instance.getToken().then((tokenFcm) {
            if (tokenFcm != null) {
              
              StaticMasterClient.client
                  .tokenFcmService(
                      token: StaticUserVar.userAccount.accessToken!,
                      tokenFcm: tokenFcm)
                  .then((response) {
                                  print('fcmm$response');
                
              });
            }
          });

          createToast(response?['message'],
              colour: Colors.greenAccent.withOpacity(0.6));

          //save account in Local Db
          SavedAccountsDb()..addAccount(StaticUserVar.userAccount);

          toMasterScreen();
        }  
      } else {
        createToast(response?['errors'] ?? 'Something went wrong!',
            colour: Colors.red.withOpacity(0.6));
      }
    }).catchError((error) {
      //  createToast(error.toString());
      createToast('Check your network connection');
    });
     

   
  }
  toMasterScreen(){
 //checking current lang then redirect to Home Screen
    Provider.of<LanguageProvider>(context, listen: false)
        .initChangeLangUtil()
        .then((value) {
      Navigator.pushReplacementNamed(context, 'master_main');
    });
  }
}
