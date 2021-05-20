


      import 'package:fluttertoast/fluttertoast.dart';

      Future<bool?> createToast(String msg) =>
 Fluttertoast.showToast(
         msg: msg,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
       //  backgroundColor: Colors.red,
       //  textColor: Colors.white,
         fontSize: 16.0
     );