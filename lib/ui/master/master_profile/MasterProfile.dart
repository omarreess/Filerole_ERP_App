import 'dart:convert';
import 'dart:io';

import 'package:Filerole/generated/l10n.dart';
import 'package:Filerole/model/constants/Constants.dart';
import 'package:Filerole/model/pojo/MasterProfileDetailsModel.dart';
import 'package:Filerole/model/pojo/MasterAccountModel.dart';
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/ui/master/master_main/MasterMainScreen.dart';
import 'package:Filerole/util/ToastHelper.dart';
import 'package:Filerole/util/check_network_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

//Screen States
enum ButtonTypes {
  savingBtn,
  changePass,
}

class MasterProfile extends StatefulWidget {
  //test data
  MasterProfileDetailsModel masterProfile = MasterProfileDetailsModel(
    imgUrl:
        'https://instagram.fcai21-2.fna.fbcdn.net/v/t51.2885-15/e15/s320x320/11257032_692162207576745_1286537254_n.jpg?tp=1&_nc_ht=instagram.fcai21-2.fna.fbcdn.net&_nc_cat=109&_nc_ohc=TNm79m_HHyIAX-GRepl&oh=e6f61ba9f928ee4e85f776c74958f16f&oe=607A40CD',
    email: 'moabdallah@gmail.com',
    firstName: 'Mohammed',
    lastName: 'Abdallah',
    phone: '+201097081508',
  );

  @override
  _MasterProfileState createState() => _MasterProfileState();
}

class _MasterProfileState extends State<MasterProfile> {
  bool showPass = true;
  bool imgFromFile = false;
  late File newImg;

  //Form key
  final formKey = GlobalKey<FormState>();
  //flag var to switch between Details Screen & Change pass Screen
  bool changePassword = false;
  //password vars
  String? oldPass, newPass, rePass;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding:
              const EdgeInsets.only(bottom: 20, top: 0, left: 17, right: 17),
          child: Column(
            children: [
              //page head

              SizedBox(
                  width: double.infinity,
                  child: Text(S.of(context).master_label_profile,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          height: 1.5,
                          fontSize: 23))),
              Divider(
                color: Colors.transparent,
                height: 3,
              ),

              //master profile picture
              masterProfilePictureWidget(),
              Divider(
                color: Colors.transparent,
                height: 15,
              ),

              //profile form details
              profileFormDetailsWidget(changePassword),

              //saving button + change password button
              Row(
                children: [
                  Expanded(child: savingButton(ButtonTypes.changePass)),
                  VerticalDivider(
                    color: Colors.transparent,
                    width: 6,
                  ),
                  Expanded(child: savingButton(ButtonTypes.savingBtn)),
                ],
              ),
              Divider(
                color: Colors.transparent,
                height: 10,
              ),
            ],
          )),
    );
  }

  Widget masterProfilePictureWidget() {
    return Container(
      width: 160,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(17),
              width: double.infinity,
              height: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: (imgFromFile)
                      ? Image.file(
                          newImg,
                          //  fit: BoxFit.fill,
                        )
                      : Image.network(
                          StaticUserVar.userAccount.img!,
                          fit: BoxFit.fill,
                        )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: IconButton(
                  onPressed: () {
                    getImgFromGallery();
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subHeadTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 15.8,
          height: 1,
          fontWeight: FontWeight.w800,
          color: Colors.black45),
    );
  }

  Widget savingButton(ButtonTypes btnType) {
    if (btnType == ButtonTypes.savingBtn) {
      return Container(
        height: 50,
        child: FlatButton(
          color: Colors.blue,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          //color: clrGreen3,

          onPressed: () {
            formKey.currentState!.save();

            //check current screen state
            (changePassword)
                ? updateProfilePassword(
                    oldUserData: StaticUserVar.userAccount,
                    currentPass: oldPass,
                    newPass: newPass,
                    rePass: rePass)
                : updateProfileData(
                    firstName: widget.masterProfile.firstName,
                    lastName: widget.masterProfile.lastName,
                    oldUserData: StaticUserVar.userAccount,
                    phoneNo: widget.masterProfile.phone,
                    token: StaticUserVar.userAccount.accessToken,
                  );
          },
          child: Text(
            S.of(context).save_edits.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                wordSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return Container(
        height: 50,
        child: OutlineButton(
          borderSide: BorderSide(color: Colors.blue.withOpacity(0.5), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          //color: clrGreen3,

          onPressed: () {
            setState(() {
              //repaint screen with change password UI
              (changePassword) ? changePassword = false : changePassword = true;
            });
          },
          child: Text(
            S.of(context).change_password.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                wordSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  Widget profileFormDetailsWidget(bool changePassword) {
    //Switching between normal profile details screen & Change password Screen
    //depends on bool flag that's changing from buttons

    return Form(
        key: formKey,
        child: (changePassword)
            ? changePassProfileWidgets()
            : normalDetailsProfileWidgets());
  }

  Widget normalDetailsProfileWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //first & last name
        Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subHeadTitle(S.of(context).first_name),
                  Container(
                    margin: EdgeInsets.only(top: 5.5, bottom: 30),
                    decoration: BoxDecoration(
                      // color: clrInputBackground,
                      border: Border.all(
                        color: clrBorder,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onSaved: (item) {
                          if (item?.isNotEmpty ?? false)
                            widget.masterProfile.firstName = item;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          border: InputBorder.none,
                          hintText: StaticUserVar.userAccount.firstName,
                          hintStyle: TextStyle(color: Colors.black45),
                        )),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subHeadTitle(S.of(context).last_time),
                  Container(
                    margin: EdgeInsets.only(top: 5.5, bottom: 30),
                    decoration: BoxDecoration(
                      //color: clrInputBackground,

                      border: Border.all(
                        color: clrBorder,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onSaved: (item) {
                          if (item?.isNotEmpty ?? false)
                            widget.masterProfile.lastName = item;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          border: InputBorder.none,
                          hintText: StaticUserVar.userAccount.lastName,
                          hintStyle: TextStyle(color: Colors.black45),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),

        //email address
        subHeadTitle(
          S.of(context).email,
        ),
        Container(
          margin: EdgeInsets.only(top: 5.5, bottom: 30),
          decoration: BoxDecoration(
            //  color: clrInputBackground,
            border: Border.all(
              color: clrBorder,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (item) {
                if (item?.isNotEmpty ?? false)
                  widget.masterProfile.email = item;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.mail_outline,
                  color: clrGreen2,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                border: InputBorder.none,
                hintText: StaticUserVar.userAccount.email,
                hintStyle: TextStyle(color: Colors.black45),
              )),
        ),

        //phone
        subHeadTitle(
          S.of(context).phone_number,
        ),

        Container(
          margin: EdgeInsets.only(top: 5.5, bottom: 30),
          decoration: BoxDecoration(
            //  color: clrInputBackground,
            border: Border.all(
              color: clrBorder,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (item) {
                if (item?.isNotEmpty ?? false)
                  widget.masterProfile.phone = item;
              },

              //style: TextStyle(height:2),

              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.phone_android_outlined,
                  color: clrGreen2,
                ),
                hintText: StaticUserVar.userAccount.phoneNumber,
                hintStyle: TextStyle(color: Colors.black45),
              )),
        ),
      ],
    );
  }

  Widget changePassProfileWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //old pass
        subHeadTitle(
          S.of(context).password_old,
        ),

        Container(
          margin: EdgeInsets.only(top: 5.5, bottom: 30),
          decoration: BoxDecoration(
            //  color: clrInputBackground,
            border: Border.all(
              color: clrBorder,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (item) {
                if (item?.isNotEmpty ?? false) oldPass = item;
              },

              //style: TextStyle(height:2),

              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.lock_outline,
                  color: clrGreen2,
                ),
                hintStyle: TextStyle(color: Colors.black45),
              )),
        ),

        //new pass
        subHeadTitle(
          S.of(context).password_new,
        ),

        Container(
          margin: EdgeInsets.only(top: 5.5, bottom: 30),
          decoration: BoxDecoration(
            // color: clrInputBackground,
            border: Border.all(
              color: clrBorder,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (item) {
                if (item?.isNotEmpty ?? false) newPass = item;
              },

              //style: TextStyle(height:2),

              keyboardType: TextInputType.text,
              obscureText: showPass,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      (showPass) ? showPass = false : showPass = true;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: clrBorder,
                  ),
                ),
                hintStyle: TextStyle(color: Colors.black45),
              )),
        ),

        //re-type pass
        subHeadTitle(
          S.of(context).password_retype,
        ),

        Container(
          margin: EdgeInsets.only(top: 5.5, bottom: 30),
          decoration: BoxDecoration(
            //   color: clrInputBackground,
            border: Border.all(
              color: clrBorder,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
              obscureText: showPass,
              obscuringCharacter: '•',
              textInputAction: TextInputAction.next,
              onSaved: (item) {
                if (item?.isNotEmpty ?? false) rePass = item;
                //  widget.masterProfile.=item;
              },

              //style: TextStyle(height:2),

              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      (showPass) ? showPass = false : showPass = true;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: clrBorder,
                  ),
                ),
                hintStyle: TextStyle(color: Colors.black45),
              )),
        ),
      ],
    );
  }

  getImgFromGallery() async {
    final picker = ImagePicker();
    PickedFile? pickedFile = await picker.getImage(
      //return file
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      newImg = File(pickedFile.path);
      uploadUserImg(img: newImg, userData: StaticUserVar.userAccount);
      setState(() {
        imgFromFile = true;
      });
    }
  }
}

Future<bool> updateProfileData({
  String? firstName,
  String? lastName,
  String? phoneNo,
  String? token,
  String? mail,
  MasterAccountModel? oldUserData,
}) async {
  bool? updateFlag;

  await StaticMasterClient.client
      .profileUpdateService(
    mail: mail ?? oldUserData?.email,
    firstName: firstName ?? oldUserData?.firstName,
    lastName: lastName ?? oldUserData?.lastName,
    phoneNo: phoneNo ?? oldUserData?.phoneNumber,
    token: token ?? oldUserData?.accessToken,
  )
      .then((response) {
    // checking status code
    if (checkNetworkResponseStatusCode(response)) {
      //assigning new User Data

      StaticUserVar.userAccount.accessToken = response?['token'];
      StaticUserVar.userAccount.name =
          response?['user']['name'] + ' ' + response?['user']['name_en'];
      //  print('new ${StaticUserVar.userAccount.name}');
      StaticUserVar.userAccount.firstName = response?['user']['name'];
      StaticUserVar.userAccount.lastName = response?['user']['name_en'];
      StaticUserVar.userAccount.email = response?['user']['email'];
      StaticUserVar.userAccount.phoneNumber =
          response?['user']['phone_number'].toString();
      StaticUserVar.userAccount.img = response?['user']['social_image'];

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
    createToast(error ?? 'Check your network connection');
    updateFlag = false;
  });
  return updateFlag!;
}

Future<bool> updateProfilePassword({
  String? currentPass,
  String? newPass,
  String? rePass,
  String? token,
  required MasterAccountModel? oldUserData,
}) async {
  bool? updateFlag;

  await StaticMasterClient.client
      .profileUpdatePassService(
    currentPass: currentPass!,
    newPass: newPass!,
    newPassRe: rePass!,
    token: token ?? oldUserData?.accessToken,
  )
      .then((response) {
    // checking status code
    if (checkNetworkResponseStatusCode(response)) {
      //assigning new User Data

      StaticUserVar.userAccount.accessToken = response?['token'];

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

//upload profile pic
uploadUserImg({required File img, required MasterAccountModel userData}) async {
  final masterEndpoints = MasterEndpoints();
  final url = '${masterEndpoints.baseUrl}${masterEndpoints.profileUpdate}';

  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.headers.addAll({
    "Content-Type": "application/json",
    'Authorization': 'Bearer ${userData.accessToken} ',
  });
  request.fields.addAll({
    'email': '${userData.email}',
     'first_name': '${userData.firstName}',
    'last_name': '${userData.lastName}',
    'phone_number': '${userData.phoneNumber}'
  });

  request.files.add(http.MultipartFile.fromBytes('image', img.readAsBytesSync(),
       filename: img.path
      ));
  request.send().then((response) {
    response.stream.transform(utf8.decoder).listen((value) {

      // createToast(value.toString());
      // print(value);
    });
    //   createToast(response. toString()); //message json.decode(response!.body);
  });
}
