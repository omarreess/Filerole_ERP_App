
import 'package:Filerole/model/Constants.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';

import 'InAppBrowser.dart';
import 'dart:io';



class AuthIntroScreen extends StatelessWidget {


  var options = InAppBrowserClassOptions(


      crossPlatform: InAppBrowserOptions(hideUrlBar: true , toolbarTopBackgroundColor: clrBackground2,hideToolbarTop: true ,hidden: false),
      android: AndroidInAppBrowserOptions(allowGoBackWithBackButton: true,hideTitleBar: true, ),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ))
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:    clrGrey ,

      body: SafeArea(

          child:
          LayoutBuilder(
            builder: (context, constraints) {
          return Container(

             width: constraints.maxWidth,
            height: constraints.maxHeight,
             child: SingleChildScrollView(
               scrollDirection:Axis.vertical,

               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [

                   //logo
                   Column(
                     children: [
                       Container(
                         margin: EdgeInsets.only(top: constraints.maxHeight*0.1),
                         child: SvgPicture.asset(

                             'assets/fileroleic.svg',
                                    color:clrGreen,
                           height: constraints.maxHeight*0.22,

                          ),


                       ),
                       Divider(indent: double.infinity, height: 30,endIndent: double.infinity,) ,

                       Container(
                         // width: 200,
                         //   height: 200,
                           decoration: BoxDecoration(
                             //  borderRadius: BorderRadius.circular(35.0),
                           ),
                           child:
                           Image(
                             image: AssetImage('assets/filerolebanner.png' , ),
                           )),


                     ],
                   ),

                   //some space
                   Divider (height: constraints.maxHeight*0.26 , endIndent: double.infinity,indent: double.infinity,),
                   //login
                   Container(
                     padding:EdgeInsets.symmetric(horizontal:10,vertical: 5),
                     width: double.infinity,
                     height: 65,
                     decoration:
                     BoxDecoration(

                         color: Colors.blue.withOpacity(0.9),
                         borderRadius:      BorderRadius.circular(25)
                     ),

                     margin: EdgeInsets.only(left:20 , right:20 , top: constraints.maxHeight*0.02),

                     child:
                     InkWell(

                      // highlightColor: Colors.blueGrey,
                        splashColor: Colors.white,

                       onTap: (){
                          Navigator.pushNamed(context, 'login');
                       },
                       child: Row(
                         //  mainAxisAlignment: MainAxisAlignment.space,
                         children: [
                           Container(
                             padding: EdgeInsets.all(8),
                             width: 50,
                             height: 50,
                             child: SvgPicture.asset(

                               'assets/signin.svg',
                               color: Colors.blueAccent,

                               // height: 20,
                             ),
                             decoration :
                             BoxDecoration(
                                 color: Colors.white,
                                 borderRadius:      BorderRadius.circular(20)),
                           ),
                           VerticalDivider (

                             width:21 ,
                             endIndent: double.infinity,
                             indent: double.infinity,

                           ),
                           Text('Login with existing account' , style:  TextStyle(color: Colors.white , fontSize: 16.8),)
                         ],

                       ),
                     ) ,


                   ),

                   //create account
                   Container(
                     padding:EdgeInsets.symmetric(horizontal:10,vertical: 5),
                     width: double.infinity,
                     height: 65,
                     decoration:
                     BoxDecoration(
                         color: Colors.blue.withOpacity(0.9),
                         borderRadius:      BorderRadius.circular(25)
                     ),

                     margin: EdgeInsets.only(left:20 , right:20 , top: constraints.maxHeight*0.02),

                     child:
                     InkWell(
                       splashColor: Colors.white,

                       onTap: (){
                         final MyInAppBrowser browser = new MyInAppBrowser();

                         final String url = 'https://filerole.com/register';
                         browser.openUrlRequest(
                             urlRequest: URLRequest(url: Uri.parse(url)),
                             options: options);

                         // MyChromeSafariBrowser().open(
                         //     url: Uri.parse(url),
                         //     options: ChromeSafariBrowserClassOptions(
                         //
                         //         android: AndroidChromeCustomTabsOptions(   addDefaultShareMenuItem: false , showTitle: false),
                         //
                         //         ios: IOSSafariOptions(barCollapsingEnabled: true)));

                         // MyInAppBrowser().openUrlRequest(
                         //   options: options,
                         //     urlRequest: URLRequest(url: Uri.parse(url))
                         // );


                        // Navigator.pushNamed(context, 'register');
                       },
                       child: Row(
                         //  mainAxisAlignment: MainAxisAlignment.space,
                         children: [
                           Container(
                             padding: EdgeInsets.all(8),
                             width: 50,
                             height: 50,
                             child: SvgPicture.asset(

                               'assets/signup.svg',
                               color: Colors.blueAccent,

                               // height: 20,
                             ),
                             decoration :
                             BoxDecoration(
                                 color: Colors.white,
                                 borderRadius:      BorderRadius.circular(20)),
                           ),
                           VerticalDivider (

                             width:21 ,
                             endIndent: double.infinity,
                             indent: double.infinity,

                           ),
                           Text('Create a new account' , style:  TextStyle(wordSpacing:2,color: Colors.white , fontSize: 16.8),)
                         ],

                       ),
                     ) ,


                   )



                 ],
               ),
             ),
          );


            },
          )


      ),
    ) ;


  }

}
