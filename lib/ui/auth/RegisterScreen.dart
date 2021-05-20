//
//
//
// import 'package:Filerole/model/Constants.dart';
// import 'package:Filerole/ui/offline/OfflineScreen.dart';
// import 'package:Filerole/util/NetworkCheckUtil.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// import 'InAppBrowser.dart';
//
// class RegisterScreen extends StatelessWidget {
//   final String url = 'https://filerole.com/register';
//   final MyInAppBrowser browser = new MyInAppBrowser();
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     //Always Checking Internet Connection with redirecting to WebPage
//     browser.openUrl(url: url);
//
//     return Scaffold(
//        body:
//
//     );
//
//   }
//   //we un use it this time cause of unsporrted null safety
//   Widget registerScreenBodyWithNetworkCheck ()=>StreamBuilder(
//     stream: networkStatusStream(),
//     builder: (BuildContext context, snapshot) {
//       if ( snapshot.hasData) {
//         checkNetworkStatus(snapshot.data);
//       }
//       if(netState){
//
//         return Container(color: clrGrey,);
//       }
//       else {
//         browser.hide();
//         return     OfflineScreen();
//
//       }
//
//     },       ) ;
//   Widget registerScreenBody ()=>StreamBuilder(
//     stream: networkStatusStream(),
//     builder: (BuildContext context, snapshot) {
//       if ( snapshot.hasData) {
//         checkNetworkStatus(snapshot.data);
//       }
//       if(netState){
//
//         return Container(color: clrGrey,);
//       }
//       else {
//         browser.hide();
//         return     OfflineScreen();
//
//       }
//
//     },       ) ;
// }
