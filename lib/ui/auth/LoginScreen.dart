import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/database/save_accounts_db.dart';
import 'package:Filerole/model/providers/LanguageProvider.dart';
import 'package:Filerole/model/pojo/LoginAuthModel.dart';
import 'package:Filerole/networking/graphql/authentication/AuthInterface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:Filerole/networking/graphql/authentication/MasterAuth.dart';
import 'package:Filerole/ui/master/master_main/MasterMainScreen.dart';
import 'package:Filerole/util/SaveAccountsSharedPref.dart';
import 'package:Filerole/util/ToastHelper.dart';
import 'package:Filerole/util/check_network_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'BarWidget.dart';

//testing login
var data = {
  "email": "hello@fr3on.info",
  "pass": "123456",
  "url": "http://test.filerolesys.com/",
  "userType": "owner",
};

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthInterface loginAuth = MasterAuth();
  int? userTypeValue = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusScopeNode? myFocusNode;
  LoginAuthModel myAuthModel = LoginAuthModel();
  bool showProgressBar = false;
  bool showPass = true;

  @override
  void initState() {
    myFocusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    myFocusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomPadding: false,
      backgroundColor: clrGrey,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Directionality(
              textDirection: TextDirection.ltr, child: formDetailsWidget()),
        ),
      ),
    );
  }

  Widget formDetailsWidget() {
    return Form(
      key: formKey,
      child: FocusScope(
        node: myFocusNode,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  formDetailsWidget(),
            Divider(
              height: 20,
              color: Colors.transparent,
            ),

            logoWidget(),
            Divider(
              height: 40,
              color: Colors.transparent,
            ),
            // Align(alignment: Alignment.centerLeft,child: Container(padding: EdgeInsets.symmetric(horizontal: 22), child: Text('Login'  ,style: TextStyle(height:1.6,fontSize: 44,fontWeight: FontWeight.w500,color: Colors.black54),))),
            // Divider(height: 7 , color: Colors.transparent,),
            chooseUserTypeWidget(),
            Divider(
              height: 9,
              color: Colors.transparent,
            ),

            serverUrlField(),
            Divider(
              height: 9,
              color: Colors.transparent,
            ),

            emailField(),
            Divider(
              height: 9,
              color: Colors.transparent,
            ),

            passwordField(),

            forgetPassBtn(),
            Stack(
              children: [
                Divider(
                  height: 18,
                  color: Colors.transparent,
                ),
                (showProgressBar)
                    ? Align(
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child: Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.blueAccent),
                              //minHeight: 1.5,
                              minHeight: 2,
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),

            loginBtn(),
            Divider(
              height: 29,
              color: Colors.transparent,
            ),
            savedBtn()
          ],
        ),
      ),
    );
  }

  Widget logoWidget() {
    return Column(
      children: [
        Container(
          child: SvgPicture.asset(
            'assets/fileroleic.svg',
            color: clrGreen,
            height: 130,
          ),
        ),
        Divider(
          indent: double.infinity,
          height: 15,
          endIndent: double.infinity,
        ),
        Container(
            // width: 200,
            //   height: 200,
            decoration: BoxDecoration(
                //  borderRadius: BorderRadius.circular(35.0),
                ),
            child: Image(
              width: 150,
              image: AssetImage(
                'assets/filerolebanner.png',
              ),
            )),
      ],
    );
  }

  Widget chooseUserTypeWidget() {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 9),
        decoration: BoxDecoration(
          //     color:Colors.white,
          borderRadius: BorderRadius.circular(20),

          gradient: new LinearGradient(colors: [
            Colors.white.withOpacity(0.4),
            Colors.white.withOpacity(0.1)
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
        child: TextButton(
          onPressed: () {
            showChooseTypeSheet(context);
          },
          child: TextFormField(
            enabled: false,
            // controller: controller,

            onSaved: (password) {
              myAuthModel.password = password;
            },
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white38,
              ),
              icon:
                  Icon(Icons.supervisor_account_outlined, color: Colors.white70

                      //  color: kPrim//aryColor,
                      ),
              hintText: myAuthModel.userType,
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
          ),
        ));
  }

  Widget serverUrlField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        //     color:Colors.white,
        borderRadius: BorderRadius.circular(20),

        gradient: new LinearGradient(colors: [
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.1)
        ], begin: Alignment.topLeft, end: Alignment.centerRight),
      ),
      //

      child: TextFormField(
        // controller: controller,
        textInputAction: TextInputAction.next,

        onEditingComplete: myFocusNode!.nextFocus,
        onSaved: (url) {
          myAuthModel.serverUrl = url;
        },
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
            icon: Icon(Icons.miscellaneous_services, color: Colors.white70),
            //hintText: hintText,
            border: InputBorder.none,
            hintText: 'Server URL',
            hintStyle: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        //     color:Colors.white,
        borderRadius: BorderRadius.circular(20),

        gradient: new LinearGradient(colors: [
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.1)
        ], begin: Alignment.topLeft, end: Alignment.centerRight),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white70),
        onSaved: (email) {
          myAuthModel.email = email;
        },
        // controller: controller,
        textInputAction: TextInputAction.next,

        onEditingComplete: myFocusNode!.nextFocus,

        decoration: InputDecoration(
            icon: Icon(Icons.email_rounded,
                //  color: kPrim//aryColor,
                color: Colors.white70),
            //hintText: hintText,
            border: InputBorder.none,
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget passwordField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        //     color:Colors.white,
        borderRadius: BorderRadius.circular(20),

        gradient: new LinearGradient(colors: [
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.1)
        ], begin: Alignment.topLeft, end: Alignment.centerRight),
      ),
      child: TextFormField(
        // controller: controller,

        onEditingComplete: myFocusNode!.nextFocus,
        onSaved: (password) {
          myAuthModel.password = password;
        },
        obscureText: showPass,
        style: TextStyle(color: Colors.white70),

        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                (showPass) ? showPass = false : showPass = true;
              });
            },
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.white38,
            ),
          ),
          icon: Icon(Icons.lock_outline, color: Colors.white70

              //  color: kPrim//aryColor,
              ),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget loginBtn() {
    return Container(
      //margin: EdgeInsets.only(left: 20,right: 20),
      padding: EdgeInsets.symmetric(horizontal: 20.5),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              // gradient: gradient
              color: clrGreen5),
          child: FlatButton(
            padding: EdgeInsets.all(16),
            //  padding:EdgeInsets.all(20) ,
            // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            // color: color,

            onPressed: () {
              setState(() {
                showProgressBar = true;
              });
              //login request
              formKey.currentState!.save();
              loginRequest();
            },
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.white,
                  height: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget savedBtn() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      //margin: EdgeInsets.only(bottom: 50 ),
      padding: EdgeInsets.symmetric(horizontal: 80),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              gradient: gradientSaved,
              // gradient: gradient
              color: Colors.blueGrey),
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'saved_acc');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                VerticalDivider(
                  width: 6,
                  color: Colors.transparent,
                ),
                Text(
                  'Saved Accounts',
                  style: TextStyle(
                      color: Colors.white,
                      height: 1,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassBtn() {
    return Container(
      padding: EdgeInsets.only(top: 8, right: 35, left: 35),
      //margin: EdgeInsets.only(bottom: 8),

      child: GestureDetector(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forget Password",
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 13,
                height: 1,
                color: Colors.white70,
                fontWeight: FontWeight.normal),
          ),
        ),
        onTap: () {
          toForgetPassScreen();
        },
      ),
    );
  }

  void loginRequest() async {
    await StaticMasterClient.client
        .loginService(
      mail: myAuthModel.email!,
      pass: myAuthModel.password!,
      serverUrl: myAuthModel.serverUrl!,
      type: myAuthModel.userType!,
    )
        .then((response) {
      // checking status code
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
            ..img = response?['user']['social_image'];
          //posting device Fcm token
          FirebaseMessaging.instance.getToken().then((tokenFcm) {
            if (tokenFcm != null) {
              print('fcmm$tokenFcm');
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
        } else {
          toStaffScreen();
        }
      } else {
        createToast(response?['errors'] ?? 'Something went wrong!',
            colour: Colors.red.withOpacity(0.6));
      }
    }).catchError((error) {
      //  createToast(error.toString());
      createToast('Check your network connection');
    });
    setState(() {
      showProgressBar = false;
    });
    //GrapQl
    // loginAuth.graphQLClientRequest(queryDoc: loginAuth.loginQuery, args: {
    //   "email": myAuthModel.email,
    //   "pass": myAuthModel.password,
    //   "url": myAuthModel.serverUrl,
    //   "userType": myAuthModel.userType,
    // }).then((response) {
    //   if (response.isNotLoading) {
    //     createToast('Type Correct Data ');
    //     // Toast.show( 'Type Correct Data ', context, duration: Toast.LENGTH_LONG,backgroundColor: Colors.red.withOpacity(0.5) ,  gravity:  Toast.BOTTOM);
    //   setState(() {
    //     showProgressBar = false;
    //   });

    //   }

    //   if (response.data!['login']['status'].toString() == "200") {
    //     StaticUserVar.userAccount.accessToken = response.data!['login']['token'];
    //     StaticUserVar.userAccount.email =
    //         response.data!['login']['user']['email'];
    //     StaticUserVar.userAccount.name =
    //         response.data!['login']['user']['name'];
    //     StaticUserVar.userAccount.phoneNumber =
    //         response.data!['login']['user']['phone_number'];
    //     StaticUserVar.userAccount.address =
    //         response.data!['login']['user']['address'];
    //     StaticUserVar.userAccount.userType =
    //         response.data!['login']['userType'];
    //     StaticUserVar.userAccount.endpoint =
    //         response.data!['login']['endPoint'];

    //     createToast(
    //         'Login success ${StaticUserVar.userAccount.endpoint} ${response.data!['login']['user']['email']}');
    //     // Toast.show( 'Login success ${StaticUserVar.  userAccount.endpoint} ${response.data ['login']['user']['email']}', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

    //     if (StaticUserVar.userAccount.userType == "owner") {
    //       toMasterScreen();
    //     }
    //     return;
    //   }
    //   setState(() {
    //     showProgressBar = false;
    //   });
    // }).catchError((n) {
    //   // Toast.show( 'Error occurred ', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    //   setState(() {
    //     showProgressBar = false;
    //   });
    // });
  }

  void toMasterScreen() {
    //checking current lang then redirect to Home Screen
    Provider.of<LanguageProvider>(context, listen: false)
        .initChangeLangUtil()
        .then((value) {
      Navigator.pushReplacementNamed(context, 'master_main');
    });
  }

  void toForgetPassScreen() {
    Navigator.pushReplacementNamed(context, 'forget_pass');
  }

  void toStaffScreen() {}

  void showChooseTypeSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
              height: 220,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  BtmSheetBar(),
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  Text('Choose User Type',
                      style: TextStyle(
                          fontSize: 20,
                          height: 1,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  Divider(
                    height: 30,
                    color: Colors.grey.shade400,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              assignUserType(0, context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/boss.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Text("Owner",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        height: 1,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black45,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              assignUserType(1, context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/stuff.png',
                                  width: 40,
                                  height: 40,
                                ),
                                Text("Stuff",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        height: 1,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black45,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void assignUserType(int typeIndex, BuildContext context) {
    myAuthModel.userType = typeIndex;
    Navigator.pop(context);
    setState(() {});
  }
}
