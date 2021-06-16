


      import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

      Future<bool?> createToast(String msg , {Color ?colour}) =>
 Fluttertoast.showToast(
         msg: msg,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
        backgroundColor: colour ?? Colors.black.withOpacity(0.6),
       //  textColor: Colors.white,
         fontSize: 16.0
     );