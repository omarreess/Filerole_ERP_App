
import 'package:Filerole/model/Constants.dart';
import 'package:Filerole/model/MasterAccountModel.dart';
import 'package:Filerole/util/SaveAccountsSharedPref.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class SavedAccountsScreen extends StatefulWidget {
  @override
  _SavedAccountsScreenState createState() => _SavedAccountsScreenState();
}

class _SavedAccountsScreenState extends State<SavedAccountsScreen> {


  List<MasterAccountModel> masterAccountsArr = List();
  Map<String , dynamic> userMap ;
  SharedPreferences prefs;
  SaveAccountsSharedPref prefss;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: clrBackground,
      body:  SafeArea(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Divider(indent: double.infinity, height: 15,endIndent: double.infinity,) ,

             logoWidget(),

             Divider(indent: double.infinity, height: 28,endIndent: double.infinity,) ,



         (masterAccountsArr.isNotEmpty)? accountsListWidgets()  :
         FutureBuilder<bool>(
           future: gettingData() , // asyncdownloadData  work
           builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
             switch (snapshot.connectionState) {
               case ConnectionState.waiting: return Text('Loading....');
               default:
                 if (snapshot.hasError)
                   return Text('Error: ${snapshot.error}');
                 else
                 {
                   if (snapshot.data){
                     return accountsListWidgets();
                   }else{
                     return  Container(
                       width: 300,
                       height:  150,
                       child: Card(elevation: 5,
                           child: Center(child: Text('No Accounts Saved', style: TextStyle(fontSize: 18,color: Colors.black54),) )),
                     );
                   }

                 }

             }
           },
         )   ,

             addNewAccBtn(),






           ],) ,
      ),
    );

  }

  Widget logoWidget (){
    return Image(width: 150,color: Colors.black45,
      image: AssetImage('assets/filerolebanner.png' , ),
    );
  }

  Widget accountsListWidgets (){
    return    Expanded(
      child: Container(

        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),

        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(
                  height: 7,
                  color:Colors.transparent               ),
          itemCount: masterAccountsArr.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(0),
            child:
            Container(
              height: 100,

              child: Card(

                elevation: 1,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child:

                Dismissible(
                  direction:  DismissDirection.endToStart,
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
                            VerticalDivider(width: 5,),
                            Text(
                              'Delete Account',
                              style: TextStyle(color: Colors.white ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    prefss.deleteingAccounts(index);



                    setState(
                             ()   {
                      masterAccountsArr.removeAt(index);
                     });


                  },
                    child: ListTile(
                       leading:   Image.network(masterAccountsArr[index].img ,  height: 80,  width: 80 ,  )   ,
                    title: Text(masterAccountsArr[index].storeName , style: TextStyle(fontSize: 20),),
                    subtitle: Text(masterAccountsArr[index].domain , style: TextStyle(fontSize: 15) ),
                ),
                  ),



              ),
            )
            ,
          ),
        ),
      ),
    );
  }

  Widget addNewAccBtn(){
    return Container(
      padding: EdgeInsets.only(bottom:40,top: 15 ),
      child: FlatButton.icon(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),


        padding: EdgeInsets.symmetric(horizontal: 30),
        height: 45,
        icon: Icon(Icons.add),
        //icon image
        label: Text('Add a New Account', style: TextStyle(fontWeight: FontWeight.bold,wordSpacing: 1.5),),//text to show in button
        textColor: Colors.white,//button text and icon color.
        color: clrGreen3,//button background color
        onPressed: () {
          setState(
                  () {

          });
        },
      ),
    ) ;
  }



  Future<bool> gettingData () async {
    prefss = SaveAccountsSharedPref();
    await prefss.initShPref();

    if (prefss.checkDataExist()) {


    userMap =  prefss.getSavedAccounts();

    userMap.forEach((key, value) {
      masterAccountsArr
        ..add(MasterAccountModel(domain: value['domain'] , storeName:value['storeName'] , img:  value['img']));


    });


  return true ;
    }
    else {
       //data  not saved  yet
      return false ;
       }
  }



}


