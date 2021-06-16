import 'dart:convert';

import 'package:http/http.dart';
import 'package:Filerole/networking/restful/services/login_service.dart'
    as Login;
import 'package:Filerole/networking/restful/services/forget_pass_service.dart'
    as Forget;
import 'package:Filerole/networking/restful/services/logout_service.dart'
    as Logout;
import 'package:Filerole/networking/restful/services/payments_service.dart'
    as Payments;
import 'package:Filerole/networking/restful/services/profile_update_pass_service.dart'
    as UpdatePass;
import 'package:Filerole/networking/restful/services/profile_update_service.dart'
    as UpdateData;
import 'package:Filerole/networking/restful/services/subscriptions_service.dart'
    as Subscrip;
import 'package:Filerole/networking/restful/services/user_data_service.dart'
    as User;
    import 'package:Filerole/networking/restful/services/update_fcm_token.dart'
    as FcmToken;

String? accessToken;

class MasterClient {
  String? accessToken;

  //Login
  Future<Map<String, dynamic>?> loginService(
      {required String mail,
      required String pass,
      required String type,
      required String serverUrl}) async {
    Map<String, dynamic>? responseMap;
    await Login.loginService(
      mail: mail,
      pass: pass,
      type: type,
      serverUrl: serverUrl,
    ).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();
    return responseMap;
  }

//Forget Password
  Future<Map<String, dynamic>?> forgetPassService({
    required String mail,
  }) async {
    Map<String, dynamic>? responseMap;
   await Forget.forgetPassService(
      mail: mail,
    ).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();
    return responseMap;
  }

//Logout
  Future<Map<String, dynamic>?> logoutService({String? token}) async {
    Map<String, dynamic>? responseMap;
    Logout.logoutService(token: accessToken ?? token!).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();
    return responseMap;
  }

//Payments
  Future<Map<String, dynamic>?> paymentsService({String? token}) async {
    Map<String, dynamic>? responseMap;

  await  Payments.paymentsService(token: accessToken ?? token!).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();

    return responseMap;
  }

//Profile Update Password
  Future<Map<String, dynamic>?> profileUpdatePassService({
    String? token,
    required String currentPass,
    required String newPass,
    required String newPassRe,
  }) async {
    Map<String, dynamic>? responseMap;
    await UpdatePass.profileUpdatePassService(
      token: accessToken ?? token!,
      currentPass: currentPass,
      newPass: newPass,
      newPassRe: newPassRe,
    ).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();
    print('catchh'+responseMap.toString());
    return responseMap;
  }

//Profile Update Data
  Future<Map<String, dynamic>?> profileUpdateService({
    String? token,
    String? mail,
    String? firstName,
    String? lastName,
    String? phoneNo,
  }) async {
    Map<String, dynamic>? responseMap;

    await UpdateData.profileUpdateService(
      token: accessToken ?? token!,
      firstName: firstName,
      lastName: lastName,
      mail: mail,
      phoneNo: phoneNo,
    ).then((response) {
      responseMap = json.decode(response!.body);
    });

    //.catchError();
    return responseMap;
  }

//Subscriptions
  Future<Map<String, dynamic>?> subscriptionsService({
    String? token,
  }) async {
    Map<String, dynamic>? responseMap;
  await  Subscrip.subscriptionsService(
      token: accessToken ?? token!,
    ).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();
    return responseMap;
  }

//User Data 
  Future<Map<String, dynamic>?> userDataService({
    String? token,
  }) async {
    Map<String, dynamic>? responseMap;

    User.profileUpdateService(
      token: accessToken ?? token!,
    ).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();
    return responseMap;
  }
  //Posting FCM Token
  Future<Map<String, dynamic>?> tokenFcmService ({
     required String  token,
   required String  tokenFcm,
  }) async {
    
    Map<String, dynamic>? responseMap;
    await FcmToken.updateFcmTokenService(
      token: token   ,
      tokenFcm: tokenFcm   ,
    ).then((response) {
      responseMap = json.decode(response!.body);
    });
    //.catchError();
    return responseMap;
  }
}

//For Mocking
/*
      mail: 'hello@fr3on.info',
      pass: 'motion',
      type: 'owner',
      serverUrl: 'fr3on.filerole.com',
       */

/*

final client = MasterClient();
    client        .loginService(
      mail: 'hello@fr3on.info',
      pass: 'motion',
      type: 'owner',
      serverUrl: 'fr3on.filerole.com',
    )
        .then((value) {
          
     });

*/
