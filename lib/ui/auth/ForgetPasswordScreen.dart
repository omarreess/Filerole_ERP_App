import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/providers/LanguageProvider.dart';
import 'package:Filerole/model/pojo/LoginAuthModel.dart';
import 'package:Filerole/networking/graphql/authentication/AuthInterface.dart';

import 'package:Filerole/networking/graphql/authentication/MasterAuth.dart';
import 'package:Filerole/ui/master/master_main/MasterMainScreen.dart';
import 'package:Filerole/util/SaveAccountsSharedPref.dart';
import 'package:Filerole/util/ToastHelper.dart';
import 'package:Filerole/util/check_network_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'BarWidget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? mail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomPadding: false,
      backgroundColor: clrGrey,
      appBar: AppBar(
        title: Text(
          'Reset Password',
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
          Divider(
            height: 9,
            color: Colors.transparent,
          ),

          Divider(
            height: 9,
            color: Colors.transparent,
          ),

          emailField(),
          Divider(
            height: 9,
            color: Colors.transparent,
          ),

          Stack(
            children: [
              Divider(
                height: 18,
                color: Colors.transparent,
              ),
            ],
          ),

          loginBtn(),
          Divider(
            height: 29,
            color: Colors.transparent,
          ),
        ],
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
        onSaved: (mail) {
          this.mail = mail;
        },
        validator: (mail) {
          if (mail!.isEmpty
              // ||!mail.endsWith('.info')
              ) {
            return 'Please type a valid Mail';
          }
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
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
              color: clrGreen3),
          child: FlatButton(
            padding: EdgeInsets.all(16),
            //  padding:EdgeInsets.all(20) ,
            // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            // color: color,

            onPressed: () {
              //forget password request
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                forgetPassService(mail: mail);
              }
            },
            child: Text(
              'Reset Password',
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

  Future<bool> forgetPassService({
    required String? mail,
  }) async {
    bool? updateFlag;

    await StaticMasterClient.client
        .forgetPassService(
      mail: mail!,
    )
        .then((response) {
      // checking status code
      if (checkNetworkResponseStatusCode(response)) {
        //assigning new User Data

        createToast(response?['message'],
            colour: Colors.greenAccent.withOpacity(0.6));
        updateFlag = true;
      } else {
         
        createToast(response?['errors'].toString() ?? 'Something went wrong!',
            colour: Colors.red.withOpacity(0.6));
        updateFlag = false;
      }
    }).catchError((error) {
      //  createToast(error.toString());
      print('catch');
      createToast(error.toString());
      updateFlag = false;
    });
    return updateFlag!;
  }
}
